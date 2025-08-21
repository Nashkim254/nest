import 'package:logger/logger.dart';
import 'package:nest/services/message_service.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/chats.dart';
import '../../../models/message_models.dart';

class MessagesViewModel extends BaseViewModel {
  final MessageService _messagingService = locator<MessageService>();
  final List<Chats> chats = [
    Chats(
      id: '1',
      senderName: 'Sarah J.',
      senderImage: avatar,
      message: 'Sounds good! See you then!',
      time: '10:38 AM',
      unreadCount: 2,
    ),
    Chats(
      id: '2',
      senderName: 'Alex M.',
      senderImage: avatar,
      message: "Don't forget about the afterparty!",
      time: 'Yesterday',
    ),
    Chats(
      id: '3',
      senderName: 'Party Crew',
      senderImage: avatar,
      message: "We're meeting at the entrance.",
      time: 'Mon',
      unreadCount: 5,
    ),
    Chats(
      id: '4',
      senderName: 'DJ Beat',
      senderImage: avatar,
      message: "Thanks for coming to the show!",
      time: 'Last Week',
    ),
    Chats(
      id: '5',
      senderName: 'Event Organizers',
      senderImage: avatar,
      message: "Your tickets have been confirmed.",
      time: '03/15',
    ),
  ];

  goToChatDetail(Chats chat) {
    locator<NavigationService>()
        .navigateTo(Routes.chatView, arguments: ChatViewArguments(chat: chat));
  }

  init() async {
    await getConversations();
  }

  Logger logger = Logger();
  List<Conversation> conversations = [];
  Future getConversations() async {
    try {
      final response = await _messagingService.fetchConversations();
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Conversations fetched successfully: ${response.data}');
        final conversationsList = response.data['conversations'];

        logger.i(conversations);
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
    }
  }
}
