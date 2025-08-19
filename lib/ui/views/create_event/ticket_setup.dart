import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_dotted_container.dart';

import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class TicketSetup extends StatelessWidget {
  const TicketSetup({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  title: Text(
                    'Guestlist',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  iconColor: kcWhiteColor,
                  collapsedIconColor: kcWhiteColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: kcContainerBorderColor,
                          ),
                          Text(
                            'Quantity Limit (Optional)',
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kcWhiteColor,
                            ),
                          ),
                          verticalSpaceSmall,
                          TextFormField(
                            decoration: AppInputDecoration.standard(
                              hintText: "e.g., '100'",
                              filled: true,
                            ),
                          ),
                          verticalSpaceMedium,
                          Text(
                            'Description (Optional)',
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kcWhiteColor,
                            ),
                          ),
                          verticalSpaceSmall,
                          TextFormField(
                            maxLines: 3,
                            decoration: AppInputDecoration.standard(
                              hintText:
                                  "e.g., Grants access to the main event area.",
                              filled: true,
                            ),
                          ),
                          verticalSpaceMedium,
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            value: viewModel.isMax1PerUser,
                            onChanged: (value) =>
                                viewModel.isMax1PerUser = value!,
                            title: Text(
                              'Max 1 per user',
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kcWhiteColor,
                              ),
                            ),
                            activeColor: kcPrimaryColor,
                            checkColor: kcWhiteColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpaceMedium,
            Container(
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  title: Text(
                    'Paid Ticket',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  iconColor: kcWhiteColor,
                  collapsedIconColor: kcWhiteColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: kcGreyButtonColor,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: kcContainerBorderColor,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tier Name',
                                      style: titleTextMedium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: kcWhiteColor,
                                      ),
                                    ),
                                    horizontalSpaceSmall,
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: kcDisableIconColor,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpaceSmall,
                                TextFormField(
                                  decoration: AppInputDecoration.standard(
                                    hintText: "Early Bird",
                                    filled: true,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Text(
                                  'Tier Name',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                TextFormField(
                                  decoration: AppInputDecoration.standard(
                                    hintText: "25.00",
                                    filled: true,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Text(
                                  'Quantity',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                TextFormField(
                                  decoration: AppInputDecoration.standard(
                                    hintText: "50",
                                    filled: true,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Text(
                                  'Description (Optional)',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                TextFormField(
                                  decoration: AppInputDecoration.standard(
                                    hintText:
                                        "e.g., Limited quantity, first come"
                                        "first served.",
                                    filled: true,
                                  ),
                                  maxLines: 3,
                                ),
                                verticalSpaceSmall,
                                SwitchListTile(
                                  value: viewModel.isRequireApproval,
                                  activeColor: kcPrimaryColor,
                                  thumbColor:
                                      MaterialStateProperty.all(kcWhiteColor),
                                  inactiveThumbColor: kcWhiteColor,
                                  inactiveTrackColor: kcContainerBorderColor,
                                  onChanged: (value) =>
                                      viewModel.toggleRequireApproval(),
                                  title: Text(
                                    'Require Approval',
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: kcWhiteColor,
                                    ),
                                  ),
                                ),
                                verticalSpaceSmall,
                                SwitchListTile(
                                  value: viewModel.isPasswordProtected,
                                  activeColor: kcPrimaryColor,
                                  thumbColor:
                                      MaterialStateProperty.all(kcWhiteColor),
                                  inactiveThumbColor: kcWhiteColor,
                                  inactiveTrackColor: kcContainerBorderColor,
                                  onChanged: (value) =>
                                      viewModel.togglePasswordProtected(),
                                  title: Text(
                                    'Password Protected',
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: kcWhiteColor,
                                    ),
                                  ),
                                ),
                                verticalSpaceSmall,
                                viewModel.isPasswordProtected
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Password',
                                            style: titleTextMedium.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: kcWhiteColor,
                                            ),
                                          ),
                                          verticalSpaceSmall,
                                          TextFormField(
                                            decoration:
                                                AppInputDecoration.standard(
                                              hintText: "Enter password",
                                              filled: true,
                                            ),
                                            obscureText: true,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                verticalSpaceSmall,
                                SwitchListTile(
                                  value: viewModel.isTransferable,
                                  activeColor: kcPrimaryColor,
                                  thumbColor:
                                      MaterialStateProperty.all(kcWhiteColor),
                                  inactiveThumbColor: kcWhiteColor,
                                  inactiveTrackColor: kcContainerBorderColor,
                                  onChanged: (value) =>
                                      viewModel.toggleTransferable(),
                                  title: Text(
                                    'Transferable',
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: kcWhiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpaceMedium,
                          DottedBorderContainer(
                            borderColor: kcPrimaryColor,
                            height: 50,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: kcPrimaryColor,
                                  size: 24,
                                ),
                                horizontalSpaceSmall,
                                Text(
                                  'Add Ticket Tier',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kcPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpaceSmall,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpaceMedium,
            AppButton(
              labelText: 'Net',
              onTap: () => viewModel.nextPage(),
            ),
          ],
        ),
      ),
    );
  }
}
