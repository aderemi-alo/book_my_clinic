import 'package:book_my_clinic/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'patient_dashboard_viewmodel.dart';

class PatientDashboardView extends StackedView<PatientDashboardViewModel> {
  const PatientDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientDashboardViewModel viewModel,
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
          child: Column(
            children: [
              Text("Name: ${viewModel.patient?.name}"),
              Text("Phone Number: ${viewModel.patient?.phoneNumber}"),
              Text("Upcoming Appointments"),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: viewModel.upcomingAppointments?.length ?? 0,
                  itemBuilder: (context, index) {
                    var upcomingAppointment =
                        viewModel.upcomingAppointments![index];
                    print(upcomingAppointment);
                    var doctor =
                        viewModel.doctorsData[upcomingAppointment.doctorId];
                    String formattedTime = DateFormat('d MMMM, h:mm a')
                        .format(upcomingAppointment.dateTime);
                    print(doctor!.name);
                    print(doctor.appointmentIDs);
                    return ListTile(
                      title: Text(doctor.name + ", " + formattedTime),
                      subtitle: Text(
                          "Hospital: ${doctor.hospital}, Address: ${doctor.hospitalAddress}"),
                    );
                  },
                ),
              ),
              verticalSpaceLarge,
              Text("Past Appointments"),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: viewModel.pastAppointments?.length ?? 0,
                  itemBuilder: (context, index) {
                    var pastAppointment = viewModel.pastAppointments![index];
                    print(pastAppointment);
                    var doctor =
                        viewModel.doctorsData[pastAppointment.doctorId];
                    String formattedTime = DateFormat('d MMMM, h:mm a')
                        .format(pastAppointment.dateTime);
                    print(doctor!.name);
                    print(doctor.appointmentIDs);
                    return ListTile(
                      title: Text(doctor.name + ", " + formattedTime),
                      subtitle: Text(
                          "Hospital: ${doctor.hospital}, Address: ${doctor.hospitalAddress}"),
                    );
                  },
                ),
              ),
              verticalSpaceMedium,
              TextField(
                onSubmitted: (value) =>
                    viewModel.searchForDoctorBySpeciality(value),
                decoration: InputDecoration(
                  labelText: "Search by speciality",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: viewModel.searchResults?.length ?? 0,
                  itemBuilder: (context, index) {
                    var doctor = viewModel.searchResults![index];
                    return ListTile(
                      title: Text(doctor.name),
                      subtitle: Text(doctor.specialties.join(", ")),
                      trailing: TextButton(
                        onPressed: () =>
                            viewModel.onBookAppointmentPressed(doctor),
                        child: Text("Book Appointment"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PatientDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PatientDashboardViewModel();

  @override
  void onViewModelReady(PatientDashboardViewModel viewModel) async {
    await viewModel.fetchPatientData();
    await viewModel.fetchPatientAppointments();
    super.onViewModelReady(PatientDashboardViewModel());
  }
}
