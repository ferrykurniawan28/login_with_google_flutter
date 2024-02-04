import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:tutor_firebase/screens/homescreen.dart';

final _auth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SizedBox(
          height: 50,
          child: SignInButton(
            Buttons.google,
            text: 'Sign in with Google',
            onPressed: () async {
              try {
                GoogleAuthProvider googleProvider = GoogleAuthProvider();
                await _auth.signInWithProvider(googleProvider);
                Get.offAll(() => const HomeScreen());
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}
