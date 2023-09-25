import 'package:book_my_clinic/models/appointment.dart';
import 'package:stacked/stacked.dart';
import 'package:book_my_clinic/app/app.dialogs.dart';
import 'package:flutter/material.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/services/appointment_service.dart';
import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/models/patient.dart';
import 'package:book_my_clinic/models/doctor.dart';
import 'package:stacked_services/stacked_services.dart';

class PatientDashboardViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _patientService = locator<PatientService>();
  final _doctorService = locator<DoctorService>();
  final _appointmentService = locator<AppointmentService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  Patient? _patient;
  Patient? get patient => _patient;

  Map<String, Doctor> _doctorsData = {};
  Map<String, Doctor> get doctorsData => _doctorsData;

  List<Doctor>? _searchResults;
  List<Doctor>? get searchResults => _searchResults;

  Doctor? _appointmentDoctor;
  Doctor? get appointmentDoctor => _appointmentDoctor;

  List<Appointment>? _appointments;
  List<Appointment>? get appointments => _appointments;

  List<Appointment> _upcomingAppointments = [];
  List<Appointment>? get upcomingAppointments => _upcomingAppointments;

  List<Appointment>? _pastAppointments = [];
  List<Appointment>? get pastAppointments => _pastAppointments;

  void _showError(String? message) {
    final context = StackedService.navigatorKey!.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message!)),
      );
    }
  }

  Future fetchPatientData() async {
    String uid = _authenticationService.getCurrentUser()!.uid;

    setBusy(true);
    var result = await _patientService.getPatient(uid);
    if (result.isSuccess) {
      _patient = result.value;
      rebuildUi();
    } else {
      _showError(result.error);
    }
  }

  Future searchForDoctorBySpeciality(String speciality) async {
    var result = await _doctorService.searchDoctorBySpeciality(speciality);
    if (result.isSuccess) {
      _searchResults = result.value;
      print(_searchResults);
    } else {
      print(result.error);
    }
    rebuildUi();
  }

  Future fetchDoctorData(String doctorID) async {
    var result = await _doctorService.getDoctor(doctorID);
    print(result.value);
    if (result.isSuccess) {
      _appointmentDoctor = result.value;
    } else {
      print(result.error);
    }
  }

  Future fetchPatientAppointments() async {
    var result =
        await _appointmentService.fetchAppointments(patientID: _patient!.uid);
    print(result.value);

    if (result.isSuccess) {
      _appointments = result.value;
      for (var appointment in _appointments!) {
        if (appointment.dateTime.isAfter(DateTime.now())) {
          _upcomingAppointments.add(appointment);
          await fetchDoctorData(appointment.doctorId);
          if (_appointmentDoctor != null) {
            _doctorsData[appointment.doctorId] = _appointmentDoctor!;
          }
        } else {
          _pastAppointments!.add(appointment);
          await fetchDoctorData(appointment.doctorId);
          if (_appointmentDoctor != null) {
            _doctorsData[appointment.doctorId] = _appointmentDoctor!;
          }
        }
        _upcomingAppointments.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        // Sort past appointments in descending order based on dateTime
        _pastAppointments!.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
    } else {
      print(result.error);
    }
    setBusy(false);
  }

  void onBookAppointmentPressed(Doctor doctor) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.bookAppointment,
      data: doctor,
    );

    if (response!.confirmed && response.data is DateTime) {
      DateTime selectedDate = response.data;
      var result =
          await _appointmentService.createAppointment(doctor.uid, selectedDate);
      if (result.isSuccess) {
      } else {
        print(result.error);
      }
    }
  }
}
