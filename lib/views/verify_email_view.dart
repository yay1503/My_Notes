import 'package:flutter/material.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : const Text("Verify Email"),),
      body: Column(children : [
            const Text("We 've sent you an email verification link.Please check your email."),
            const Text("If you haven't received email yet, press the button below"),
            TextButton(
              onPressed : () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child : const Text("Send email verification")
            ),
            TextButton(
              onPressed : () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, 
                  (_) => false,
                );
              },
              child : const Text("Restart"),
            )
          ]),
    );
  }
}