import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'patient_dashboard_viewmodel.dart';

class PatientDashboardView extends StackedView<PatientDashboardViewModel> {
  const PatientDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientDashboardViewModel viewModel,
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
  PatientDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PatientDashboardViewModel();
}
