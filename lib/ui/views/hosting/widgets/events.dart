import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/hosting/widgets/all_tab.dart';
import 'package:nest/ui/views/hosting/widgets/past_tab.dart';
import 'package:nest/ui/views/hosting/widgets/upcoming_tab.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';
import '../hosting_viewmodel.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key, required this.viewModel});
final HostingViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Manage Events',
                style: titleTextMedium.copyWith(fontSize: 18),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Handle search action
                },
                child: SvgPicture.asset(search),
              ),
            ],
          ),
          TabBar(
            indicatorColor: kcPrimaryColor,
            indicatorWeight: 2,
            labelColor: kcPrimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: kcDisableIconColor,
            labelStyle: titleTextMedium,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: TabBarView(
              children: [
                AllTab(
                  viewModel: viewModel,
                ),
                UpcomingTab(
                  viewModel: viewModel,
                ),
                PastTab(
                  viewModel: viewModel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
