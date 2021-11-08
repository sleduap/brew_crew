// import 'dart:html';

import 'package:brew_crew/constant/loading.dart';
import 'package:brew_crew/services/auth.dart';

import 'package:flutter/material.dart';

import 'package:brew_crew/constant/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text("Sign in to brew crew"),
              elevation: 0,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text("Register"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                TextButton(
                  onPressed: () async {
                    await _auth.signAnon();

                    //     dynamic results = await _auth.signAnon();
                    //     // print(results);
                    //     if (results == null) {
                    //       print("Error ocurred");
                    //     } else {
                    //       print("Success");
                    //       print(results.uid);
                    //     }
                    //   },
                  },
                  child: const Text("SKIP"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputdec.copyWith(
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.brown[400],
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? "Enter an Email Address" : null,
                          onChanged: (val) {
                            setState(() => email = val);
                            setState(() => error =
                                ''); // Customization to disable printing previous set error value
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputdec.copyWith(
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.brown[400],
                            ),
                          ),
                          validator: (val) => val!.length < 6
                              ? "Enter a password with 6+ Character"
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signinWithEandP(email, password);
                              if (result == null) {
                                setState(() => error = "User not found");
                                setState(() => loading = false);
                              }
                            }
                          },
                          child: const Text(
                            "SIgn In",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.brown[400]),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ))),
          );
  }
}
