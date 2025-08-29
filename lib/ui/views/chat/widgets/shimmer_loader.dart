import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nest/ui/common/ui_helpers.dart';

class ChatShimmerLoader extends StatelessWidget {
  const ChatShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Shimmer.fromColors(
              baseColor: kcDarkGreyColor,
              highlightColor: kcOffWhite8Grey,
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: kcDarkGreyColor,
              ),
            ),
            horizontalSpaceMedium,
            Shimmer.fromColors(
              baseColor: kcDarkGreyColor,
              highlightColor: kcOffWhite8Grey,
              child: Container(
                height: 18,
                width: 120,
                decoration: BoxDecoration(
                  color: kcDarkGreyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8, // Show 8 shimmer message bubbles
              itemBuilder: (context, index) {
                return _buildShimmerMessageBubble(index, context);
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
                  child: Shimmer.fromColors(
                    baseColor: kcDarkGreyColor,
                    highlightColor: kcOffWhite8Grey,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: kcDarkGreyColor,
                    highlightColor: kcOffWhite8Grey,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Shimmer.fromColors(
                    baseColor: kcDarkGreyColor,
                    highlightColor: kcOffWhite8Grey,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: kcDarkGreyColor,
                    highlightColor: kcOffWhite8Grey,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerMessageBubble(int index, BuildContext context) {
    // Alternate between sent and received message styles
    final bool isSentMessage = index % 3 == 0; // Every third message is sent

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentMessage) ...[
            // Profile picture for received messages
            Shimmer.fromColors(
              baseColor: kcDarkGreyColor,
              highlightColor: kcOffWhite8Grey,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: kcDarkGreyColor,
              ),
            ),
            horizontalSpaceSmall,
          ],
          // Message bubble
          Shimmer.fromColors(
            baseColor: kcDarkGreyColor,
            highlightColor: kcOffWhite8Grey,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                minWidth: 80,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message content shimmer
                  Container(
                    height: 16,
                    width: _getRandomWidth(index),
                    decoration: BoxDecoration(
                      color: kcOffGreyColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  if (_shouldHaveSecondLine(index)) ...[
                    verticalSpaceSmall,
                    Container(
                      height: 16,
                      width: _getRandomWidth(index + 1) * 0.6,
                      decoration: BoxDecoration(
                        color: kcOffGreyColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                  verticalSpaceTiny,
                  // Timestamp shimmer
                  Container(
                    height: 12,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kcOffGreyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSentMessage) ...[
            horizontalSpaceSmall,
            // Profile picture for sent messages (optional)
            Shimmer.fromColors(
              baseColor: kcDarkGreyColor,
              highlightColor: kcOffWhite8Grey,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: kcDarkGreyColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _getRandomWidth(int index) {
    // Create varied widths for more realistic shimmer effect
    final List<double> widths = [120, 180, 90, 150, 200, 110, 160, 140];
    return widths[index % widths.length];
  }

  bool _shouldHaveSecondLine(int index) {
    // Some messages have two lines for more variety
    return index % 4 == 0;
  }
}
