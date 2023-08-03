import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerTest extends StatelessWidget {
  const TimePickerTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            TimeOfDay? timeofDay = await showTimePicker(
                confirmText: 'Request Lot ',
                cancelText: 'Cancel',
                helpText: 'Please Select Time for Lot',
                context: context,
                initialTime: TimeOfDay.now());

            if (timeofDay != null && _isTimeAfterCurrent(timeofDay)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("OK: ${timeofDay.hour}:${timeofDay.minute}")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Not Allowed")));
            }
          },
          child: const Text("OK"),
        ),
      ),
    );
  }

  bool _isTimeAfterCurrent(TimeOfDay time) {
    final now = TimeOfDay.now();
    return time.hour > now.hour ||
        (time.hour == now.hour && time.minute >= now.minute);
  }

  void _selectTime(BuildContext context) {
    TimeOfDay _selectedTime = TimeOfDay.now(); // Initial value: current time

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm, // Display hours and minutes

            onTimerDurationChanged: (Duration value) {
              final now = DateTime.now();
              final selectedDateTime = DateTime(
                now.year,
                now.month,
                now.day,
                _selectedTime.hour,
                _selectedTime.minute,
              ).add(value);
              if (!selectedDateTime.isBefore(now)) {
                _selectedTime = TimeOfDay.fromDateTime(now);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("OK: ${_selectedTime}")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("InValid: ${_selectedTime}")));
              }
            },
          ),
        );
      },
    );
  }
}
