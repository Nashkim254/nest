import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/send_message_request.dart';
import 'package:nest/services/global_service.dart';
import 'package:nest/services/message_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_urls.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/message_models.dart';
import '../../../services/auth_service.dart';
import '../../../services/file_service.dart';
import '../../common/app_enums.dart';
import 'package:path/path.dart' as p;

class ChatViewModel extends ReactiveViewModel {
  TextEditingController messageController = TextEditingController();
  final authService = locator<AuthService>();
  final global = locator<GlobalService>();
  Logger logger = Logger();
  final MessageService _messagingService = locator<MessageService>();

  int? conversationId;
  int? receiverId;
  int? currentUserId = locator<SharedPreferencesService>().getUserInfo()!['id'];

  bool _isTyping = false;
  Timer? _typingTimer;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [fileService, _messagingService, global];

  // Getters
  List<Message> get chats =>
      _messagingService.getConversationMessages(conversationId ?? 0);
  Set<int> get typingUsers => _messagingService.getTypingUsers(conversationId!);
  WebSocketConnectionStatus get connectionStatus =>
      _messagingService.connectionStatus;
  bool get isConnected =>
      connectionStatus == WebSocketConnectionStatus.connected;

  String get connectionStatusText {
    switch (connectionStatus) {
      case WebSocketConnectionStatus.connected:
        return 'Connected';
      case WebSocketConnectionStatus.connecting:
        return 'Connecting...';
      case WebSocketConnectionStatus.disconnected:
        return 'Disconnected';
      case WebSocketConnectionStatus.error:
        return 'Connection Error';
    }
  }

  int get userId => locator<SharedPreferencesService>().getUserInfo()!['id'];

  // Message sending
  Future<void> sendMessage() async {
    logger.i('uploadFileUrl: $uploadFileUrl');
    final content = messageController.text.trim();
    if ((content.isEmpty && uploadFileUrl.isEmpty) || !isConnected) return;

    // Clear the input immediately
    messageController.clear();

    // Stop typing indicator
    if (_isTyping) {
      await _stopTyping();
    }
    // Create local message for immediate UI update

    Logger().d('Sending message: $content to conversation: $receiverId');
    // Add to local messages immediately
    //send api
    SendMessageRequest request = SendMessageRequest(
      messageType: uploadFileUrl.isEmpty ? 'text' : 'file',
      receiverId: receiverId,
      conversationId: conversationId,
      content: content,
      fileUrl: uploadFileUrl.isEmpty ? null : uploadFileUrl,
    );
    logger.i('request: ${locator<SharedPreferencesService>().getAuthToken()}');
    // await sendMessageApi(request);
    // Send through WebSocket
    final success = await _messagingService.sendMessage(
      receiverId: receiverId,
      content: content,
      conversationId: conversationId,
    );

    // if (success) {
    //   logger.w('Message sent successfully via WebSocket');
    //   final localMessage = Message(
    //     senderId: userId,
    //     receiverId: receiverId,
    //     conversationId: conversationId!,
    //     content: content,
    //     messageType: 'text',
    //     createdAt: DateTime.now(),
    //   );
    //   logger.i('message:$localMessage');
    //   _messagingService.addLocalMessage(conversationId!, localMessage);
    //   // Handle send failure - maybe show error or retry
    //   // For now, the local message will remain
    // }
  }

  Future sendMessageApi(SendMessageRequest message) async {
    try {
      final response = await _messagingService.sendMessageApi(message);
      if (response.statusCode == 200 || response.statusCode == 201) {
        conversationId =
            int.parse(response.data['message']['conversation_id'].toString());
        final localMessage = Message(
          senderId: userId,
          receiverId: receiverId,
          conversationId: conversationId!,
          content: response.data['message']['content'],
          fileUrl: response.data['message']['file_url'].isEmpty
              ? null
              : response.data['message']['file_url'],
          messageType:
              response.data['message']['file_url'].isEmpty ? 'text' : 'file',
          createdAt: DateTime.now(),
        );
        _messagingService.addLocalMessage(conversationId!, localMessage);
        clearSelectedImage();
      }

      logger.i(response.data);
    } catch (e, s) {
      logger.e(s);
      logger.e(e);
    }
  }

  Future fetchConversationMessages() async {
    setBusy(true);
    try {
      final response =
          await _messagingService.fetchConversationMessages(conversationId!);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final messageResponse = MessageResponse.fromJson(response.data);

        // Set all fetched messages using the method i created earlier
        _messagingService.setConversationMessages(
          conversationId!,
          messageResponse.messages.reversed.toList(),
        );
      }
      logger.i(chats.length);
    } catch (e, s) {
      logger.e(s);
      logger.e(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> createGroup() async {
    final content = messageController.text.trim();
    if ((content.isEmpty && uploadFileUrl.isEmpty) || !isConnected) return;

    // Clear the input immediately
    messageController.clear();

    // Stop typing indicator
    if (_isTyping) {
      await _stopTyping();
    }
    // Create local message for immediate UI update
    final localMessage = Message(
      senderId: userId,
      receiverId: receiverId,
      conversationId: conversationId!,
      content: content,
      messageType: 'text',
      createdAt: DateTime.now(),
    );
    Logger().d('Sending message: $content to conversation: $receiverId');
    // Add to local messages immediately
    _messagingService.addLocalMessage(conversationId!, localMessage);

    // Send through WebSocket
    final success = await _messagingService.sendMessage(
      receiverId: receiverId,
      content: content,
      conversationId: conversationId!,
    );

    if (!success) {
      // Handle send failure - maybe show error or retry
      // For now, the local message will remain
    }
  }

  // Typing indicators
  void onMessageChanged(String text) {
    if (text.isNotEmpty && !_isTyping) {
      _startTyping();
    } else if (text.isEmpty && _isTyping) {
      _stopTyping();
    }

    // Reset typing timer
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _stopTyping();
      }
    });
  }

  Future<void> _startTyping() async {
    _isTyping = true;
    await _messagingService.sendTypingIndicator(
      conversationId: conversationId!,
      isTyping: true,
    );
  }

  Future<void> _stopTyping() async {
    _isTyping = false;
    _typingTimer?.cancel();
    await _messagingService.sendTypingIndicator(
      conversationId: conversationId!,
      isTyping: false,
    );
  }

  init(int receiverId, int conversationId) async {
    this.receiverId = receiverId;
    this.conversationId = conversationId;

    await fetchConversationMessages();
    connect();
    // await createConversation();
  }

  // Connection management
  Future<void> connect() async {
    logger.e('Connecting to WebSocket...');
    await _messagingService.connect(
      AppUrls.websocketUrl,
      authService.prefsService.getAuthToken()!, // Replace with actual token
    );
  }

  void markMessageAsRead(Message message) {
    if (message.id != null && !message.isRead) {
      _messagingService.markMessageAsRead(
        messageId: message.id!,
        conversationId: conversationId!,
      );
    }
  }

  Future createConversation() async {
    List<int> participantIds = [userId, receiverId!];
    var body = {
      "participant_ids": participantIds,
      "group_name": '$receiverId-$userId',
      "group_avatar": ''
    };
    Logger().d('Creating conversation with body: $body');
    try {
      final response = await _messagingService.createGroupConvo(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger().d('Conversation created successfully');
        Logger().d('Conversation created: ${response.data}');
      }
    } catch (e) {
      Logger().e('Error creating conversation: $e');
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _typingTimer?.cancel();
    if (_isTyping) {
      _stopTyping();
    }
    super.dispose();
  }

  final fileService = locator<FileService>();

  List<File> get selectedImages => fileService.selectedImages;

  bool get hasImages => selectedImages.isNotEmpty;

  final _bottomSheetService = locator<BottomSheetService>();

  Future<void> showImageSourceSheet(FileType fileType) async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.imageSource,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      ImageSourceType sourceType = response!.data as ImageSourceType;

      switch (sourceType) {
        case ImageSourceType.camera:
          await fileService.pickImageFromCamera(fileType);
          break;
        case ImageSourceType.gallery:
          await fileService.pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          await fileService.pickMultipleImages();
          break;
      }
      if (selectedImages.isNotEmpty) {
        await getProfileUploadUrl();
      }
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  String uploadFileUrl = '';
  Future getProfileUploadUrl() async {
    setBusy(true);
    try {
      final response = await global.uploadFileGetURL(
          getFileExtension(
            selectedImages.first,
          ),
          folder: 'profile');
      if (response.statusCode == 200 && response.data != null) {
        uploadFileUrl = response.data['url'];
        final result = await global.uploadFile(
          response.data['upload_url'],
          selectedImages.first,
        );
        if (result.statusCode == 200 || result.statusCode == 201) {
          fileService.clearSelectedImages();
        }
        logger.i('upload url: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load upload url:');
      }
    } catch (e, s) {
      logger.e('Failed to load upload url:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload url:: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  void clearSelectedImage() {
    uploadFileUrl = '';
    rebuildUi(); // or notifyListeners() if you're using ChangeNotifier
  }

  goToOtherProfile(int userId) {
    global.setOtherUserId = userId;
    locator<NavigationService>().navigateToProfileView(isOtherUser: true);
  }
}
