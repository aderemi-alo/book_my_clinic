import 'package:book_my_clinic/models/appointment.dart';
import 'package:stacked/stacked.dart';
import 'package:book_my_clinic/app/app.dialogs.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/services/appointment_service.dart';
import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/models/patient.dart';
import 'package:book_my_clinic/models/doctor.dart';
import 'package:book_my_clinic/models/custom_dialog_data.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';

enum DashboardView { upcoming, past, requests, profile }

class DoctorDashboardViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _patientService = locator<PatientService>();
  final _doctorService = locator<DoctorService>();
  final _appointmentService = locator<AppointmentService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  Map<String, Patient> _patientsData = {};
  Map<String, Patient> get patientsData => _patientsData;

  Patient? _appointmentPatient;
  Patient? get appointmentPatient => _appointmentPatient;

  List<Appointment>? _appointments;
  List<Appointment>? get appointments => _appointments;

  final List<Appointment> _upcomingAppointments = [];
  List<Appointment>? get upcomingAppointments => _upcomingAppointments;

  final List<Appointment> _pastAppointments = [];
  List<Appointment>? get pastAppointments => _pastAppointments;

  final List<Appointment> _appointmentRequests = [];
  List<Appointment>? get appointmentRequests => _appointmentRequests;

  DashboardView _currentView = DashboardView.upcoming;
  DashboardView get currentView => _currentView;

  bool _isMenuExpanded = true;
  bool get isMenuExpanded => _isMenuExpanded;

  bool isEditing = false;

  void toggleEditing() {
    isEditing = !isEditing;
    rebuildUi();
  }

  void toggleMenu() {
    _isMenuExpanded = !_isMenuExpanded;
    rebuildUi();
  }

  void setCurrentView(DashboardView view) {
    _currentView = view;
    rebuildUi();
  }

  Future updateProfile(Doctor doctor) async {
    var result = await _doctorService.updateDoctor(_doctor!.uid, doctor);
    if (result.isSuccess) {
      await fetchDoctorData();
    } else {
      showError(result.error);
    }
    toggleEditing();
    rebuildUi();
  }

  Future fetchDoctorData() async {
    setBusy(true);

    String uid = _authenticationService.getCurrentUser()!.uid;
    var result = await _doctorService.getDoctor(uid);
    if (result.isSuccess) {
      _doctor = result.value;
      rebuildUi();
    } else {
      showError(result.error);
    }
  }

  Future logout() async {
    await _authenticationService.signOut();
    _navigationService.clearStackAndShow('/login-view');
  }

  Future fetchPatientData(String patientID) async {
    var result = await _patientService.getPatient(patientID);
    if (result.isSuccess) {
      _appointmentPatient = result.value;
    } else {
      showError(result.error);
    }
  }

  Future fetchDoctorAppointments() async {
    var result =
        await _appointmentService.fetchAppointments(doctorID: _doctor!.uid);
    if (result.isSuccess) {
      _appointments = result.value;
      for (var appointment in _appointments!) {
        if (appointment.status == "pending") {
          _appointmentRequests.add(appointment);
          await fetchPatientData(appointment.patientId);
          if (_appointmentPatient != null) {
            _patientsData[appointment.patientId] = _appointmentPatient!;
          }
        } else if (appointment.status == "accepted" ||
            appointment.status == "rescheduled") {
          if (appointment.dateTime.isAfter(DateTime.now())) {
            _upcomingAppointments.add(appointment);
            await fetchPatientData(appointment.patientId);
            if (_appointmentPatient != null) {
              _patientsData[appointment.patientId] = _appointmentPatient!;
            }
          } else {
            _pastAppointments.add(appointment);
            await fetchPatientData(appointment.patientId);
            if (_appointmentPatient != null) {
              _patientsData[appointment.patientId] = _appointmentPatient!;
            }
          }
        }
        _upcomingAppointments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        _pastAppointments.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        _appointmentRequests.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      }
    } else {
      showError(result.error);
    }
    setBusy(false);
  }

  void onManageAppointmentTap(Appointment appointment, Patient patient) async {
    var dialogData =
        CustomDialogData(appointment: appointment, patient: patient);
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.manageAppointment,
      data: dialogData,
    );

    if (response!.confirmed && response.data is String) {
      String status = response.data;
      print(response.data);

      var result = status == "accepted"
          ? await _appointmentService.updateAppointment(
              appointmentId: appointment.id,
              status: status,
            )
          : await _appointmentService.cancelAppointment(
              appointmentId: appointment.id);

      if (result.isSuccess) {
        _appointmentRequests.remove(appointment);
      } else {
        showError(result.error);
      }
    }
    rebuildUi();
  }

  Future<void> onRescheduleAppointmentTap(
      Appointment appointment, Patient patient) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.rescheduleAppointment,
      data: patient,
    );
    if (response!.confirmed && response.data is DateTime) {
      DateTime selectedDate = response.data;
      var result = await _appointmentService.rescheduleAppointment(
          appointmentId: appointment.id, newDateTime: selectedDate);
      if (!result.isSuccess) {
        showError(result.error);
      }
    }
    upcomingAppointments!.clear();
    appointmentRequests!.clear();
    pastAppointments!.clear();
    await fetchDoctorAppointments();
    rebuildUi();
  }
}
