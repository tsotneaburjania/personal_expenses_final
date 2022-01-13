class Expense {
  int id;
  String expenseTitle;
  num amount;
  String date;

  Expense(
      {this.id = 0, this.expenseTitle = "", this.amount = 0.0, this.date = ""});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      expenseTitle: json['expenseTitle'],
      amount: json['amount'],
      date: json['date'] ?? "",
    );
  }
}
