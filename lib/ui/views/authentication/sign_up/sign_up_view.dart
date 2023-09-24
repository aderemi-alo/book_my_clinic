import 'package:book_my_clinic/ui/common/ui_helpers.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:book_my_clinic/ui/views/authentication/sign_up/sign_up_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'sign_up_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(
    name: 'password',
    // validator: SignUpValidators.passwordValidator,
  ),
  FormTextField(name: 'confirmPassword'),
  FormTextField(name: 'name'),
  FormTextField(name: 'phoneNumber'),
  FormTextField(name: 'specialities'),
  FormTextField(name: 'hospital'),
  FormTextField(name: 'hospitalAddress'),
])
class SignUpView extends StackedView<SignUpViewModel> with $SignUpView {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignUpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceMedium,
              CustomTextField(
                controller: emailController,
                label: "Email",
              ),
              CustomTextField(
                controller: passwordController,
                label: "Password",
              ),
              // viewModel.hasPasswordValidationMessage
              //     ? Text(viewModel.passwordValidationMessage ?? '')
              //     : Container(),
              CustomTextField(
                controller: confirmPasswordController,
                label: "Confirm Password",
              ),
              CustomTextField(
                controller: nameController,
                label: "Full Name",
              ),
              CustomTextField(
                controller: phoneNumberController,
                label: "Phone Number",
              ),
              RadioListTile(
                value: "doctor",
                groupValue: viewModel.role,
                onChanged: (value) => viewModel.setRole(value),
                title: const Text("Doctor"),
              ),
              RadioListTile(
                value: "patient",
                groupValue: viewModel.role,
                onChanged: (value) => viewModel.setRole(value),
                title: const Text("Patient"),
              ),
              Visibility(
                visible: viewModel.role == "doctor",
                child: Column(
                  children: [
                    Text("Additional Information"),
                    verticalSpaceSmall,
                    CustomTextField(
                      controller: specialitiesController,
                      label: "Specialties",
                      hint:
                          "For multiple specialites, have a comma ',' between each one",
                    ),
                    CustomTextField(
                      controller: hospitalController,
                      label: "Hospital",
                    ),
                    CustomTextField(
                      controller: hospitalAddressController,
                      label: "Hospital Address",
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => viewModel.role == "patient"
                      ? viewModel.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          phoneNumber: phoneNumberController.text)
                      : viewModel.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          phoneNumber: phoneNumberController.text,
                          specialties: specialitiesController.text,
                          hospital: hospitalController.text,
                          hospitalAddress: hospitalAddressController.text),
                  child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignUpViewModel();

  @override
  void onViewModelReady(SignUpViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
  }
}
