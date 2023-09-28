import 'package:book_my_clinic/ui/common/app_colors.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Image(
              image: AssetImage('assets/background.webp'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width > 800
                  ? 500
                  : MediaQuery.of(context).size.width,
              color: kcGreyColor,
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NEXTPATIENT",
                          style: Theme.of(context).textTheme.headlineMedium),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                      ),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                      ),
                      // viewModel.hasPasswordValidationMessage
                      //     ? Text(viewModel.passwordValidationMessage ?? '')
                      //     : Container(),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                      ),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: nameController,
                        label: "Full Name",
                      ),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: phoneNumberController,
                        label: "Phone Number",
                      ),
                      verticalSpaceMedium,
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              value: "patient",
                              groupValue: viewModel.role,
                              onChanged: (value) => viewModel.setRole(value!),
                              title: const Text("Patient"),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              value: "doctor",
                              groupValue: viewModel.role,
                              onChanged: (value) => viewModel.setRole(value!),
                              title: const Text("Doctor"),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      AnimatedSwitcher(
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin:
                                  Offset(0, -1), // Start from above the screen
                              end: Offset(0, 0), // End at its original position
                            ).animate(animation),
                            child: FadeTransition(
                              opacity:
                                  animation, // Fade in using the animation value
                              child: child,
                            ),
                          );
                        },
                        duration: Duration(milliseconds: 600),
                        child: viewModel.role == "doctor"
                            ? Column(
                                key: ValueKey<bool>(true),
                                children: [
                                  Text("Additional Information"),
                                  verticalSpaceMedium,
                                  CustomTextField(
                                    controller: specialitiesController,
                                    label: "Specialties",
                                    hint:
                                        "For multiple specialites, have a comma ',' between each one",
                                  ),
                                  verticalSpaceMedium,
                                  CustomTextField(
                                    controller: hospitalController,
                                    label: "Hospital",
                                  ),
                                  verticalSpaceMedium,
                                  CustomTextField(
                                    controller: hospitalAddressController,
                                    label: "Hospital Address",
                                  ),
                                  verticalSpaceMedium
                                ],
                              )
                            : Container(key: ValueKey<bool>(false)),
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
                                hospitalAddress:
                                    hospitalAddressController.text),
                        child: const Text("Sign Up"),
                      ),
                      verticalSpaceMedium,
                      TextButton(
                        onPressed: viewModel.navigateToLogin,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Already have an account? ",
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
