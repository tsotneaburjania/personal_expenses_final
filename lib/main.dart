import 'package:flutter/material.dart';
import 'package:personal_expenses/data/date_provider.dart';
import 'package:personal_expenses/data/expense_data_provider.dart';
import 'package:personal_expenses/data/expense_list_data_provider.dart';
import 'package:personal_expenses/presentation/screens/home_screen.dart';
import 'package:personal_expenses/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ExpenseDataProvider>(create: (_) => ExpenseDataProvider()),
  ChangeNotifierProvider<ExpenseListDataProvider>(create: (_) => ExpenseListDataProvider()),
  ChangeNotifierProvider<DateProvider>(create: (_) => DateProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      // theme: ThemeData(
      //   textTheme: GoogleFonts.poppinsTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: Color(0xff707070)),
          bodyText2: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: Color(0xff707070)),
        )
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}