import 'package:book_my_clinic/models/doctor.dart';
import 'package:book_my_clinic/ui/common/app_colors.dart';
import 'package:book_my_clinic/ui/views/doctors/doctor_dashboard/doctor_dashboard_view.form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'doctor_dashboard_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'name'),
    FormTextField(name: 'hospital'),
    FormTextField(name: 'hospitalAddress'),
    FormTextField(name: 'phoneNumber'),
  ],
)
class DoctorDashboardView extends StackedView<DoctorDashboardViewModel>
    with $DoctorDashboardView {
  const DoctorDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DoctorDashboardViewModel viewModel,
    Widget? child,
  ) {
    var isLargeScreen = MediaQuery.of(context).size.width > 600;
    if (viewModel.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F8),
      body: Row(
        children: [
          if (isLargeScreen || viewModel.isMenuExpanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: kcBackgroundColorBlue,
              width: viewModel.isMenuExpanded && isLargeScreen ? 250 : 50,
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

  Widget _buildMenu(BuildContext context, DoctorDashboardViewModel viewModel) {
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
              _customMenuItem(
                Icons.event,
                'Upcoming Appointments',
                viewModel.currentView == DashboardView.upcoming,
                () => viewModel.setCurrentView(DashboardView.upcoming),
              ),
              _customMenuItem(
                Icons.history,
                'Past Appointments',
                viewModel.currentView == DashboardView.past,
                () => viewModel.setCurrentView(DashboardView.past),
              ),
              _customMenuItem(
                Icons.pending_actions,
                'Appointment Requests',
                viewModel.currentView == DashboardView.requests,
                () => viewModel.setCurrentView(DashboardView.requests),
              ),
              _customMenuItem(
                Icons.person,
                'Profile',
                viewModel.currentView == DashboardView.profile,
                () => viewModel.setCurrentView(DashboardView.profile),
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

  Widget _buildBody(BuildContext context, DoctorDashboardViewModel viewModel) {
    switch (viewModel.currentView) {
      case DashboardView.upcoming:
        return _buildUpcomingAppointments(viewModel);
      case DashboardView.past:
        return _buildPastAppointments(viewModel);
      case DashboardView.requests:
        return _buildAppointmentRequests(viewModel);
      case DashboardView.profile:
        return _buildProfile(viewModel);
      default:
        return _buildUpcomingAppointments(viewModel);
    }
  }

  Widget _buildUpcomingAppointments(DoctorDashboardViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(viewModel.upcomingAppointments?.length ?? 0,
              (index) {
            var upcomingAppointment = viewModel.upcomingAppointments![index];
            var patient = viewModel.patientsData[upcomingAppointment.patientId];
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
                    Text("Patient: ${patient!.name}"),
                    Text("Date: $formattedDate"),
                    Text("Time: $formattedTime"),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () => viewModel.onRescheduleAppointmentTap(
                          upcomingAppointment, patient),
                      child: Text("Reschedule",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget _buildPastAppointments(DoctorDashboardViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children:
              List.generate(viewModel.pastAppointments?.length ?? 0, (index) {
            var pastAppointment = viewModel.pastAppointments![index];
            var patient = viewModel.patientsData[pastAppointment.patientId];
            String formattedDate =
                DateFormat('d MMMM').format(pastAppointment.dateTime);
            String formattedTime =
                DateFormat('h:mm a').format(pastAppointment.dateTime);
            return Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kcVeryLightGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Patient: ${patient!.name}"),
                  Text("Date: $formattedDate"),
                  Text("Time: $formattedTime"),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () => viewModel.onRescheduleAppointmentTap(
                      pastAppointment,
                      patient,
                    ),
                    child: Text("Reschedule",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          })),
    );
  }

  Widget _buildAppointmentRequests(DoctorDashboardViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 20,
          runSpacing: 20,
          children: List.generate(viewModel.appointmentRequests?.length ?? 0,
              (index) {
            var appointmentRequest = viewModel.appointmentRequests![index];
            var patient = viewModel.patientsData[appointmentRequest.patientId];
            String formattedDate =
                DateFormat('d MMMM').format(appointmentRequest.dateTime);
            String formattedTime =
                DateFormat('h:mm a').format(appointmentRequest.dateTime);
            return Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kcVeryLightGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Patient: ${patient!.name}"),
                  Text("Date: $formattedDate"),
                  Text("Time: $formattedTime"),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () => viewModel.onManageAppointmentTap(
                      appointmentRequest,
                      patient,
                    ),
                    child: Text(
                      "Manage",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }

  Widget _buildProfile(DoctorDashboardViewModel viewModel) {
    var doctor = viewModel.doctor!;
    nameController.text = doctor.name;
    phoneNumberController.text = doctor.phoneNumber;
    hospitalController.text = doctor.hospital;
    hospitalAddressController.text = doctor.hospitalAddress;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ProfileTextField(
            label: "Name",
            controller: nameController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.person),
          ),
          ProfileTextField(
            label: "Email",
            initialValue: doctor.email,
            prefixIcon: const Icon(Icons.email),
          ),
          ProfileTextField(
            label: "Phone Number",
            controller: phoneNumberController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.phone),
          ),
          ProfileTextField(
            label: "Hospital",
            controller: hospitalController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.local_hospital),
          ),
          ProfileTextField(
            label: "Hospital Address",
            controller: hospitalAddressController,
            isEditing: viewModel.isEditing,
            prefixIcon: const Icon(Icons.house),
          ),
          ProfileTextField(
            label: "Specialities",
            initialValue: doctor.specialties.join(', '),
            prefixIcon: const Icon(Icons.book),
          ),
          if (viewModel.isEditing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => viewModel.updateProfile(
                    Doctor(
                        uid: doctor.uid,
                        email: doctor.email,
                        name: nameController.text.isEmpty
                            ? doctor.name
                            : nameController.text.trim(),
                        phoneNumber: phoneNumberController.text.isEmpty
                            ? doctor.phoneNumber
                            : phoneNumberController.text.trim(),
                        hospital: hospitalController.text.isEmpty
                            ? doctor.hospital
                            : hospitalController.text.trim(),
                        hospitalAddress: hospitalAddressController.text.isEmpty
                            ? doctor.hospitalAddress
                            : hospitalAddressController.text.trim(),
                        specialties: doctor.specialties,
                        appointmentIDs: doctor.appointmentIDs),
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
