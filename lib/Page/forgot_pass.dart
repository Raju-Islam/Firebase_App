// ignore_for_file: unnecessary_null_comparison, unused_catch_clause, empty_catches, avoid_print

import 'package:firebase_app/Page/login.dart';
import 'package:firebase_app/Page/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var email = ' ';

  final emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  forgetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Password Reset Email has been sent',
            style: TextStyle(color: Colors.white),
          )));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'No user found for that email',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: ListView(
        shrinkWrap: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Image.asset('assets/forget_pass.jpg'),
          ),
          const Center(
            child: Text(
              'Reset link will be send to your email ID!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: _formkey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(color: Colors.red)),
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter vaild email';
                          }
                          return null;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                    });
                                    forgetPass();
                                  }
                                },
                                child: const Text('Send Email')),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: const Text('Login'))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 50),
                        child: Row(
                          children: [
                            const Text(
                              'Do not have an account?',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const SignUp(),
                                            transitionDuration:const Duration(seconds: 0),
                                      ),
                                      (route) => false);
                                },
                                child: const Text('Sign Up'))
                          ],
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
