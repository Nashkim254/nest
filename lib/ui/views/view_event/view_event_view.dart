import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:nest/models/events.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart' as appStrings;
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/utils/utilities.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_shimmer.dart';
import '../../common/ui_helpers.dart';
import 'view_event_viewmodel.dart';

class ViewEventView extends StackedView<ViewEventViewModel> {
  const ViewEventView({Key? key, required this.event}) : super(key: key);
  final Event event;
  @override
  void onViewModelReady(ViewEventViewModel viewModel) {
    viewModel.init(event);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    ViewEventViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: viewModel.isBusy
          ? const EventShimmerLoader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(viewModel.event!.flyerUrl),
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
                                  backgroundColor:
                                      kcBlackColor.withOpacity(0.5),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.adaptive.arrow_back,
                                      color: kcWhiteColor,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      kcBlackColor.withOpacity(0.5),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.event!.title,
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
                                    Expanded(
                                      child: SvgPicture.asset(
                                        appStrings.calendar,
                                        color: kcPrimaryColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        formatter
                                            .format(viewModel.event!.startTime),
                                        style: titleTextMedium.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
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
                                    const Expanded(
                                      child: Icon(
                                        Icons.access_time,
                                        color: kcPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        formatter
                                            .format(viewModel.event!.endTime),
                                        style: titleTextMedium.copyWith(
                                            color: Colors.white, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
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
                                    Expanded(
                                      child: SvgPicture.asset(
                                        appStrings.pin,
                                        color: kcPrimaryColor,
                                      ),
                                    ),
                                    horizontalSpaceSmall,
                                    Expanded(
                                      child: Text(
                                        viewModel.event!.location,
                                        style: titleTextMedium.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
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
                                      'Hosted by\n${viewModel.event!.organizer.isEmpty ? '-' : viewModel.event!.organizer}\nEvents',
                                      style: titleTextMedium.copyWith(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                              viewModel.coordinates!['latitude'],
                              viewModel.coordinates!['longitude'],
                            ),
                            zoom: 16.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    viewModel.coordinates!['latitude'],
                                    viewModel.coordinates!['longitude'],
                                  ),
                                  width: 40,
                                  height: 40,
                                  builder: (BuildContext context) {
                                    return const Icon(Icons.location_pin,
                                        color: Colors.red, size: 40);
                                  },
                                ),
                              ],
                            ),
                          ],
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
                      viewModel.event!.description.isEmpty
                          ? 'No description available for this event.'
                          : viewModel.event!.description,
                      style: titleTextMedium.copyWith(
                        color: kcDisableIconColor,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),

                  verticalSpaceMedium,

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(
                  //     'Lineup',
                  //     style: titleTextMedium.copyWith(
                  //       color: kcWhiteColor,
                  //       fontSize: 18,
                  //       height: 1.5,
                  //     ),
                  //   ),
                  // ),

                  verticalSpaceMedium,

                  // DJ List
                  // _buildDJItem('DJ Electro Beat', '10:00 PM - 11:30 PM'),
                  // _buildDJItem('Vibe Master Flex', '11:30 PM - 1:00 AM'),
                  // _buildDJItem('Synth Siren', '1:00 AM - 2:00 AM'),

                  verticalSpaceSmall,
                  spacedDivider,
                  // Sponsors
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(
                  //     'Sponsors',
                  //     style: titleTextMedium.copyWith(
                  //       color: kcWhiteColor,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  //
                  // const SizedBox(height: 12),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 4; i++)
                  //         Container(
                  //           margin: const EdgeInsets.only(right: 12),
                  //           width: 50,
                  //           height: 50,
                  //           decoration: const BoxDecoration(
                  //             color: kcPrimaryColor,
                  //             shape: BoxShape.circle,
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),

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
                        for (int i = 0;
                            i < viewModel.event!.goingUsers.length;
                            i++)
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
                        Text(
                          '${viewModel.event!.goingUsers.length} of your friends are\ngoing',
                          style: const TextStyle(
                              color: kcGrey4Color, fontSize: 14),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: viewModel.event!.goingUsers.isNotEmpty
                              ? () {}
                              : null,
                          child: Text(
                            'View\nAll',
                            style: TextStyle(
                                color: viewModel.event!.goingUsers.isNotEmpty
                                    ? kcPrimaryColor
                                    : kcGrey3Color,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  spacedDivider,

                  // Follow section
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(
                  //     'Follow',
                  //     style: titleTextMedium.copyWith(
                  //       color: kcWhiteColor,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),

                  // verticalSpaceMedium,
                  //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Column(
                  //     children: [
                  //       _buildSocialButton(appStrings.instagram, 'Instagram'),
                  //       verticalSpaceSmall,
                  //       _buildSocialButton(appStrings.fb, 'Facebook'),
                  //       const SizedBox(height: 12),
                  //       _buildSocialButton(appStrings.web, 'Website'),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 40),

                  // RSVP Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: AppButton(
                        labelText: viewModel.getButtonTitle(),
                        onTap: () => viewModel.passwordProtected(),
                      ),
                    ),
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
                    child: SvgPicture.asset(appStrings.web,
                        color: kcDisableIconColor),
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
                      appStrings.instagram,
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
