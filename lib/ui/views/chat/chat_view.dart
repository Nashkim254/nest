import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/chat/widgets/chat_bubble.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/chats.dart';
import '../../../models/message_models.dart';
import '../../../services/shared_preferences_service.dart';
import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  const ChatView({Key? key, required this.chat}) : super(key: key);
  final Conversation chat;
  @override
  Widget builder(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: kcWhiteColor,
        ),
        backgroundColor: kcDarkColor,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(avatar),
              backgroundColor: kcPrimaryColor,
            ),
            horizontalSpaceMedium,
            Text(
              chat.messages.last.sender!.name,
              style: titleTextMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacedDivider,
            ListView.builder(
              shrinkWrap: true,
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: chat.messages[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          spacedDivider,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: SvgPicture.asset(emoji),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: SvgPicture.asset(attach),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.messageController,
                    decoration: AppInputDecoration.standard(
                      hintText: 'Message...',
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: SvgPicture.asset(send),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel(
        conversationId: chat.conversationId,
        receiverId: chat.participantIds
            .where((i) =>
                i != locator<SharedPreferencesService>().getUserInfo()!['id'])
            .first,
      );
}
