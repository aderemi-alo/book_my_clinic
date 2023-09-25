import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'reschedule_appointment_dialog_model.dart';

const double _graphicSize = 60;

class RescheduleAppointmentDialog
    extends StackedView<RescheduleAppointmentDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const RescheduleAppointmentDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RescheduleAppointmentDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reschedule an Appointment with ${request.data!.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Pick a Date'),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 31)),
                );
                if (pickedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    print(pickedDate);
                    completer(DialogResponse(
                        data: DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ),
                        confirmed: true));
                  }
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                completer(DialogResponse(confirmed: false));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  RescheduleAppointmentDialogModel viewModelBuilder(BuildContext context) =>
      RescheduleAppointmentDialogModel();
}
