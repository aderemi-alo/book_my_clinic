import 'package:book_my_clinic/ui/common/ui_helpers.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:book_my_clinic/ui/views/authentication/login/login_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:book_my_clinic/ui/common/app_colors.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue[100], // Light blue background
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
            child: SingleChildScrollView(
              child: Container(
                color: kcGreyColor,
                width: MediaQuery.of(context).size.width > 800
                    ? 500
                    : MediaQuery.of(context).size.width,
                height: screenHeight,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NEXTPATIENT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Color.fromARGB(255, 25, 84, 210))),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kcVeryLightGrey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      // Style the radio buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 200,
                            child: RadioListTile(
                              activeColor: Colors.blue,
                              value: "patient",
                              groupValue: viewModel.role,
                              onChanged: (value) => viewModel.setRole(value!),
                              title: const Text("Patient"),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: RadioListTile(
                              activeColor: Colors.blue,
                              value: "doctor",
                              groupValue: viewModel.role,
                              onChanged: (value) => viewModel.setRole(value!),
                              title: const Text("Doctor"),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      ElevatedButton(
                        onPressed: () => viewModel.login(
                          emailController.text,
                          passwordController.text,
                        ),
                        child: viewModel.isBusy
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text("Login"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      TextButton(
                        onPressed: viewModel.navigateToSignUp,
                        child: const Text("Don't have an account? Sign Up"),
                        style: TextButton.styleFrom(primary: Colors.blue),
                      )
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
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
