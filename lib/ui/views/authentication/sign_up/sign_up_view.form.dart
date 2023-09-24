// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String ConfirmPasswordValueKey = 'confirmPassword';
const String NameValueKey = 'name';
const String PhoneNumberValueKey = 'phoneNumber';
const String SpecialitiesValueKey = 'specialities';
const String HospitalValueKey = 'hospital';
const String HospitalAddressValueKey = 'hospitalAddress';

final Map<String, TextEditingController> _SignUpViewTextEditingControllers = {};

final Map<String, FocusNode> _SignUpViewFocusNodes = {};

final Map<String, String? Function(String?)?> _SignUpViewTextValidations = {
  EmailValueKey: null,
  PasswordValueKey: null,
  ConfirmPasswordValueKey: null,
  NameValueKey: null,
  PhoneNumberValueKey: null,
  SpecialitiesValueKey: null,
  HospitalValueKey: null,
  HospitalAddressValueKey: null,
};

mixin $SignUpView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get confirmPasswordController =>
      _getFormTextEditingController(ConfirmPasswordValueKey);
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);
  TextEditingController get specialitiesController =>
      _getFormTextEditingController(SpecialitiesValueKey);
  TextEditingController get hospitalController =>
      _getFormTextEditingController(HospitalValueKey);
  TextEditingController get hospitalAddressController =>
      _getFormTextEditingController(HospitalAddressValueKey);

  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get confirmPasswordFocusNode =>
      _getFormFocusNode(ConfirmPasswordValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);
  FocusNode get specialitiesFocusNode =>
      _getFormFocusNode(SpecialitiesValueKey);
  FocusNode get hospitalFocusNode => _getFormFocusNode(HospitalValueKey);
  FocusNode get hospitalAddressFocusNode =>
      _getFormFocusNode(HospitalAddressValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SignUpViewTextEditingControllers.containsKey(key)) {
      return _SignUpViewTextEditingControllers[key]!;
    }

    _SignUpViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SignUpViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SignUpViewFocusNodes.containsKey(key)) {
      return _SignUpViewFocusNodes[key]!;
    }
    _SignUpViewFocusNodes[key] = FocusNode();
    return _SignUpViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    specialitiesController.addListener(() => _updateFormData(model));
    hospitalController.addListener(() => _updateFormData(model));
    hospitalAddressController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    specialitiesController.addListener(() => _updateFormData(model));
    hospitalController.addListener(() => _updateFormData(model));
    hospitalAddressController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
          ConfirmPasswordValueKey: confirmPasswordController.text,
          NameValueKey: nameController.text,
          PhoneNumberValueKey: phoneNumberController.text,
          SpecialitiesValueKey: specialitiesController.text,
          HospitalValueKey: hospitalController.text,
          HospitalAddressValueKey: hospitalAddressController.text,
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

    for (var controller in _SignUpViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SignUpViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SignUpViewTextEditingControllers.clear();
    _SignUpViewFocusNodes.clear();
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

  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get confirmPasswordValue =>
      this.formValueMap[ConfirmPasswordValueKey] as String?;
  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;
  String? get specialitiesValue =>
      this.formValueMap[SpecialitiesValueKey] as String?;
  String? get hospitalValue => this.formValueMap[HospitalValueKey] as String?;
  String? get hospitalAddressValue =>
      this.formValueMap[HospitalAddressValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(EmailValueKey)) {
      _SignUpViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _SignUpViewTextEditingControllers[PasswordValueKey]?.text = value ?? '';
    }
  }

  set confirmPasswordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ConfirmPasswordValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(
        ConfirmPasswordValueKey)) {
      _SignUpViewTextEditingControllers[ConfirmPasswordValueKey]?.text =
          value ?? '';
    }
  }

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(NameValueKey)) {
      _SignUpViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(PhoneNumberValueKey)) {
      _SignUpViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  set specialitiesValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SpecialitiesValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(SpecialitiesValueKey)) {
      _SignUpViewTextEditingControllers[SpecialitiesValueKey]?.text =
          value ?? '';
    }
  }

  set hospitalValue(String? value) {
    this.setData(
      this.formValueMap..addAll({HospitalValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(HospitalValueKey)) {
      _SignUpViewTextEditingControllers[HospitalValueKey]?.text = value ?? '';
    }
  }

  set hospitalAddressValue(String? value) {
    this.setData(
      this.formValueMap..addAll({HospitalAddressValueKey: value}),
    );

    if (_SignUpViewTextEditingControllers.containsKey(
        HospitalAddressValueKey)) {
      _SignUpViewTextEditingControllers[HospitalAddressValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasConfirmPassword =>
      this.formValueMap.containsKey(ConfirmPasswordValueKey) &&
      (confirmPasswordValue?.isNotEmpty ?? false);
  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);
  bool get hasSpecialities =>
      this.formValueMap.containsKey(SpecialitiesValueKey) &&
      (specialitiesValue?.isNotEmpty ?? false);
  bool get hasHospital =>
      this.formValueMap.containsKey(HospitalValueKey) &&
      (hospitalValue?.isNotEmpty ?? false);
  bool get hasHospitalAddress =>
      this.formValueMap.containsKey(HospitalAddressValueKey) &&
      (hospitalAddressValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasConfirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey]?.isNotEmpty ??
      false;
  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;
  bool get hasSpecialitiesValidationMessage =>
      this.fieldsValidationMessages[SpecialitiesValueKey]?.isNotEmpty ?? false;
  bool get hasHospitalValidationMessage =>
      this.fieldsValidationMessages[HospitalValueKey]?.isNotEmpty ?? false;
  bool get hasHospitalAddressValidationMessage =>
      this.fieldsValidationMessages[HospitalAddressValueKey]?.isNotEmpty ??
      false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get confirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey];
  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
  String? get specialitiesValidationMessage =>
      this.fieldsValidationMessages[SpecialitiesValueKey];
  String? get hospitalValidationMessage =>
      this.fieldsValidationMessages[HospitalValueKey];
  String? get hospitalAddressValidationMessage =>
      this.fieldsValidationMessages[HospitalAddressValueKey];
}

extension Methods on FormStateHelper {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setConfirmPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey] =
          validationMessage;
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;
  setSpecialitiesValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SpecialitiesValueKey] = validationMessage;
  setHospitalValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[HospitalValueKey] = validationMessage;
  setHospitalAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[HospitalAddressValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
    passwordValue = '';
    confirmPasswordValue = '';
    nameValue = '';
    phoneNumberValue = '';
    specialitiesValue = '';
    hospitalValue = '';
    hospitalAddressValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
      NameValueKey: getValidationMessage(NameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      SpecialitiesValueKey: getValidationMessage(SpecialitiesValueKey),
      HospitalValueKey: getValidationMessage(HospitalValueKey),
      HospitalAddressValueKey: getValidationMessage(HospitalAddressValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SignUpViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SignUpViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
      NameValueKey: getValidationMessage(NameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      SpecialitiesValueKey: getValidationMessage(SpecialitiesValueKey),
      HospitalValueKey: getValidationMessage(HospitalValueKey),
      HospitalAddressValueKey: getValidationMessage(HospitalAddressValueKey),
    });
