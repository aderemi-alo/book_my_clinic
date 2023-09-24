import 'package:book_my_clinic/app/app.locator.dart';
import 'package:book_my_clinic/app/app.router.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
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
}
