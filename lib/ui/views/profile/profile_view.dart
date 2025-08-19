import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/profile/widgets/event_grid_layout.dart';
import 'package:nest/ui/views/profile/widgets/socials.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    viewModel.getUserProfile(false);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await viewModel.getUserProfile(true);
        },
        child: Scaffold(
          backgroundColor: kcDarkColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kcDarkColor,
            title: Text("Profile",
                style: titleTextMedium.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                )),
            centerTitle: true,
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {
                  // Handle share action
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(share),
                ),
              ),
            ],
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatar),
                      backgroundColor: kcPrimaryColor,
                    ),
                  ),
                  verticalSpaceMedium,
                  Center(
                    child: Text(
                      "${viewModel.profile!.firstName} ${viewModel.profile!.lastName}",
                      style: titleTextMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kcWhiteColor,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Center(
                    child: Text(
                      "@${viewModel.profile!.displayName}",
                      style: titleTextMedium.copyWith(color: kcSubtitleColor),
                    ),
                  ),
                  verticalSpaceMedium,
                  Align(
                    child: Text(
                      viewModel.profile!.interests.join(', '),
                      style: bodyText.copyWith(color: kcGreyColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpaceMedium,
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              viewModel.profile!.followersCount.toString(),
                              style: titleTextMedium.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: kcWhiteColor,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: titleTextMedium.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: kcFollowColor,
                              ),
                            ),
                          ],
                        ),
                        horizontalSpaceMedium,
                        Column(
                          children: [
                            Text(
                              viewModel.profile!.followingCount.toString(),
                              style: titleTextMedium.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: kcWhiteColor,
                              ),
                            ),
                            Text(
                              "Following",
                              style: titleTextMedium.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: kcFollowColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  viewModel.isUser
                      ? Align(
                          child: SizedBox(
                            width: 150,
                            child: AppButton(
                              labelText: 'Edit Profile',
                              onTap: () => viewModel.onEditProfile(),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 160,
                              child: AppButton(
                                labelText: 'Follow',
                                onTap: () => viewModel.followUnfollowUser(
                                  viewModel.profile!.id,
                                  true,
                                ),
                              ),
                            ),
                            horizontalSpaceMedium,
                            SizedBox(
                              width: 160,
                              child: AppButton(
                                labelText: 'Message',
                                onTap: () => viewModel.goToChatView(),
                                buttonColor: kcGreyButtonColor,
                              ),
                            ),
                          ],
                        ),
                  verticalSpaceMedium,
                  Text(
                    "Socials",
                    style: titleTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  verticalSpaceMedium,
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: kcOffWhite8Grey,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: kcContainerBorderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Socials(
                          avatar: instagram,
                          name: "Instagram",
                          handle: viewModel.profile!.instagram ?? "",
                          onTap: () {},
                        ),
                        Socials(
                          avatar: x,
                          name: "X (Twitter)",
                          handle: viewModel.profile!.twitter ?? "",
                          onTap: () {},
                        ),
                        Socials(
                          avatar: linkedin,
                          name: "Linkein",
                          handle: viewModel.profile!.linkedIn ?? "",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    viewModel.isUser ? "My Feed" : "User's Feed",
                    style: titleTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  verticalSpaceMedium,
                  EventGalleryGrid(
                    eventActivities: viewModel.eventActivities,
                    onTap: viewModel.handleEventTap,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: viewModel.isUser
              ? FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () => viewModel.cretePost(),
                  backgroundColor: kcPrimaryColor,
                  child: const Icon(
                    Icons.add,
                    color: kcWhiteColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
