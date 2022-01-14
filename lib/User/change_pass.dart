// ignore_for_file: unused_field, unused_catch_clause, empty_catches

import 'package:firebase_app/Page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool _obscuretext = true;
  final _formkey = GlobalKey<FormState>();
  var newPassword = ' ';
  final newPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
  }

  changePass() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text('Password has been changed',
            style: TextStyle(color: Colors.white,fontSize: 16),)));
    } on FirebaseAuthException catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.00),
                  child: Image.asset('assets/change_pass.jpg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: false,
                  obscureText: _obscuretext,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_obscuretext == true) {
                                _obscuretext = false;
                              } else {
                                _obscuretext = true;
                              }
                            });
                          },
                          icon: const Icon(Icons.visibility)),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      border: const OutlineInputBorder(),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 16)),
                          controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password.';
                    }
                    if (value.length <= 5) {
                      return 'Password should be 6 charecters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePass();
                      }
                      
                    },
                    child: const Text('Change'))
              ],
            ),
          )),
    );
  }
}
