import 'package:brew_crew/constant/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/constant/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  String name = '';
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  dynamic _currentSugar = '0';
  int _currentStrength = 100;
  

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text("Sign up in to brew crew"),
              elevation: 0,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("Sign In"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ],
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
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
                              // setState(() => loading = true);
                              setState(() => error = '');
                              // Customization to disable printing previous set error value
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
                          TextFormField(
                            decoration: textInputdec.copyWith(
                              hintText: "Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.brown[400],
                              ),
                            ),
                            validator: (val) =>
                                val!.isEmpty ? "Please enter your name" : null,
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                              decoration: textInputdec,
                              value: _currentSugar,
                              onChanged: (val) {
                                setState(() {
                                  _currentSugar = val;
                                });
                              },
                              items: sugars.map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text('$e sugar(s)'));
                              }).toList()),
                          Slider(
                              min: 100,
                              max: 900,
                              divisions: 8,
                              activeColor: Colors.brown[_currentStrength],
                              inactiveColor: Colors.red[100],
                              thumbColor: Colors.brown[400],
                              label: _currentStrength.toString(),
                              value: _currentStrength.toDouble(),
                              onChanged: (val) {
                                setState(() {
                                  _currentStrength = val.round();
                                });
                              }),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _auth.registrWithEandP(
                                  email,
                                  password,
                                  _currentSugar,
                                  name,
                                  _currentStrength,
                                );
                                if (result == null) {
                                  setState(() => error = "Enter Valid email");
                                  setState(() => loading = false);
                                }
                              }
                            },
                            child: const Text(
                              "Register",
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
                      ),
                    ))),
          );
  }
}
