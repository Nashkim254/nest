import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/user_serach_ressult.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/chat/widgets/chat_bubble.dart';
import 'package:nest/ui/views/chat/widgets/shimmer_loader.dart';
import 'package:nest/ui/views/messages/widgets/helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/message_models.dart';
import '../../../utils/utilities.dart';
import '../../common/app_colors.dart';
import '../../common/app_enums.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../edit_profile/widgets/emoji_picker.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  const ChatView({
    Key? key,
    required this.chat, // Add currentUserId parameter
    this.user,
  }) : super(key: key);

  final Conversation? chat;
  final UserSearchResult? user;

  @override
  void onViewModelReady(ChatViewModel viewModel) {
    //if user is not null get from local storage

    // Pass the current user ID to the viewModel
    viewModel.init(chat!.participantIds!.last, chat!.id!);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.isBusy) {
      return const ChatShimmerLoader();
    }

    // Get the other participant's information
    final otherUser = chat!.getOtherParticipant(viewModel.currentUserId!);
    final displayName = chat!.getDisplayName(viewModel.currentUserId!);
    final displayAvatar = chat!.getDisplayAvatar(viewModel.currentUserId!);

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
            InkWell(
              onTap: ()=> viewModel.goToOtherProfile(otherUser!.id!),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: displayAvatar != null && displayAvatar.isNotEmpty
                    ? NetworkImage(displayAvatar)
                    : null,
                backgroundColor: kcPrimaryColor,
                child: displayAvatar == null || displayAvatar.isEmpty
                    ? Text(
                        displayName.isNotEmpty
                            ? displayName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
            horizontalSpaceMedium,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    style: titleTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Optional: Show online status or last seen
                  if (!chat!.isGroup && otherUser?.lastActive != null)
                    Text(
                      _getLastSeenText(otherUser!.lastActive!),
                      style: titleTextMedium.copyWith(
                        fontSize: 12,
                        color: kcSubtitleText2Color,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          spacedDivider,
          // Messages area
          Expanded(
            child: viewModel.chats.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet',
                      style: titleTextMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: kcDisableIconColor,
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: true, // Show latest messages at bottom
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: viewModel.chats.length,
                    itemBuilder: (context, index) {
                      // Reverse the index to show latest messages at bottom
                      final message =
                          viewModel.chats[viewModel.chats.length - 1 - index];
                      return ChatBubble(
                        message: message,
                        currentUserId: viewModel.currentUserId!,
                      );
                    },
                  ),
          ),
          // Message input area
          Container(
            decoration: BoxDecoration(
              color: kcDarkColor,
              border: Border(
                top: BorderSide(color: kcSubtitleText2Color.withOpacity(0.1)),
              ),
            ),
            child: Column(
              children: [
                // Image preview section - show when image is selected
                if (viewModel.uploadFileUrl.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Image preview
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kcPrimaryColor, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: viewModel.uploadFileUrl.startsWith('http')
                                ? Image.network(
                                    viewModel.uploadFileUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color:
                                          kcSubtitleText2Color.withOpacity(0.3),
                                      child: const Icon(Icons.image,
                                          color: kcWhiteColor),
                                    ),
                                  )
                                : Image.file(
                                    File(viewModel.selectedImages.first.path),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color:
                                          kcSubtitleText2Color.withOpacity(0.3),
                                      child: const Icon(Icons.image,
                                          color: kcWhiteColor),
                                    ),
                                  ),
                          ),
                        ),
                        horizontalSpaceSmall,
                        // Image info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image selected',
                                style: titleTextMedium.copyWith(
                                  color: kcWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Ready to send',
                                style: titleTextMedium.copyWith(
                                  color: kcPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Remove button
                        InkWell(
                          onTap: () => viewModel
                              .clearSelectedImage(), // Add this method to your viewModel
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: kcSubtitleText2Color.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: kcWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Message input row
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      InkWell(
                        child: SvgPicture.asset(
                          emoji,
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => CustomEmojiPicker(
                              onEmojiSelected: (emoji) {
                                // Add emoji to text field
                                final currentText = viewModel.messageController.text;
                                final selection = viewModel.messageController.selection;

                                final newText = currentText.replaceRange(
                                  selection.start,
                                  selection.end,
                                  emoji,
                                );

                                viewModel.messageController.text = newText;
                                viewModel.messageController.selection = TextSelection.collapsed(
                                  offset: selection.start + emoji.length,
                                );

                                Navigator.pop(context); // Close the emoji picker
                              },
                            ),
                          );
                        },
                      ),
                      horizontalSpaceSmall,
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: viewModel.uploadFileUrl.isNotEmpty
                              ? BoxDecoration(
                                  color: kcPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: kcPrimaryColor, width: 1),
                                )
                              : null,
                          child: SvgPicture.asset(
                            attach,
                            width: 24,
                            height: 24,
                            color: viewModel.uploadFileUrl.isNotEmpty
                                ? kcPrimaryColor
                                : null,
                          ),
                        ),
                        onTap: () =>
                            viewModel.showImageSourceSheet(FileType.image),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: TextFormField(
                          style: titleTextMedium.copyWith(color: kcWhiteColor),
                          controller: viewModel.messageController,
                          decoration: AppInputDecoration.standard(
                            hintText: viewModel.uploadFileUrl.isNotEmpty
                                ? 'Add a caption...'
                                : 'Message...',
                          ),
                          // onChanged: viewModel.onMessageChanged,
                        ),
                      ),
                      horizontalSpaceSmall,
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (viewModel.messageController.text
                                        .trim()
                                        .isNotEmpty ||
                                    viewModel.uploadFileUrl.isNotEmpty)
                                ? kcPrimaryColor
                                : kcSubtitleText2Color.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: viewModel.uploadFileUrl.isNotEmpty
                              ? Stack(
                                  children: [
                                    SvgPicture.asset(
                                      send,
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SvgPicture.asset(
                                  send,
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                ),
                        ),
                        onTap: () {
                          if (viewModel.messageController.text
                                  .trim()
                                  .isNotEmpty ||
                              viewModel.uploadFileUrl.isNotEmpty) {
                            viewModel.sendMessage();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper method to format last seen time
  String _getLastSeenText(DateTime lastActive) {
    final now = DateTime.now();
    final difference = now.difference(lastActive);

    if (difference.inMinutes < 1) {
      return 'Online';
    } else if (difference.inMinutes < 60) {
      return 'Last seen ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return 'Last seen ${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return 'Last seen ${difference.inDays}d ago';
    } else {
      return 'Last seen ${formatter.format(lastActive)}';
    }
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();
}
