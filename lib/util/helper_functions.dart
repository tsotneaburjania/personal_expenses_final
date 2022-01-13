import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personal_expenses/model/expense.dart';

class HelperFunctions {
  static List<Expense> parseExpenseArray(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<Expense> chars =
    parsed.map<Expense>((json) => Expense.fromJson(json)).toList();
    return chars;
  }

  static num calculateTotalExpense(List<Expense> expenses) {
    num result = 0;
    for (var element in expenses) {
      result += element.amount;
    }

    return result;
  }

  static int getMaxIndex(List<Expense> expenses){
    int max = expenses[0].id;
    for (var element in expenses) {
      if (max < element.id){
        max = element.id;
      }
    }

    return max;
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050))
    .then((value) {
      if (value != null && value != currentDate) {
        return value;
      }
    });

  }

}
