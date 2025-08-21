import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_dotted_container.dart';

import '../../../models/ticket_tier.dart';
import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class TicketSetup extends StatefulWidget {
  const TicketSetup({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;

  @override
  State<TicketSetup> createState() => _TicketSetupState();
}

class _TicketSetupState extends State<TicketSetup> {
  @override
  void initState() {
    super.initState();
    // Initialize with one ticket tier
    widget.viewModel.initializeTicketTiers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Form(
          key: widget.viewModel.ticketSetupKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !widget.viewModel.isRsvP
                  ? Container(
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
                                    keyboardType: TextInputType.number,
                                    controller: widget
                                        .viewModel.eventGuestListController,
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: kcWhiteColor,
                                    ),
                                    validator: (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          int.tryParse(value) == null) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
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
                                    controller: widget.viewModel
                                        .guestListDescriptionController,
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: kcWhiteColor,
                                    ),
                                    maxLines: 3,
                                    decoration: AppInputDecoration.standard(
                                      hintText:
                                          "e.g., Grants access to the main event area.",
                                      filled: true,
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    value: widget.viewModel.isMax1PerUser,
                                    onChanged: (value) =>
                                        widget.viewModel.isMax1PerUser = value!,
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
                    )
                  : const SizedBox(),
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
                            // Dynamic list of ticket tiers
                            AnimatedBuilder(
                              animation: widget.viewModel,
                              builder: (context, child) {
                                return Column(
                                  children: [
                                    ...widget.viewModel.ticketTiers.map((tier) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: TicketTierWidget(
                                          key: Key(tier.id),
                                          ticketTier: tier,
                                          viewModel: widget.viewModel,
                                          onRemove: widget.viewModel.ticketTiers
                                                      .length >
                                                  1
                                              ? () => widget.viewModel
                                                  .removeTicketTier(tier.id)
                                              : null, // Don't allow removing if only one tier
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () => widget.viewModel.addTicketTier(),
                              child: DottedBorderContainer(
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
                labelText: 'Next',
                onTap: () {
                  if (widget.viewModel.validateTicketTiers()) {
                    widget.viewModel.nextPage();
                  } else {
                    // Show validation error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please fill all required ticket tier fields'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketTierWidget extends StatelessWidget {
  const TicketTierWidget({
    super.key,
    required this.ticketTier,
    required this.viewModel,
    this.onRemove,
  });

  final TicketTier ticketTier;
  final CreateEventViewModel viewModel;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onPressed: onRemove,
                icon: Icon(
                  Icons.delete,
                  color: onRemove != null ? kcRedColor : kcDisableIconColor,
                ),
              ),
            ],
          ),
          verticalSpaceSmall,
          TextFormField(
            style: titleTextMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
            controller: ticketTier.tierNameController,
            decoration: AppInputDecoration.standard(
              hintText: "Early Bird",
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tier name is required';
              }
              return null;
            },
          ),
          verticalSpaceSmall,
          Text(
            'Price',
            style: titleTextMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          verticalSpaceSmall,
          TextFormField(
            style: titleTextMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
            controller: ticketTier.priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: AppInputDecoration.standard(
              hintText: "25.00",
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Price is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid price';
              }
              return null;
            },
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
            style: titleTextMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
            controller: ticketTier.quantityController,
            keyboardType: TextInputType.number,
            decoration: AppInputDecoration.standard(
              hintText: "50",
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Quantity is required';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid quantity';
              }
              return null;
            },
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
            style: titleTextMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
            controller: ticketTier.descriptionController,
            decoration: AppInputDecoration.standard(
              hintText: "e.g., Limited quantity, first come first served.",
              filled: true,
            ),
            maxLines: 3,
          ),
          verticalSpaceSmall,
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return SwitchListTile(
                value: ticketTier.isRequireApproval,
                activeColor: kcPrimaryColor,
                thumbColor: MaterialStateProperty.all(kcWhiteColor),
                inactiveThumbColor: kcWhiteColor,
                inactiveTrackColor: kcContainerBorderColor,
                onChanged: (value) =>
                    viewModel.toggleRequireApproval(ticketTier.id),
                title: Text(
                  'Require Approval',
                  style: titleTextMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
              );
            },
          ),
          verticalSpaceSmall,
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return SwitchListTile(
                value: ticketTier.isPasswordProtected,
                activeColor: kcPrimaryColor,
                thumbColor: MaterialStateProperty.all(kcWhiteColor),
                inactiveThumbColor: kcWhiteColor,
                inactiveTrackColor: kcContainerBorderColor,
                onChanged: (value) =>
                    viewModel.togglePasswordProtected(ticketTier.id),
                title: Text(
                  'Password Protected',
                  style: titleTextMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
              );
            },
          ),
          verticalSpaceSmall,
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return ticketTier.isPasswordProtected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: titleTextMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kcWhiteColor,
                          ),
                          controller: ticketTier.passwordController,
                          decoration: AppInputDecoration.standard(
                            hintText: "Enter password",
                            filled: true,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (ticketTier.isPasswordProtected &&
                                (value == null || value.isEmpty)) {
                              return 'Password is required when password protection is enabled';
                            }
                            return null;
                          },
                        ),
                        verticalSpaceSmall,
                      ],
                    )
                  : const SizedBox();
            },
          ),
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return SwitchListTile(
                value: ticketTier.isTransferable,
                activeColor: kcPrimaryColor,
                thumbColor: MaterialStateProperty.all(kcWhiteColor),
                inactiveThumbColor: kcWhiteColor,
                inactiveTrackColor: kcContainerBorderColor,
                onChanged: (value) =>
                    viewModel.toggleTransferable(ticketTier.id),
                title: Text(
                  'Transferable',
                  style: titleTextMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
