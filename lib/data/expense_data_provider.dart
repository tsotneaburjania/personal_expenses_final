import 'package:flutter/material.dart';
import 'package:personal_expenses/model/expense.dart';
import 'package:personal_expenses/net/crud_operations.dart';

class ExpenseDataProvider with ChangeNotifier {
  Expense expenseImpl = Expense();
  bool loading = false;

  getOneExpenseData(context, String id) async {
    loading = true;
    expenseImpl = await CrudOperations.getExpense(context, id);
    loading = false;

    notifyListeners();
  }
}
