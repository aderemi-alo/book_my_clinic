// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameValueKey = 'name';
const String PhoneNumberValueKey = 'phoneNumber';
const String EmailValueKey = 'email';

final Map<String, TextEditingController>
    _PatientDashboardViewTextEditingControllers = {};

final Map<String, FocusNode> _PatientDashboardViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _PatientDashboardViewTextValidations = {
  NameValueKey: null,
  PhoneNumberValueKey: null,
  EmailValueKey: null,
};

mixin $PatientDashboardView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);

  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_PatientDashboardViewTextEditingControllers.containsKey(key)) {
      return _PatientDashboardViewTextEditingControllers[key]!;
    }

    _PatientDashboardViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _PatientDashboardViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_PatientDashboardViewFocusNodes.containsKey(key)) {
      return _PatientDashboardViewFocusNodes[key]!;
    }
    _PatientDashboardViewFocusNodes[key] = FocusNode();
    return _PatientDashboardViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          PhoneNumberValueKey: phoneNumberController.text,
          EmailValueKey: emailController.text,
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

    for (var controller in _PatientDashboardViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _PatientDashboardViewFocusNodes.values) {
      focusNode.dispose();
    }

    _PatientDashboardViewTextEditingControllers.clear();
    _PatientDashboardViewFocusNodes.clear();
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

  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_PatientDashboardViewTextEditingControllers.containsKey(NameValueKey)) {
      _PatientDashboardViewTextEditingControllers[NameValueKey]?.text =
          value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_PatientDashboardViewTextEditingControllers.containsKey(
        PhoneNumberValueKey)) {
      _PatientDashboardViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_PatientDashboardViewTextEditingControllers.containsKey(
        EmailValueKey)) {
      _PatientDashboardViewTextEditingControllers[EmailValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
}

extension Methods on FormStateHelper {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    phoneNumberValue = '';
    emailValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _PatientDashboardViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _PatientDashboardViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
