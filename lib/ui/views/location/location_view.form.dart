// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ManualLocationValueKey = 'manualLocation';

final Map<String, TextEditingController> _LocationViewTextEditingControllers =
    {};

final Map<String, FocusNode> _LocationViewFocusNodes = {};

final Map<String, String? Function(String?)?> _LocationViewTextValidations = {
  ManualLocationValueKey: null,
};

mixin $LocationView {
  TextEditingController get manualLocationController =>
      _getFormTextEditingController(ManualLocationValueKey);

  FocusNode get manualLocationFocusNode =>
      _getFormFocusNode(ManualLocationValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_LocationViewTextEditingControllers.containsKey(key)) {
      return _LocationViewTextEditingControllers[key]!;
    }

    _LocationViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _LocationViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_LocationViewFocusNodes.containsKey(key)) {
      return _LocationViewFocusNodes[key]!;
    }
    _LocationViewFocusNodes[key] = FocusNode();
    return _LocationViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    manualLocationController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    manualLocationController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ManualLocationValueKey: manualLocationController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _LocationViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _LocationViewFocusNodes.values) {
      focusNode.dispose();
    }

    _LocationViewTextEditingControllers.clear();
    _LocationViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get manualLocationValue =>
      this.formValueMap[ManualLocationValueKey] as String?;

  set manualLocationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ManualLocationValueKey: value}),
    );

    if (_LocationViewTextEditingControllers.containsKey(
        ManualLocationValueKey)) {
      _LocationViewTextEditingControllers[ManualLocationValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasManualLocation =>
      this.formValueMap.containsKey(ManualLocationValueKey) &&
      (manualLocationValue?.isNotEmpty ?? false);

  bool get hasManualLocationValidationMessage =>
      this.fieldsValidationMessages[ManualLocationValueKey]?.isNotEmpty ??
      false;

  String? get manualLocationValidationMessage =>
      this.fieldsValidationMessages[ManualLocationValueKey];
}

extension Methods on FormStateHelper {
  setManualLocationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ManualLocationValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    manualLocationValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ManualLocationValueKey: getValidationMessage(ManualLocationValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _LocationViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _LocationViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ManualLocationValueKey: getValidationMessage(ManualLocationValueKey),
    });
