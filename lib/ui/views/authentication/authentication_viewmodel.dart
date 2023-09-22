import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/app/app.router.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  void login(String email, String password) async {
    var result = await _authenticationService.login(email, password);

    if (result.isSuccess) {
      _navigationService.navigateToDoctorDashboardView();
    } else {
      print(result.error);
    }
  }

  void signUp(String email, String password) async {
    var result = await _authenticationService.signUp(email, password);

    if (result.isSuccess) {
      _navigationService.navigateToDoctorDashboardView();
    } else {
      print(result.error);
    }
  }
}
