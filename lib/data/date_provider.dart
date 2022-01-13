import 'package:flutter/material.dart';
import 'package:personal_expenses/util/helper_functions.dart';

class DateProvider with ChangeNotifier {
  late String dateTime = "2022-01-15 00:00:00.000";
  bool loading = false;

  setPrevTime(String time){
    dateTime = time;

    notifyListeners();
  }

  selectDateProvider(context) {
    loading = true;
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2050,12),
        builder: (context,picker){
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff267b7b),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Color(0xff73cbde),
            ),
            child: picker!,);
        })
        .then((selectedDate) {
      if(selectedDate!=null){
        dateTime = selectedDate.toString();
        loading = false;

        notifyListeners();
      }
    });

  }
}