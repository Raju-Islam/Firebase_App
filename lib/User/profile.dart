// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:firebase_app/Page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final lastSigninTime =
      FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;

  User? user = FirebaseAuth.instance.currentUser;

  VerifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification Email has been sent')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(35),
                child: Image.asset('assets/profile.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text(
                    'User ID',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    uid,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Email :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  user!.emailVerified
                      ? const Text(
                          ' Verified',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              VerifyEmail();
                            });
                          },
                          child: const Text(
                            'Verify Email',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    'Creation Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    creationTime.toString(),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Last sign in time :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    lastSigninTime.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                        (route) => false);
                  },
                  child: const Text('Logout'))
            ],
          ),
        ),
      ],
    );
  }
}
