import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/events.dart';
import '../../../models/organization_model.dart';
import '../../../utils/utilities.dart';
import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'manage_team_viewmodel.dart';

class ManageTeamView extends StackedView<ManageTeamViewModel> {
  const ManageTeamView({Key? key, required this.organization})
      : super(key: key);
  final Organization organization;
  @override
  void onViewModelReady(ManageTeamViewModel viewModel) {
    viewModel.initialize(organization);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    ManageTeamViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 3, // Team, Details, Events
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kcDarkColor,
          appBar: AppBar(
            backgroundColor: kcDarkColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => viewModel.onBackPressed(),
            ),
            title: Text(
              organization.name ?? 'Organization',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () =>
                    viewModel.onEditOrganizationPressed(organization),
              ),
              // IconButton(
              //   icon: const Icon(Icons.settings, color: Colors.white),
              //   onPressed: viewModel.onSettingsPressed,
              // ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.group),
                  text: 'Team',
                ),
                Tab(
                  icon: Icon(Icons.info_outline),
                  text: 'Details',
                ),
                Tab(
                  icon: Icon(Icons.event),
                  text: 'Events',
                ),
              ],
              indicatorColor: kcPrimaryColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          body: TabBarView(
            children: [
              _buildTeamTab(viewModel, organization),
              _buildDetailsTab(),
              _buildEventsTab(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamTab(
      ManageTeamViewModel viewModel, Organization organization) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Invite New Member Section
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF2A2A2A),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Invite New Member',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       TextField(
          //         onChanged: viewModel.updateInviteEmail,
          //         style: const TextStyle(color: Colors.white),
          //         decoration: InputDecoration(
          //           hintText: 'Enter email address',
          //           hintStyle: TextStyle(color: Colors.grey[500]),
          //           filled: true,
          //           fillColor: const Color(0xFF333333),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(8),
          //             borderSide: BorderSide.none,
          //           ),
          //           contentPadding: const EdgeInsets.symmetric(
          //             horizontal: 16,
          //             vertical: 14,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       SizedBox(
          //         width: double.infinity,
          //         child: ElevatedButton(
          //           onPressed: () => viewModel.isBusy
          //               ? null
          //               : viewModel.addNewMember(organization.id!),
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: kcPrimaryColor,
          //             padding: const EdgeInsets.symmetric(vertical: 16),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             elevation: 0,
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               if (viewModel.isBusy)
          //                 const SizedBox(
          //                   width: 16,
          //                   height: 16,
          //                   child: CircularProgressIndicator(
          //                     color: Colors.white,
          //                     strokeWidth: 2,
          //                   ),
          //                 )
          //               else
          //                 const Icon(Icons.add, color: Colors.white),
          //               const SizedBox(width: 8),
          //               Text(
          //                 viewModel.isBusy ? 'Adding...' : 'Add New Member',
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 24),

          // Team Members Section
          const Text(
            'Team Members',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Team Members List
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.teamMembers.length,
              itemBuilder: (context, index) {
                final member = viewModel.teamMembers[index];
                return _buildTeamMemberCard(viewModel, member);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization Banner
          if (organization.banner != null && organization.banner!.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(organization.banner!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 16),

          // Profile Picture and Basic Info
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: organization.profilePic != null &&
                          organization.profilePic!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(organization.profilePic!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color:
                      organization.profilePic == null ? Colors.grey[600] : null,
                ),
                child: organization.profilePic == null ||
                        organization.profilePic!.isEmpty
                    ? Center(
                        child: Text(
                          organization.name?.substring(0, 1).toUpperCase() ??
                              'O',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          organization.name ?? 'Unknown Organization',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (organization.isVerified == true)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.verified,
                              color: kcPrimaryColor,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    if (organization.description != null)
                      Text(
                        organization.description!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Bio Section
          if (organization.bio != null && organization.bio!.isNotEmpty)
            _buildDetailCard(
              'About',
              organization.bio!,
              Icons.info_outline,
            ),

          // Genres/Categories
          if (organization.genres != null && organization.genres!.isNotEmpty)
            _buildDetailCard(
              'Categories',
              organization.genres!.join(', '),
              Icons.category,
            ),

          // Service Fee
          if (organization.serviceFee != null)
            _buildDetailCard(
              'Service Fee',
              '${organization.serviceFee}',
              Icons.monetization_on,
            ),

          // Contact Information
          const Text(
            'Contact Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          _buildContactRow(Icons.phone, 'WhatsApp', organization.whatsApp),
          _buildContactRow(
              Icons.phone_android, 'Phone', organization.phoneNumber),
          _buildContactRow(Icons.email, 'Email', organization.email),
          _buildContactRow(Icons.language, 'Website', organization.website),
          _buildContactRow(Icons.facebook, 'Facebook', organization.facebook),
          _buildContactRow(
              Icons.camera_alt, 'Instagram', organization.instagram),
          // Add Twitter/LinkedIn icons as needed

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEventsTab(ManageTeamViewModel viewModel) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          // Create Event Button
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton.icon(
          //     onPressed: viewModel.onCreateEventPressed,
          //     icon: const Icon(Icons.add, color: Colors.white),
          //     label: const Text(
          //       'Create New Event',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: kcPrimaryColor,
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       elevation: 0,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),

          // Events List
          Expanded(
            child: viewModel.isBusy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ),
                  )
                : viewModel.organizationEvents.isEmpty
                    ? _buildEmptyEventsState(viewModel)
                    : ListView.builder(
                        itemCount: viewModel.organizationEvents.length,
                        itemBuilder: (context, index) {
                          final event = viewModel.organizationEvents[index];
                          return _buildEventCard(event, viewModel);
                        },
                      ),
          ),
            ],
          ),
        ),
        // Password dialog overlay
        if (viewModel.showPasswordDialogState)
          _buildPasswordDialog(viewModel),
      ],
    );
  }

  Widget _buildDetailCard(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kcPrimaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: kcPrimaryColor, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event, ManageTeamViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.onEventTapped(event),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: kcPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      formatter.format(event.startTime),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    if (event.location.isNotEmpty)
                      Text(
                        event.location,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: event.status == 'published'
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event.status.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${event.totalTickets} tickets',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (event.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                event.description,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people, color: Colors.grey[400], size: 16),
              const SizedBox(width: 4),
              Text(
                '${event.goingUsers.length} going',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.remove_red_eye, color: Colors.grey[400], size: 16),
              const SizedBox(width: 4),
              Text(
                '${event.viewCount} views',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              if (event.isPasswordProtected) const SizedBox(width: 16),
              if (event.isPasswordProtected)
                Icon(Icons.lock, color: Colors.orange, size: 16),
            ],
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildEmptyEventsState(ManageTeamViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No Events Yet',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first event to get started',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: viewModel.onCreateEventPressed,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create Event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kcPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(
      ManageTeamViewModel viewModel, TeamMember member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[600],
            backgroundImage: member.avatarUrl != null
                ? NetworkImage(member.avatarUrl!)
                : null,
            child: member.avatarUrl == null
                ? Text(
                    member.name?[0].toUpperCase() ?? 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),

          // Member Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name ?? 'Unknown User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member.status == 'accepted' ? 'Accepted' : 'Pending',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: viewModel.getRoleColor(member.role ?? 'member'),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              member.role ?? 'member',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordDialog(ManageTeamViewModel viewModel) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kcDarkGreyColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kcContainerBorderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Row(
                children: [
                  const Icon(
                    Icons.lock,
                    color: Colors.orange,
                    size: 24,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    'Password Required',
                    style: titleTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => viewModel.closePasswordDialog(),
                    icon: const Icon(
                      Icons.close,
                      color: kcGreyColor,
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              Text(
                'This event is password protected. Please enter the password to view details.',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcSubtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: viewModel.passwordController,
                obscureText: !viewModel.showPassword,
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
                decoration: AppInputDecoration.standard(
                  hintText: 'Enter password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kcGreyColor,
                    ),
                    onPressed: () => viewModel.togglePasswordVisibility(),
                  ),
                ),
              ),
              if (viewModel.passwordError.isNotEmpty) ...[
                verticalSpaceSmall,
                Text(
                  viewModel.passwordError,
                  style: titleTextMedium.copyWith(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => viewModel.closePasswordDialog(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kcGreyColor),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Cancel',
                        style: titleTextMedium.copyWith(
                          fontSize: 14,
                          color: kcGreyColor,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: AppButton(
                      labelText: viewModel.isValidatingPassword
                          ? 'Validating...'
                          : 'Enter',
                      onTap: () => viewModel.validatePassword(),
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ManageTeamViewModel viewModelBuilder(BuildContext context) {
    return ManageTeamViewModel();
  }
}
