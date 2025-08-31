import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.bottomsheets.dart';
import 'package:nest/models/user_serach_ressult.dart';
import 'package:nest/services/message_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/message_models.dart';
import '../../../services/shared_preferences_service.dart';

class MessagesViewModel extends BaseViewModel {
  final MessageService _messagingService = locator<MessageService>();
  final bottomSheet = locator<BottomSheetService>();
  int currentUserId = locator<SharedPreferencesService>().getUserInfo()!['id'];
  bool isSender = true;
  goToChatDetail(Conversation chat) {
    locator<NavigationService>()
        .navigateTo(Routes.chatView, arguments: ChatViewArguments(chat: chat));
  }

  init() async {
    await getConversations();
  }

  Logger logger = Logger();
  List<Conversation> conversations = [];
  Future getConversations() async {
    setBusy(true);
    try {
      final response = await _messagingService.fetchConversations();
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Conversations fetched successfully: ${response.data}',
            wrapWidth: 1024);
        final conversationsList = response.data['conversations'] ?? [];

        final parsedConversations = conversationsList
            .map<Conversation?>((e) {
              try {
                return Conversation.fromJson(e);
              } catch (e) {
                logger.e('Failed to parse conv: $e\nError: $e');
                return null;
              }
            })
            .whereType<Conversation>()
            .toList();
        conversations = parsedConversations;
        return response.data;
      } else {
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load conversations',
          duration: const Duration(seconds: 3),
        );
        throw Exception('Failed to load conversations: ${response.message}');
      }
    } catch (e, s) {
      logger.e('Error fetching conversations: $e');
      logger.e('Error fetching conversations: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Error fetching conversations: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  startNewChat() async {
    final response = bottomSheet.showCustomSheet(
      variant: BottomSheetType.tagPeople,
      title: 'Add Team Member',
      isScrollControlled: true,
      barrierDismissible: true,
    );
    response.then((sheetResponse) {
      if (sheetResponse?.confirmed == true && sheetResponse?.data != null) {
        var data = sheetResponse!.data as List<UserSearchResult>;
        if (data.isEmpty) {
          locator<SnackbarService>().showSnackbar(
            message: 'No user selected',
            duration: const Duration(seconds: 3),
          );
          return;
        } else {
          locator<NavigationService>().navigateTo(
            Routes.chatView,
            arguments: ChatViewArguments(
              chat: null,
              user: data.first,
            ),
          ); // start new chat with first user
        }

        logger.i('Data from sheet: ${data.first.toJson()}');
        notifyListeners();
      }
    });
  }
}
