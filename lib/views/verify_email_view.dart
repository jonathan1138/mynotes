import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've send you an email verifition - please check your email and verify"),
          const Text(
              "If you haven't received your verification email yet, please press this button"),
          TextButton(
            onPressed: () async {
              devtools.log('Pressed email verify');
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await FirebaseAuth.instance.signOut();
              navigator.pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
