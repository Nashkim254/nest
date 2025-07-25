import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/messages/widgets/chat_list_card.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import 'messages_viewmodel.dart';

class MessagesView extends StackedView<MessagesViewModel> {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MessagesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kcDarkColor,
          title: Text(
            "Messages",
            style: titleTextMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                // Handle share action
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(msg),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacedDivider,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: viewModel.chats.length,
                  itemBuilder: (context, index) {
                    return ChatListItem(
                      chat: viewModel.chats[index],
                      onTap: () => viewModel.goToChatDetail(
                        viewModel.chats[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => spacedDivider,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  MessagesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MessagesViewModel();
}
