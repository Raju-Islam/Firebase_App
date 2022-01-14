// ignore_for_file: unused_field, unnecessary_null_comparison, unused_catch_clause, unused_local_variable, avoid_print, unused_element

import 'dart:ui';

import 'package:firebase_app/Page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  var email = ' ';
  var password = ' ';
  var confirmPassword = ' ';

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential _userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(_userCredential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
            content: Text(
          'Registured succesfully.Please Sign In',
          style: TextStyle(fontSize: 18,color:Colors.white),
        )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('Password is too weak');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
              content: Text(
            'Password is too weak',
            style: TextStyle(fontSize: 18,color: Colors.white),
          )));
        } else if (error.code == 'email-already-in-use') {
          print('Account is already exits');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Account is already exits',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )));
        } else {
          print('Password and confirm password dose not match');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Password and confirm password dose not match',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formkey,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.00),
                    child: Image.asset("assets/sign_up.jpg"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.00),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.redAccent)),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter email';
                        } else if (!value.contains('@')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 20.00),
                        errorStyle:
                            TextStyle(fontSize: 20.00, color: Colors.redAccent),
                        border: OutlineInputBorder(),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.00),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(fontSize: 20.00)),
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm password';
                        } else if (password != confirmPassword) {
                          return 'Password not matching';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.blue),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                  confirmPassword =
                                      confirmPasswordController.text;
                                });
                                registration();
                              }
                              
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const Login(),
                                      transitionDuration:
                                          const Duration(seconds: 0)));
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
