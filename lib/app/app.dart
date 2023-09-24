import 'package:book_my_clinic/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:book_my_clinic/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:book_my_clinic/ui/views/home/home_view.dart';
import 'package:book_my_clinic/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:book_my_clinic/services/authentication_service.dart';
import 'package:book_my_clinic/services/appointment_service.dart';
import 'package:book_my_clinic/services/doctor_service.dart';
import 'package:book_my_clinic/services/patient_service.dart';
import 'package:book_my_clinic/ui/views/doctors/doctor_dashboard/doctor_dashboard_view.dart';
import 'package:book_my_clinic/ui/views/authentication/login/login_view.dart';
import 'package:book_my_clinic/ui/views/authentication/sign_up/sign_up_view.dart';
import 'package:book_my_clinic/ui/views/patients/patient_dashboard/patient_dashboard_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DoctorDashboardView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: PatientDashboardView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: AppointmentService),
    LazySingleton(classType: DoctorService),
    LazySingleton(classType: PatientService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
