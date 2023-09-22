import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'authentication_viewmodel.dart';

class AuthenticationView extends StackedView<AuthenticationViewModel> {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthenticationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  AuthenticationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthenticationViewModel();
}
