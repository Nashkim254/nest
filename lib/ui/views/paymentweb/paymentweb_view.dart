import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/payments.dart';
import 'paymentweb_viewmodel.dart';

class PaymentwebView extends StackedView<PaymentwebViewModel> {
  const PaymentwebView({Key? key, required this.checkoutURL}) : super(key: key);
  final String checkoutURL;
  @override
  void onViewModelReady(PaymentwebViewModel viewModel) {
    viewModel.init(checkoutURL);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    PaymentwebViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      appBar: AppBar(
        title: Text('Complete Payment',
            style: titleTextMedium.copyWith(color: kcWhiteColor)),
        centerTitle: true,
        backgroundColor: kcDarkColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(
              PaymentResult(
                success: false,
                message: 'Payment canceled by user',
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          if (viewModel.isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: kcPrimaryColor,
              ),
            )
          else
            WebViewWidget(controller: viewModel.controller),
        ],
      ),
    );
  }

  @override
  PaymentwebViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentwebViewModel();
}
