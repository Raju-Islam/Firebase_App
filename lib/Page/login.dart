// ignore_for_file: unused_field, unnecessary_null_comparison, avoid_unnecessary_containers, unused_catch_clause, empty_catches, nullable_type_in_catch_clause, avoid_print

import 'package:firebase_app/Page/forgot_pass.dart';
import 'package:firebase_app/Page/sign_up.dart';
import 'package:firebase_app/Page/user_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  var email = " ";
  var password = " ";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const UserMain()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user fount for that email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'No user fount for that email',
              style: TextStyle(fontSize: 18.00, color: Colors.red),
            )));
      } else if (error.code == 'wrong passwor') {
        print('Wrong password provide by the user');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'Wrong password provied by the user',
              style: TextStyle(fontSize: 18.00, color: Colors.white),
            )));
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Login is successful',
          style: TextStyle(fontSize: 18, color: Colors.white),
        )));
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const UserMain()));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/login.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please enter email,';
                    } else if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length <= 5) {
                      return 'Password at list 6 charecters';
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                        child: const Text('Login')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPass()));
                        },
                        child: const Text('Forget password'))
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do not have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      const SignUp(),
                                  transitionDuration:
                                      const Duration(seconds: 0)),
                              (route) => false);
                        },
                        child: const Text(
                          'create account',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
