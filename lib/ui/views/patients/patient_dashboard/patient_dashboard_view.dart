import 'package:book_my_clinic/models/patient.dart';
import 'package:book_my_clinic/ui/common/app_colors.dart';
import 'package:book_my_clinic/ui/common/ui_helpers.dart';
import 'package:book_my_clinic/ui/views/patients/patient_dashboard/patient_dashboard_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked_annotations.dart';
import 'patient_dashboard_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'phoneNumber'),
  FormTextField(name: 'email'),
])
class PatientDashboardView extends StackedView<PatientDashboardViewModel>
    with $PatientDashboardView {
  @override
  Widget builder(
    BuildContext context,
    PatientDashboardViewModel viewModel,
    Widget? child,
  ) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F8),
      body: Row(
        children: [
          if (isLargeScreen || viewModel.isMenuExpanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: Colors.blue,
              width: viewModel.isMenuExpanded ? 250 : 100,
              child: _buildMenu(context, viewModel),
            ),
          Expanded(
            child: Align(
              alignment: viewModel.currentView == DashboardView.profile
                  ? Alignment.topLeft
                  : Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                child: _buildBody(context, viewModel),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, PatientDashboardViewModel viewModel) {
    var isLargeScreen = MediaQuery.of(context).size.width > 600;

    // Custom menu item
    Widget _customMenuItem(
        IconData iconData, String text, bool isSelected, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.blue,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 24,
                    end: isSelected ? 28 : 24,
                  ),
                  duration: const Duration(milliseconds: 300),
                  builder: (BuildContext context, double size, Widget? child) {
                    return Icon(
                      iconData,
                      color: isSelected ? Colors.blue : Colors.white,
                      size: size,
                    );
                  },
                  child: Icon(
                    iconData,
                    color: isSelected ? Colors.blue : Colors.white,
                    size: isSelected ? 28 : 24,
                  ),
                ),
                if (viewModel.isMenuExpanded && isLargeScreen)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: (viewModel.isMenuExpanded
                              ? 1.0
                              : 0.0), // Adjust as needed
                          child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                              fontSize: isSelected ? 18 : 16,
                              color: isSelected ? Colors.blue : Colors.white,
                            ),
                            duration: const Duration(milliseconds: 300),
                            child: Text(text),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            children: <Widget>[
              if (MediaQuery.of(context).size.width > 600)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: viewModel.toggleMenu,
                  ),
                ),
              verticalSpaceMedium,
              _customMenuItem(
                Icons.event,
                'Upcoming Appointments',
                viewModel.currentView == DashboardView.upcoming,
                () => viewModel.setCurrentView(DashboardView.upcoming),
              ),
              verticalSpaceMedium,
              _customMenuItem(
                Icons.history,
                'Past Appointments',
                viewModel.currentView == DashboardView.past,
                () => viewModel.setCurrentView(DashboardView.past),
              ),
              verticalSpaceMedium,
              _customMenuItem(
                Icons.person,
                'Profile',
                viewModel.currentView == DashboardView.profile,
                () => viewModel.setCurrentView(DashboardView.profile),
              ),
              verticalSpaceMedium,
              _customMenuItem(
                Icons.laptop,
                'Book Appointment',
                viewModel.currentView == DashboardView.book,
                () => viewModel.setCurrentView(DashboardView.book),
              ),
            ],
          ),
        ),
        _customMenuItem(
          Icons.power_settings_new,
          'Logout',
          false,
          viewModel.logout,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, PatientDashboardViewModel viewModel) {
    switch (viewModel.currentView) {
      case DashboardView.upcoming:
        return _buildUpcomingAppointments(viewModel);
      case DashboardView.past:
        return _buildPastAppointments(viewModel);
      case DashboardView.book:
        return _buildBookAppointment(viewModel);
      case DashboardView.profile:
        return _buildProfile(viewModel);
      default:
        return _buildUpcomingAppointments(viewModel);
    }
  }

  Widget _buildUpcomingAppointments(PatientDashboardViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(viewModel.upcomingAppointments?.length ?? 0,
              (index) {
            var upcomingAppointment = viewModel.upcomingAppointments![index];
            var doctor = viewModel.doctorsData[upcomingAppointment.doctorId];
            String formattedDate =
                DateFormat('d MMMM').format(upcomingAppointment.dateTime);
            String formattedTime =
                DateFormat('h:mm a').format(upcomingAppointment.dateTime);
            return SizedBox(
              width: 300,
              height: 200,
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Patient: ${doctor!.name}"),
                    Text("Date: $formattedDate"),
                    Text("Time: $formattedTime"),
                    Text("Hospital: ${doctor.hospital}"),
                    Text("Hospital Address: ${doctor.hospitalAddress}"),
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget _buildPastAppointments(PatientDashboardViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children:
              List.generate(viewModel.pastAppointments?.length ?? 0, (index) {
            var pastAppointment = viewModel.pastAppointments![index];
            var doctor = viewModel.doctorsData[pastAppointment.doctorId];
            String formattedDate =
                DateFormat('d MMMM').format(pastAppointment.dateTime);
            String formattedTime =
                DateFormat('h:mm a').format(pastAppointment.dateTime);
            return SizedBox(
              width: 300,
              height: 200,
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Patient: ${doctor!.name}"),
                    Text("Date: $formattedDate"),
                    Text("Time: $formattedTime"),
                    Text("Hospital: ${doctor.hospital}"),
                    Text("Hospital Address: ${doctor.hospitalAddress}"),
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget _buildProfile(PatientDashboardViewModel viewModel) {
    var patient = viewModel.patient!;
    nameController.text = patient.name;
    phoneNumberController.text = patient.phoneNumber;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileTextField(
            label: "Name",
            controller: nameController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.person),
          ),
          ProfileTextField(
            label: "Email",
            initialValue: patient.email,
            prefixIcon: const Icon(Icons.email),
          ),
          ProfileTextField(
            label: "Phone Number",
            controller: phoneNumberController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.phone),
          ),
          if (viewModel.isEditing)
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => viewModel.updateProfile(
                    Patient(
                      uid: patient.uid,
                      email: patient.email,
                      name: nameController.text.isEmpty
                          ? patient.name
                          : nameController.text.trim(),
                      phoneNumber: phoneNumberController.text.isEmpty
                          ? patient.phoneNumber
                          : phoneNumberController.text.trim(),
                      appointmentIDs: patient.appointmentIDs,
                    ),
                  ),
                  child: Text('Save'),
                ),
                OutlinedButton(
                  onPressed: viewModel.toggleEditing,
                  child: Text('Cancel'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: viewModel.toggleEditing,
              child: Text('Edit'),
            ),
        ],
      ),
    );
  }

  Widget _buildBookAppointment(PatientDashboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onSubmitted: (value) =>
                viewModel.searchForDoctorBySpeciality(value),
            decoration: InputDecoration(
              labelText: "Search by speciality",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          verticalSpaceLarge,
          SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                viewModel.searchResults?.length ?? 0,
                (index) {
                  var doctor = viewModel.searchResults![index];
                  return Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                      color: kcVeryLightGrey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Doctor: ${doctor.name}"),
                        Text("Specialty: ${doctor.specialties.join(', ')}"),
                        Text("Hospital: ${doctor.hospital}"),
                        Text("Hospital Address: ${doctor.hospitalAddress}"),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () =>
                              viewModel.onBookAppointmentPressed(doctor),
                          child: Text(
                            "Book Appointment",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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
