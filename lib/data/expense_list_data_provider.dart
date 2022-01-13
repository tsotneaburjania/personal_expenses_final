import 'package:flutter/material.dart';
import 'package:personal_expenses/model/expense.dart';
import 'package:personal_expenses/net/crud_operations.dart';

class ExpenseListDataProvider with ChangeNotifier {
  late List<Expense> expenseList = [];
  bool loading = false;

  getAllExpensesData(context) async {
    loading = true;
    expenseList = await CrudOperations.getAllExpenses(context);
    loading = false;

    notifyListeners();
  }
}