import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(
                minWidth: 200, maxWidth: 300, minHeight: 300, maxHeight: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/logo.png'),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffa8e3e8),
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 200, maxWidth: 300),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffa8e3e8)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LOGIN"),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
