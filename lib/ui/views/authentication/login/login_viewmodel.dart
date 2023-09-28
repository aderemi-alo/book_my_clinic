import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/app/app.router.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:book_my_clinic/ui/common/widgets.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';

class LoginViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _patientService = locator<PatientService>();
  final _doctorService = locator<DoctorService>();
  String role = 'patient';

  void login(String email, String password) async {
    var result = await _authenticationService.login(email, password);

    if (result.isSuccess) {
      if (role == "patient") {
        var uid = _authenticationService.getCurrentUser()!.uid;
        result = await _patientService.getPatient(uid);
        if (result.isSuccess) {
          await _navigationService.replaceWithPatientDashboardView();
        } else {
          showError("This account is not a Patient.");
        }
      } else {
        var uid = _authenticationService.getCurrentUser()!.uid;
        result = await _doctorService.getDoctor(uid);
        if (result.isSuccess) {
          await _navigationService.replaceWithDoctorDashboardView();
        } else {
          showError("This account is not a Doctor.");
        }
      }
    } else {
      showError(result.error);
    }
  }

  void setRole(String role) {
    this.role = role;
    rebuildUi();
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(Routes.signUpView);
  }
}
