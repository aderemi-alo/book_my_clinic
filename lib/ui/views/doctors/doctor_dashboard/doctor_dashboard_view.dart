import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    if (viewModel.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Text("Name: ${viewModel.doctor?.name}"),
            Text("Phone Number: ${viewModel.doctor?.phoneNumber}"),
            Visibility(
              visible: viewModel.appointmentRequests!.isNotEmpty,
              child: Column(
                children: [
                  Text("Pending Appointments"),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: viewModel.appointmentRequests?.length ?? 0,
                      itemBuilder: (context, index) {
                        var appointmentRequest =
                            viewModel.appointmentRequests![index];
                        var patient = viewModel
                            .patientsData[appointmentRequest.patientId];
                        String formattedTime = DateFormat('d MMMM, h:mm a')
                            .format(appointmentRequest.dateTime);
                        return ListTile(
                          title: Text(patient!.name),
                          subtitle: Text(formattedTime),
                          trailing: TextButton(
                            onPressed: () => viewModel.onManageAppointmentTap(
                                appointmentRequest, patient),
                            child: Text("Manage Appointment"),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Text("Upcoming Appointments"),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: viewModel.upcomingAppointments?.length ?? 0,
                itemBuilder: (context, index) {
                  var upcomingAppointment =
                      viewModel.upcomingAppointments![index];
                  var patient =
                      viewModel.patientsData[upcomingAppointment.patientId];
                  print(patient);
                  String formattedTime = DateFormat('d MMMM, h:mm a')
                      .format(upcomingAppointment.dateTime);
                  print(patient!.name);
                  print(patient.appointmentIDs);
                  return ListTile(
                    title: Text(patient.name + ", " + formattedTime),
                    trailing: TextButton(
                        onPressed: () => viewModel.onRescheduleAppointmentTap(
                              upcomingAppointment,
                              patient,
                            ),
                        child: Text("Reschedule")),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  DoctorDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DoctorDashboardViewModel();

  @override
  void onViewModelReady(DoctorDashboardViewModel viewModel) async {
    await viewModel.fetchDoctorData();
    await viewModel.fetchDoctorAppointments();
  }
}
