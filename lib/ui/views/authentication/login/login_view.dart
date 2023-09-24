import 'package:book_my_clinic/ui/common/ui_helpers.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:book_my_clinic/ui/views/authentication/login/login_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
            child: Column(children: [
          verticalSpaceMedium,
          CustomTextField(
            controller: emailController,
            label: "Email",
          ),
          CustomTextField(
            controller: passwordController,
            label: "Password",
          ),
          RadioListTile(
            value: "patient",
            groupValue: viewModel.role,
            onChanged: (value) => viewModel.setRole(value),
            title: const Text("Patient"),
          ),
          RadioListTile(
            value: "doctor",
            groupValue: viewModel.role,
            onChanged: (value) => viewModel.setRole(value),
            title: const Text("Doctor"),
          ),
          ElevatedButton(
            onPressed: () => viewModel.login(
              emailController.text,
              passwordController.text,
            ),
            child: Text("Login"),
          ),
          verticalSpaceMedium,
          TextButton(
            onPressed: viewModel.navigateToSignUp,
            child: const Text("Don't have an account? Sign Up"),
          )
        ])),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
