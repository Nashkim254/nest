import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_dotted_container.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_post_viewmodel.dart';

class CreatePostView extends StackedView<CreatePostViewModel> {
  const CreatePostView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(CreatePostViewModel viewModel) {
    viewModel.getUser();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    CreatePostViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: titleTextMedium.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kcFollowColor,
                        ),
                      ),
                    ),
                    Text(
                      "New Post",
                      style: titleTextMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kcWhiteColor,
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () => viewModel.createPost(),
                      child: viewModel.isLoading
                          ? Text(
                              'posting...',
                              style: titleTextMedium.copyWith(
                                color: kcPrimaryColor,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              'Post',
                              style: titleTextMedium.copyWith(
                                color: kcPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                    )
                  ],
                ),
                verticalSpaceMedium,
                InkWell(
                  onTap: () => viewModel.showImageSourceSheet(FileType.image),
                  child: DottedBorderContainer(
                    borderColor: kcContainerBorderColor,
                    height: 200,
                    width: double.infinity,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (viewModel.isBusy)
                            const CircularProgressIndicator(
                              color: kcPrimaryColor,
                            )
                          else if (viewModel.hasImages) ...[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1.0,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color: kcOffWhite8Grey,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: Image.file(
                                              viewModel.selectedImages[index],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: InkWell(
                                            onTap: () =>
                                                viewModel.removeImage(index),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.black54,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ] else ...[
                            SvgPicture.asset(addImg),
                            verticalSpaceSmall,
                            Text(
                              "Tap to add Photo/Video",
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                color: kcFollowColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: viewModel.postController,
                  maxLines: 5,
                  maxLength: 280,
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    color: kcWhiteColor,
                  ),
                  decoration: AppInputDecoration.standard(
                    hintText: "Write a caption...",
                    borderColor: kcContainerBorderColor,
                    focusedBorderColor: kcContainerBorderColor,
                  ),
                ),
                verticalSpaceMedium,
                InkWell(
                  onTap: () => viewModel.showAddLocationSheet(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: kcContainerBorderColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: kcOffWhite8Grey,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          horizontalSpaceSmall,
                          SvgPicture.asset(pin),
                          horizontalSpaceSmall,
                          Text(
                            viewModel.location.isNotEmpty
                                ? viewModel.location
                                : "Add Location",
                            style: titleTextMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kcWhiteColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: kcFollowColor,
                          ),
                          horizontalSpaceSmall,
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                // InkWell(
                //   onTap: () => viewModel.showTagPeopleSheet(),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: kcContainerBorderColor),
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(8),
                //       ),
                //       color: kcOffWhite8Grey,
                //     ),
                //     child: Center(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           horizontalSpaceSmall,
                //           SvgPicture.asset(at),
                //           horizontalSpaceSmall,
                //           Text(
                //             "Tag People",
                //             style: titleTextMedium.copyWith(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               color: kcWhiteColor,
                //             ),
                //             textAlign: TextAlign.center,
                //           ),
                //           const Spacer(),
                //           const Icon(
                //             Icons.arrow_forward_ios,
                //             color: kcFollowColor,
                //           ),
                //           horizontalSpaceSmall,
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: MediaQuery.of(context).padding.bottom + 20.0,
          ),
          child: AppButton(
            isBusy: viewModel.isLoading,
            labelText: 'Post',
            onTap: () => viewModel.createPost(),
          ),
        ),
      ),
    );
  }

  @override
  CreatePostViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreatePostViewModel();
}
