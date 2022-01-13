import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:personal_expenses/model/expense.dart';
import 'package:http/http.dart' as http;
import 'package:personal_expenses/util/helper_functions.dart';

class CrudOperations {
  static Future<Expense> getExpense(context, String id) async {
    late Expense result;
    try {
      final response = await http.get(
        Uri.parse("http://localhost:8080/expense/" + id),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = Expense.fromJson(item);
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  static Future<bool> editExpense(
      int id, String expenseTitle, num amount, String date) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/update-expense'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'expenseTitle': expenseTitle,
        "amount": amount,
        "date": date,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addExpense(
      int id, String expenseTitle, num amount, String date) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/add-expense'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'expenseTitle': expenseTitle,
        "amount": amount,
        "date": date,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Expense>> getAllExpenses(context) async {
    late List<Expense> result;
    try {
      final response = await http.get(
        Uri.parse("http://localhost:8080/expenses"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        result = HelperFunctions.parseExpenseArray(response.body);
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  static Future<bool> deleteExpense(int id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8080/delete-expense/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
