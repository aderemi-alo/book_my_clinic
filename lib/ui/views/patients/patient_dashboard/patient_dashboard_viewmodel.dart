import 'package:book_my_clinic/models/appointment.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:book_my_clinic/app/app.dialogs.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/services/appointment_service.dart';
import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/models/patient.dart';
import 'package:book_my_clinic/models/doctor.dart';
import 'package:stacked_services/stacked_services.dart';

enum DashboardView { upcoming, past, profile, book }

class PatientDashboardViewModel extends FormViewModel {
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

  Future logout() async {
    await _authenticationService.signOut();
    _navigationService.clearStackAndShow('/login-view');
  }

  Future fetchPatientData() async {
    String uid = _authenticationService.getCurrentUser()!.uid;

    setBusy(true);
    var result = await _patientService.getPatient(uid);
    if (result.isSuccess) {
      _patient = result.value;
      rebuildUi();
    } else {
      showError(result.error);
    }
  }

  Future updateProfile(Patient patient) async {
    var result = await _patientService.updatePatient(_patient!.uid, patient);
    if (result.isSuccess) {
      await fetchPatientData();
    } else {
      showError(result.error);
    }
    toggleEditing();
    rebuildUi();
  }

  Future searchForDoctorBySpeciality(String speciality) async {
    var result = await _doctorService.searchDoctorBySpeciality(speciality);
    if (result.isSuccess) {
      _searchResults = result.value;
    } else {
      showError(result.error);
    }
    rebuildUi();
  }

  Future fetchDoctorData(String doctorID) async {
    var result = await _doctorService.getDoctor(doctorID);
    if (result.isSuccess) {
      _appointmentDoctor = result.value;
    } else {
      showError(result.error);
    }
  }

  Future fetchPatientAppointments() async {
    var result =
        await _appointmentService.fetchAppointments(patientID: _patient!.uid);

    if (result.isSuccess) {
      _appointments = result.value;
      for (var appointment in _appointments!) {
        if (appointment.dateTime.isAfter(DateTime.now()) &&
            appointment.status == "accepted") {
          _upcomingAppointments.add(appointment);
          await fetchDoctorData(appointment.doctorId);
          if (_appointmentDoctor != null) {
            _doctorsData[appointment.doctorId] = _appointmentDoctor!;
          }
        } else if (appointment.dateTime.isBefore(DateTime.now()) &&
            appointment.status == "accepted") {
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
      showError(result.error);
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
        showError(result.error);
      }
    }
  }
}
