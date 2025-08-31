import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/messages/widgets/chat_list_card.dart';
import 'package:stacked/stacked.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import 'messages_viewmodel.dart';

class MessagesView extends StackedView<MessagesViewModel> {
  const MessagesView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(MessagesViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

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
        body: _buildBody(viewModel),
      ),
    );
  }

  Widget _buildBody(MessagesViewModel viewModel) {
    if (viewModel.isBusy) {
      return _buildLoadingState();
    }

    if (viewModel.conversations.isEmpty) {
      return _buildEmptyState(viewModel);
    }

    return _buildMessagesList(viewModel);
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacedDivider,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 30,
            ),
            child: _buildShimmerLoader(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(MessagesViewModel viewModel) {
    return SingleChildScrollView(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.conversations.length,
              itemBuilder: (context, index) {
                return ChatListItem(
                  chat: viewModel.conversations[index],
                  onTap: () => viewModel.goToChatDetail(
                    viewModel.conversations[index],
                  ),
                  currentUserId: viewModel.currentUserId,
                );
              },
              separatorBuilder: (context, index) => spacedDivider,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(MessagesViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon/illustration
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  messages,
                  height: 40,
                  width: 40,
                  fit: BoxFit.scaleDown,
                )),
            const SizedBox(height: 32),

            // Empty state title
            Text(
              "No Messages Yet",
              style: titleTextMedium.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Empty state description
            Text(
              "Start a conversation with someone to see your messages here. All your chats will appear in this list.",
              style: bodyTextMedium.copyWith(
                fontSize: 16,
                color: Colors.grey[400],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Action button (optional)
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to contacts or start new chat
                viewModel.startNewChat();
              },
              icon: const Icon(Icons.add_comment, size: 20),
              label: const Text("Start New Chat"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                foregroundColor: kcWhiteColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8, // Show 8 shimmer items
      itemBuilder: (context, index) => _buildShimmerItem(context),
      separatorBuilder: (context, index) => spacedDivider,
    );
  }

  Widget _buildShimmerItem(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Avatar shimmer
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name shimmer
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Message shimmer
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Time shimmer
                Container(
                  height: 12,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                // Badge shimmer (optional)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
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
