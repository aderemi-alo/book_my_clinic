// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/book_appointment/book_appointment_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/manage_appointment/manage_appointment_dialog.dart';
import '../ui/dialogs/reschedule_appointment/reschedule_appointment_dialog.dart';

enum DialogType {
  infoAlert,
  bookAppointment,
  manageAppointment,
  rescheduleAppointment,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.bookAppointment: (context, request, completer) =>
        BookAppointmentDialog(request: request, completer: completer),
    DialogType.manageAppointment: (context, request, completer) =>
        ManageAppointmentDialog(request: request, completer: completer),
    DialogType.rescheduleAppointment: (context, request, completer) =>
        RescheduleAppointmentDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
