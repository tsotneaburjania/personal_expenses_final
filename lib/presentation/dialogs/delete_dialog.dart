import 'package:flutter/material.dart';
import 'package:personal_expenses/data/expense_list_data_provider.dart';
import 'package:personal_expenses/net/crud_operations.dart';
import 'package:personal_expenses/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

removeItemDialogue(BuildContext context, int id) {
  final expenseListRequest =
  Provider.of<ExpenseListDataProvider>(context, listen: false);

  Widget cancelButton = TextButton(
    child: const Text("Cancel", style: TextStyle(color: Color(0xff267b7b)),),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget removeButton = TextButton(
    child: const Text("REMOVE", style: TextStyle(color: Colors.red),),
    onPressed:  () {
      CrudOperations.deleteExpense(id);
      expenseListRequest.getAllExpensesData(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: const Text("Removal"),
    content: const Text("Are you serious?"),
    actions: [
      cancelButton,
      removeButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}