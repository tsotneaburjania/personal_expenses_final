import 'package:flutter/material.dart';
import 'package:personal_expenses/data/expense_list_data_provider.dart';
import 'package:personal_expenses/presentation/sheets/modal_sheets.dart';
import 'package:personal_expenses/presentation/widgets/expense_tile.dart';
import 'package:personal_expenses/util/helper_functions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    final expenseListRequest =
        Provider.of<ExpenseListDataProvider>(context, listen: false);
    expenseListRequest.getAllExpensesData(context);

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final expense = Provider.of<ExpenseListDataProvider>(context);
    late num totalExpense;
    late int maxIndex;
    if (expense.expenseList.isNotEmpty){
      totalExpense =
      HelperFunctions.calculateTotalExpense(expense.expenseList);
      maxIndex = HelperFunctions.getMaxIndex(expense.expenseList);
    }

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter),
          ),
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: expense.loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Personal Expenses",
                            style: TextStyle(fontSize: 27),
                          ),
                          FloatingActionButton(
                              backgroundColor: const Color(0xff267b7b),
                              child: const Icon(Icons.add),
                              onPressed: () {
                                ModalSheets.displayAddBottomSheet(
                                    context, maxIndex);
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 0.4, color: Colors.black54),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                    minHeight: 200, maxHeight: 200),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        totalExpense.toDouble().toString() +
                                            "\$",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: AnimatedList(
                        initialItemCount: expense.expenseList.length,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                              position: _animation,
                              child: ExpenseTile(
                                  id: expense.expenseList[index].id,
                                  expenseTitle:
                                      expense.expenseList[index].expenseTitle,
                                  amount: expense.expenseList[index].amount,
                                  date: expense.expenseList[index].date));
                        },
                      ),
                    ),
                  ],
                )),
    );
  }
}
