import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:personal_expenses/data/date_provider.dart';
import 'package:personal_expenses/data/expense_data_provider.dart';
import 'package:personal_expenses/data/expense_list_data_provider.dart';
import 'package:personal_expenses/net/crud_operations.dart';
import 'package:personal_expenses/presentation/dialogs/delete_dialog.dart';
import 'package:personal_expenses/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class ModalSheets {
  static void displayDetailBottomSheet(context, String id) {
    final expenseSingleRequest =
        Provider.of<ExpenseDataProvider>(context, listen: false);
    expenseSingleRequest.getOneExpenseData(context, id);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          final expense = Provider.of<ExpenseDataProvider>(context);
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color: const Color(0xffcbefef),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Center(child: Text(expense.expenseImpl.expenseTitle, style: const TextStyle(fontSize: 30),)),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Expense Amount:", style: TextStyle(fontSize: 18),),
                            Text(expense.expenseImpl.amount.toString() + "\$", style: const TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Date:", style: TextStyle(fontSize: 18),),
                            Text(expense.expenseImpl.date
                                .substring(0, expense.expenseImpl.date.indexOf(" ")), style: const TextStyle(fontSize: 18),)
                          ],
                        ),
                        Container(
                          constraints: const BoxConstraints(minWidth: 200, maxWidth: 300, maxHeight: 300),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FloatingActionButton.large(
                                  backgroundColor: const Color(0xff267b7b),
                                    child: const Icon(Icons.edit),
                                    onPressed: () {
                                      displayEditBottomSheet(
                                          context,
                                          expense.expenseImpl.id,
                                          expense.expenseImpl.expenseTitle,
                                          expense.expenseImpl.amount,
                                          expense.expenseImpl.date
                                      );
                                    }),
                                FloatingActionButton.large(
                                    backgroundColor: const Color(0xff267b7b),
                                    child: const Icon(Icons.delete),
                                    onPressed: () {
                                      removeItemDialogue(context, expense.expenseImpl.id);
                                    }
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void displayAddBottomSheet(context, int maxIndex) {
    TextEditingController _idCtrl = TextEditingController();
    TextEditingController _idAmt = TextEditingController();
    TextEditingController _idTitle = TextEditingController();

    // კონტროლდება იდენტიფიკატორის უნიკალურობა
    _idCtrl.text = (maxIndex + 1).toString();
    final dateRequest = Provider.of<DateProvider>(context, listen: false);
    final expenseListRequest =
        Provider.of<ExpenseListDataProvider>(context, listen: false);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          final date = Provider.of<DateProvider>(context);
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                constraints: const BoxConstraints(minHeight: 400, maxHeight: 450),
                color: const Color(0xffcbefef),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              controller: _idCtrl,
                              textAlign: TextAlign.center,
                              readOnly: true,
                            ),
                            TextField(
                              controller: _idAmt,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: 'Please enter expense amount'),
                            ),
                            TextField(
                              controller: _idTitle,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: 'Please enter expense title'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(minWidth: 80, maxWidth: 100),
                                    child: Text(date.dateTime)
                                ),
                                Column(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          dateRequest.selectDateProvider(context);
                                        },
                                        child: const Text(
                                          'PICK DATE',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(10)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          )),
                                          minimumSize: MaterialStateProperty.all<Size>(
                                              const Size(150, 30)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xff267b7b)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          CrudOperations.addExpense(
                                              int.parse(_idCtrl.text),
                                              _idTitle.text,
                                              num.parse(_idAmt.text),
                                              date.dateTime);
                                          expenseListRequest.getAllExpensesData(context);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                                        },
                                        child: const Text(
                                          'ADD',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(10)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          )),
                                          minimumSize: MaterialStateProperty.all<Size>(
                                              const Size(150, 30)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xff267b7b)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static void displayEditBottomSheet(context, int id, String title, num amount, String dateInit) {
    TextEditingController _idCtrl = TextEditingController();
    TextEditingController _idAmt = TextEditingController();
    TextEditingController _idTitle = TextEditingController();

    // კონტროლდება იდენტიფიკატორის უნიკალურობა
    _idCtrl.text = (id).toString();
    _idAmt.text = amount.toString();
    _idTitle.text = title;


    final dateRequest = Provider.of<DateProvider>(context, listen: false);
    final expenseListRequest =
        Provider.of<ExpenseListDataProvider>(context, listen: false);

    dateRequest.setPrevTime(dateInit);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          final date = Provider.of<DateProvider>(context).dateTime;
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 450),
              color: const Color(0xffcbefef),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: _idCtrl,
                            textAlign: TextAlign.center,
                            readOnly: true,
                          ),
                          TextField(
                            controller: _idAmt,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: _idTitle,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  constraints: const BoxConstraints(minWidth: 80, maxWidth: 100),
                                  child: Text(date)
                              ),
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        dateRequest.selectDateProvider(context);
                                      },
                                      child: const Text(
                                        'PICK DATE',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(10)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        )),
                                        minimumSize: MaterialStateProperty.all<Size>(
                                            const Size(150, 30)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff267b7b)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        CrudOperations.editExpense(
                                            int.parse(_idCtrl.text),
                                            _idTitle.text,
                                            num.parse(_idAmt.text),
                                            date);
                                        expenseListRequest.getAllExpensesData(context);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                                      },
                                      child: const Text(
                                        'EDIT',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(10)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        )),
                                        minimumSize: MaterialStateProperty.all<Size>(
                                            const Size(150, 30)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff267b7b)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      )),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
