import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'doctor_dashboard_viewmodel.dart';

class DoctorDashboardView extends StackedView<DoctorDashboardViewModel> {
  const DoctorDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DoctorDashboardViewModel viewModel,
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
  DoctorDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DoctorDashboardViewModel();
}
