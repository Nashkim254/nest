import 'package:flutter/material.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';
import 'package:nest/utils/validators.dart';

import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 25.0),
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.eventDetailsKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event title',
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(fontSize: 16),
                controller: viewModel.eventTitleController,
                validator: (value) => Validators.validateRequired(value),
                decoration: AppInputDecoration.standard(
                  hintText: "e.g., 'Neon Night Rave'",
                  filled: true,
                ),
              ),
              verticalSpaceMedium,
              Text(
                'Date & Time',
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(fontSize: 16),
                controller: viewModel.eventDateTimeController,
                readOnly: true,
                onTap: () => viewModel.selectDateTime(context),
                validator: (value) => Validators.validateRequired(value),
                keyboardType: TextInputType.datetime,
                decoration: AppInputDecoration.standard(
                  hintText: 'mm/dd/yyyy ---:---',
                  filled: true,
                ),
              ),
              verticalSpaceMedium,
              Text(
                'Address',
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              // Location TextField with Places API integration
              Stack(
                children: [
                  TextFormField(
                    style: titleTextMedium.copyWith(fontSize: 16),
                    onChanged: viewModel.updateSearchQuery,
                    controller: viewModel.addressController,
                    validator: (value) => Validators.validateRequired(value),
                    decoration: AppInputDecoration.standard(
                      hintText: "e.g., 'The Warehouse, Brooklyn'",
                      filled: true,
                      suffixIcon: viewModel.searchQuery.isNotEmpty
                          ? IconButton(
                              icon:
                                  const Icon(Icons.clear, color: kcWhiteColor),
                              onPressed: viewModel.clearSearchResults,
                            )
                          : const Icon(Icons.location_on, color: kcWhiteColor),
                    ),
                  ),

                  // Loading indicator overlay
                  if (viewModel.isSearching)
                    const Positioned(
                      right: 50,
                      top: 12,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                        ),
                      ),
                    ),
                ],
              ),

              // Places search results dropdown
              if (viewModel.searchResults.isNotEmpty && !viewModel.isSearching)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: kcStepperColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kcPrimaryColor.withOpacity(0.3)),
                  ),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.searchResults.length,
                    itemBuilder: (context, index) {
                      final place = viewModel.searchResults[index];
                      return ListTile(
                        dense: true,
                        leading: const Icon(
                          Icons.location_on,
                          color: kcPrimaryColor,
                          size: 20,
                        ),
                        title: Text(
                          place.mainText ?? place.description,
                          style: titleTextMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kcWhiteColor,
                          ),
                        ),
                        subtitle: place.secondaryText != null
                            ? Text(
                                place.secondaryText!,
                                style: titleTextMedium.copyWith(
                                  fontSize: 12,
                                  color: kcWhiteColor.withOpacity(0.7),
                                ),
                              )
                            : null,
                        onTap: () => viewModel.selectPlace(place),
                        trailing: viewModel.isLoadingCoordinates
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kcPrimaryColor),
                                ),
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: kcWhiteColor.withOpacity(0.7),
                              ),
                      );
                    },
                  ),
                ),
              verticalSpaceMedium,
              Text(
                'Location Name',
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(fontSize: 16),
                controller: viewModel.eventLocationController,
                decoration: AppInputDecoration.standard(
                  hintText: "Location Name",
                  filled: true,
                ),
                validator: (value) => Validators.validateRequired(value),
              ),
              verticalSpaceMedium,

              Text(
                'Event Mode',
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceMedium,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: kcStepperColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => viewModel.togglePaidTickets(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: viewModel.isRsvP
                                ? kcPrimaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'RSVP Only',
                            style: titleTextMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: viewModel.isRsvP
                                  ? kcWhiteColor
                                  : kcDisableIconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => viewModel.togglePaidTickets(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: viewModel.isPaid
                                ? kcPrimaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Paid Tickets',
                            style: titleTextMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: viewModel.isPaid
                                  ? kcWhiteColor
                                  : kcDisableIconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Private Event',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  Switch(
                    value: viewModel.isPrivate,
                    onChanged: (value) => viewModel.togglePrivate(),
                    activeColor: kcWhiteColor,
                    activeTrackColor: kcPrimaryColor,
                    inactiveThumbColor: kcWhiteColor,
                    inactiveTrackColor: kcStepperColor,
                  ),
                ],
              ),
              verticalSpaceMedium,
              viewModel.isPrivate
                  ? TextFormField(
                      style: titleTextMedium.copyWith(fontSize: 16),
                      controller: viewModel.eventPasswordController,
                      validator: (value) => Validators.validateRequired(value),
                      obscureText: viewModel.isPasswordProtectedEnabled,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: AppInputDecoration.standard(
                        hintText: "Enter Password",
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.isPasswordProtectedEnabled
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kcWhiteColor,
                          ),
                          onPressed: () => viewModel.togglePasswordVisibility(),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              verticalSpaceMedium,
              AppButton(
                labelText: 'Next',
                onTap: () => viewModel.nextPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
