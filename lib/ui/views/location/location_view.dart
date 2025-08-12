import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/models/registration_model.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/location/location_view.form.dart';
import 'package:nest/ui/views/startup/widgets/dots_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'location_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'manualLocation'),
])
class LocationView extends StackedView<LocationViewModel> with $LocationView {
  const LocationView({Key? key, required this.registrationModel})
      : super(key: key);
  final RegistrationModel registrationModel;
  @override
  Widget builder(
    BuildContext context,
    LocationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Where Are You\nPartying?",
                style: titleTextMedium.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kcWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceSmall,
              Text(
                "Find events near you or plan for your next\ntrip.",
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  color: kcSubtitleTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
              DotWidget(),
              verticalSpaceMedium,
              InkWell(
                onTap: () => viewModel.getCurrentLocation(),
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
                    child: viewModel.isBusy
                        ? const CircularProgressIndicator(
                            color: kcPrimaryColor,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(loc),
                              horizontalSpaceSmall,
                              Text(
                                "Use current location",
                                style: titleTextMedium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kcWhiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              spacedDivider,
              TextFormField(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                controller: manualLocationController,
                decoration: AppInputDecoration.standard(
                    prefixIcon: SvgPicture.asset(
                      pin,
                      width: 20,
                      height: 20,
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: 'Enter city manually'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: AppButton(
          labelText: 'Finish',
          onTap: () => viewModel.goToRegisterView(registrationModel),
        ),
      ),
    );
  }

  @override
  LocationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LocationViewModel();
}
