import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/app/app.router.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:book_my_clinic/models/patient.dart';
import 'package:book_my_clinic/models/doctor.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';

class SignUpViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _patientService = locator<PatientService>();
  final _doctorService = locator<DoctorService>();
  String role = "patient";

  void signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    String? specialties,
    String? hospital,
    String? hospitalAddress,
  }) async {
    var result = await _authenticationService.signUp(email, password);

    if (result.isSuccess) {
      if (role == "patient") {
        var newPatient = Patient(
            uid: _authenticationService.getCurrentUser()!.uid,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            appointmentIDs: []);
        result = await _patientService.createPatient(newPatient);
      }

      if (role == "doctor") {
        var newDoctor = Doctor(
          uid: _authenticationService.getCurrentUser()!.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          appointmentIDs: [],
          specialties: specialties!
              .split(",")
              .map((s) => s.trim().toLowerCase())
              .toList(),
          hospital: hospital!,
          hospitalAddress: hospitalAddress!,
        );
        result = await _doctorService.createDoctor(newDoctor);
      }

      if (!result.isSuccess) {
        showError(result.error);
        return;
      }

      if (role == "patient") {
        _navigationService.replaceWithPatientDashboardView();
      } else {
        _navigationService.replaceWithDoctorDashboardView();
      }
    } else {
      showError(result.error);
    }
  }

  void setRole(String role) {
    this.role = role;
    rebuildUi();
  }

  void navigateToLogin() {
    _navigationService.navigateToLoginView();
  }
}
