import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import 'view_event_viewmodel.dart';

class ViewEventView extends StackedView<ViewEventViewModel> {
  const ViewEventView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ViewEventViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(event),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kcBlackColor.withOpacity(0.3),
                          kcBlackColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),

                  // Header with back button and share
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: kcBlackColor.withOpacity(0.5),
                            child: IconButton(
                              icon: Icon(
                                Icons.adaptive.arrow_back,
                                color: kcWhiteColor,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: kcBlackColor.withOpacity(0.5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share_outlined,
                                color: kcWhiteColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'Neon Nights Rave',
              style: titleTextMedium.copyWith(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 92,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kcDarkGreyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          calendar,
                          color: kcPrimaryColor,
                        ),
                        horizontalSpaceSmall,
                        Text(
                          'Sat, Oct 26,\n2024',
                          style: titleTextMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 92,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kcDarkGreyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: kcPrimaryColor,
                          size: 20,
                        ),
                        horizontalSpaceSmall,
                        Text(
                          '9:00 PM -\n2:00 AM',
                          style: titleTextMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 92,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kcDarkGreyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          pin,
                          color: kcPrimaryColor,
                        ),
                        horizontalSpaceSmall,
                        Text(
                          'The\nWarehouse,\nDowntown',
                          style: titleTextMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 92,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kcDarkGreyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: kcPrimaryColor,
                          size: 20,
                        ),
                        horizontalSpaceSmall,
                        Text(
                          'Hosted by\nElectro\nEvents',
                          style: titleTextMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            verticalSpaceMedium,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text(
                      'Map View',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),

            verticalSpaceMedium,
            spacedDivider,
            // About This Event
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'About This Event',
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Get ready for an electrifying night at Neon Nights Rave! Join us for an unforgettable experience with top DJs, stunning light shows, and a vibrant atmosphere. Dance the night away to the best electronic beats.',
                style: titleTextMedium.copyWith(
                  color: kcDisableIconColor,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            verticalSpaceMedium,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lineup',
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),

            verticalSpaceMedium,

            // DJ List
            _buildDJItem('DJ Electro Beat', '10:00 PM - 11:30 PM'),
            _buildDJItem('Vibe Master Flex', '11:30 PM - 1:00 AM'),
            _buildDJItem('Synth Siren', '1:00 AM - 2:00 AM'),

            verticalSpaceSmall,
            spacedDivider,
            // Sponsors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sponsors',
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: kcPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),

            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Who\'s Going',
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: kcPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  const SizedBox(width: 12),
                  const Text(
                    '4 of your friends are\ngoing',
                    style: TextStyle(color: kcGrey4Color, fontSize: 14),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View\nAll',
                      style: TextStyle(color: kcPrimaryColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            spacedDivider,

            // Follow section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Follow',
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            verticalSpaceMedium,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildSocialButton(instagram, 'Instagram'),
                  verticalSpaceSmall,
                  _buildSocialButton(fb, 'Facebook'),
                  const SizedBox(height: 12),
                  _buildSocialButton(web, 'Website'),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // RSVP Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: AppButton(labelText: 'RSVP', onTap: () {})),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  ViewEventViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ViewEventViewModel();
}

Widget _buildDJItem(String name, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: kcGreyButtonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SvgPicture.asset(web, color: kcDisableIconColor),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: kcGreyButtonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SvgPicture.asset(
                      instagram,
                      color: kcDisableIconColor,
                      height: 20,
                      width: 20,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSocialButton(dynamic icon, String text) {
  return Row(
    children: [
      Container(
        width: 130,
        height: 44,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kcDarkGreyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(icon),
            horizontalSpaceSmall,
            Text(
              text,
              style: const TextStyle(color: kcWhiteColor, fontSize: 16),
            ),
          ],
        ),
      ),
    ],
  );
}
