// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameValueKey = 'name';
const String HospitalValueKey = 'hospital';
const String HospitalAddressValueKey = 'hospitalAddress';
const String PhoneNumberValueKey = 'phoneNumber';

final Map<String, TextEditingController>
    _DoctorDashboardViewTextEditingControllers = {};

final Map<String, FocusNode> _DoctorDashboardViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _DoctorDashboardViewTextValidations = {
  NameValueKey: null,
  HospitalValueKey: null,
  HospitalAddressValueKey: null,
  PhoneNumberValueKey: null,
};

mixin $DoctorDashboardView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get hospitalController =>
      _getFormTextEditingController(HospitalValueKey);
  TextEditingController get hospitalAddressController =>
      _getFormTextEditingController(HospitalAddressValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);

  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get hospitalFocusNode => _getFormFocusNode(HospitalValueKey);
  FocusNode get hospitalAddressFocusNode =>
      _getFormFocusNode(HospitalAddressValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_DoctorDashboardViewTextEditingControllers.containsKey(key)) {
      return _DoctorDashboardViewTextEditingControllers[key]!;
    }

    _DoctorDashboardViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _DoctorDashboardViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_DoctorDashboardViewFocusNodes.containsKey(key)) {
      return _DoctorDashboardViewFocusNodes[key]!;
    }
    _DoctorDashboardViewFocusNodes[key] = FocusNode();
    return _DoctorDashboardViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameController.addListener(() => _updateFormData(model));
    hospitalController.addListener(() => _updateFormData(model));
    hospitalAddressController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

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
    hospitalController.addListener(() => _updateFormData(model));
    hospitalAddressController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          HospitalValueKey: hospitalController.text,
          HospitalAddressValueKey: hospitalAddressController.text,
          PhoneNumberValueKey: phoneNumberController.text,
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

    for (var controller in _DoctorDashboardViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _DoctorDashboardViewFocusNodes.values) {
      focusNode.dispose();
    }

    _DoctorDashboardViewTextEditingControllers.clear();
    _DoctorDashboardViewFocusNodes.clear();
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
  String? get hospitalValue => this.formValueMap[HospitalValueKey] as String?;
  String? get hospitalAddressValue =>
      this.formValueMap[HospitalAddressValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_DoctorDashboardViewTextEditingControllers.containsKey(NameValueKey)) {
      _DoctorDashboardViewTextEditingControllers[NameValueKey]?.text =
          value ?? '';
    }
  }

  set hospitalValue(String? value) {
    this.setData(
      this.formValueMap..addAll({HospitalValueKey: value}),
    );

    if (_DoctorDashboardViewTextEditingControllers.containsKey(
        HospitalValueKey)) {
      _DoctorDashboardViewTextEditingControllers[HospitalValueKey]?.text =
          value ?? '';
    }
  }

  set hospitalAddressValue(String? value) {
    this.setData(
      this.formValueMap..addAll({HospitalAddressValueKey: value}),
    );

    if (_DoctorDashboardViewTextEditingControllers.containsKey(
        HospitalAddressValueKey)) {
      _DoctorDashboardViewTextEditingControllers[HospitalAddressValueKey]
          ?.text = value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_DoctorDashboardViewTextEditingControllers.containsKey(
        PhoneNumberValueKey)) {
      _DoctorDashboardViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasHospital =>
      this.formValueMap.containsKey(HospitalValueKey) &&
      (hospitalValue?.isNotEmpty ?? false);
  bool get hasHospitalAddress =>
      this.formValueMap.containsKey(HospitalAddressValueKey) &&
      (hospitalAddressValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasHospitalValidationMessage =>
      this.fieldsValidationMessages[HospitalValueKey]?.isNotEmpty ?? false;
  bool get hasHospitalAddressValidationMessage =>
      this.fieldsValidationMessages[HospitalAddressValueKey]?.isNotEmpty ??
      false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get hospitalValidationMessage =>
      this.fieldsValidationMessages[HospitalValueKey];
  String? get hospitalAddressValidationMessage =>
      this.fieldsValidationMessages[HospitalAddressValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
}

extension Methods on FormStateHelper {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setHospitalValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[HospitalValueKey] = validationMessage;
  setHospitalAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[HospitalAddressValueKey] =
          validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    hospitalValue = '';
    hospitalAddressValue = '';
    phoneNumberValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      HospitalValueKey: getValidationMessage(HospitalValueKey),
      HospitalAddressValueKey: getValidationMessage(HospitalAddressValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _DoctorDashboardViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _DoctorDashboardViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      HospitalValueKey: getValidationMessage(HospitalValueKey),
      HospitalAddressValueKey: getValidationMessage(HospitalAddressValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });
