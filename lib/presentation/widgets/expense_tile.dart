import 'package:flutter/material.dart';
import 'package:personal_expenses/presentation/sheets/modal_sheets.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {Key? key,
      required this.expenseTitle,
      required this.amount,
      required this.date,
      required this.id})
      : super(key: key);

  final int id;
  final String expenseTitle;
  final num amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: Colors.black54,
            width: 0.4,
          ),
        ),
        color: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    expenseTitle,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(amount.toDouble().toString() + " \$"),
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(date, style: const TextStyle(fontSize: 11)))
            ],
          ),
        ),
      ),
      onTap: () => ModalSheets.displayDetailBottomSheet(context, id.toString()),
    );
  }
}
