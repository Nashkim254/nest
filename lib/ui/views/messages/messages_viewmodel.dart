import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/views/chat/chat_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/chats.dart';

class MessagesViewModel extends BaseViewModel {
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
}
