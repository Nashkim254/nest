import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/models/user_serach_ressult.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/views/find_people_and_orgs/widgets/top_selecto.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'find_people_and_orgs_viewmodel.dart';

class FindPeopleAndOrgsView extends StackedView<FindPeopleAndOrgsViewModel> {
  const FindPeopleAndOrgsView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FindPeopleAndOrgsViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    FindPeopleAndOrgsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: kcDarkColor,
        body: viewModel.isBusy && !viewModel.isSearching
            ? _buildLoadingState()
            : _buildMainContent(viewModel),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.adaptive.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
        color: kcWhiteColor,
      ),
      backgroundColor: kcDarkColor,
      title: Text(
        "My Nest",
        style: titleTextMedium.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kcWhiteColor,
        ),
      ),
      elevation: 0,
      actions: [
        InkWell(
          onTap: () {
            // Handle notification action
          },
          child: SvgPicture.asset(notification),
        ),
        horizontalSpaceSmall,
        const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(avatar),
        ),
        horizontalSpaceSmall,
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kcWhiteColor),
      ),
    );
  }

  Widget _buildMainContent(FindPeopleAndOrgsViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceMedium,
            _buildSearchBar(viewModel),
            verticalSpaceMedium,
            _buildTitle(),
            verticalSpaceMedium,
            const FindTabBarWidget(),
            verticalSpaceMedium,
            _buildResultsList(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(FindPeopleAndOrgsViewModel viewModel) {
    return TextFormField(
      controller: viewModel.searchController,
      decoration: AppInputDecoration.search(
        hintText: _getSearchHint(viewModel.finderType),
      ),
      onChanged: viewModel.onSearchChanged,
      style: titleTextMedium.copyWith(color: kcWhiteColor),
    );
  }

  String _getSearchHint(FinderType finderType) {
    switch (finderType) {
      case FinderType.people:
        return 'Search people...';
      case FinderType.organizations:
        return 'Search organizations...';
      case FinderType.all:
      default:
        return 'Search people, organizations...';
    }
  }

  Widget _buildTitle() {
    return Text(
      'Find People & Organizations',
      style: titleTextMedium.copyWith(
        fontSize: 18,
        color: kcWhiteColor,
      ),
    );
  }

  Widget _buildResultsList(FindPeopleAndOrgsViewModel viewModel) {
    if (viewModel.isBusy && viewModel.isSearching) {
      return _buildSearchingState();
    }

    if (viewModel.searchResults.isEmpty) {
      return _buildEmptyState(viewModel);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.searchResults.length,
      separatorBuilder: (context, index) => verticalSpaceSmall,
      itemBuilder: (context, index) {
        final item = viewModel.searchResults[index];
        return _buildSearchResultCard(item, viewModel);
      },
    );
  }

  Widget _buildSearchingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kcWhiteColor),
            ),
            verticalSpaceSmall,
            Text(
              'Searching...',
              style: TextStyle(color: kcGreyColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(FindPeopleAndOrgsViewModel viewModel) {
    String message;
    String subtitle;

    if (viewModel.isSearching) {
      message = 'No results found';
      subtitle = 'Try adjusting your search terms or filters';
    } else {
      switch (viewModel.finderType) {
        case FinderType.people:
          message = 'No people found';
          subtitle = 'Try searching for people to connect with';
          break;
        case FinderType.organizations:
          message = 'No organizations found';
          subtitle = 'Try searching for organizations to follow';
          break;
        case FinderType.all:
        default:
          message = 'No results available';
          subtitle = 'Try searching to find people and organizations';
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              viewModel.isSearching ? Icons.search_off : Icons.explore,
              size: 64,
              color: kcGreyColor,
            ),
            verticalSpaceMedium,
            Text(
              message,
              style: titleTextMedium.copyWith(
                color: kcWhiteColor,
                fontSize: 18,
              ),
            ),
            verticalSpaceSmall,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: titleTextMedium.copyWith(
                color: kcGreyColor,
                fontSize: 14,
              ),
            ),
            if (viewModel.isSearching) ...[
              verticalSpaceMedium,
              AppButton(
                labelText: 'Clear Search',
                onTap: viewModel.clearSearch,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(
    SearchResultItem item,
    FindPeopleAndOrgsViewModel viewModel,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: kcContainerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: () => viewModel.goToOtherProfile(item.id),
        contentPadding: const EdgeInsets.all(16),
        leading: _buildAvatar(item),
        title: Text(
          item.name,
          style: titleTextMedium.copyWith(
            fontSize: 16,
            color: kcWhiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: item.subtitle != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceTiny,
                  Text(
                    item.subtitle!,
                    style: titleTextMedium.copyWith(
                      color: kcGreyColor,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpaceTiny,
                  _buildTypeChip(item),
                ],
              )
            : _buildTypeChip(item),
        trailing: AppButton(
          width: 75,
          labelText: 'Follow',
          onTap: () => viewModel.followItem(item),
        ),
      ),
    );
  }

  Widget _buildAvatar(SearchResultItem item) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: item.profilePicture != null
          ? NetworkImage(item.profilePicture!)
          : const AssetImage(avatar) as ImageProvider,
      child: item.profilePicture == null
          ? Icon(
              item.isOrganization ? Icons.business : Icons.person,
              color: kcWhiteColor,
            )
          : null,
    );
  }

  Widget _buildTypeChip(SearchResultItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: item.isOrganization
            ? Colors.blue.withOpacity(0.2)
            : Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        item.isOrganization ? 'Organization' : 'Person',
        style: TextStyle(
          color: item.isOrganization ? Colors.blue : Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  FindPeopleAndOrgsViewModel viewModelBuilder(BuildContext context) =>
      FindPeopleAndOrgsViewModel();
}
