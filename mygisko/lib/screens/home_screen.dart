import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mygisko/resources/auth_methods.dart';
import 'package:mygisko/services/facebook_sign_in.dart';
import 'package:mygisko/services/google_sign_in.dart';

import 'package:mygisko/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final googleSignInService = GoogleSignInService();
    final signInWithFacebook = FacebookSignInService();

    try {
      if (user != null) {
        final isUserRegistered = await AuthMethods().isUserRegistered(user.uid);
        if (isUserRegistered) {
          await FirebaseAuth.instance.signOut();
        }
      }

      await googleSignInService.googleSignOut();
      await signInWithFacebook.facebooksignOut();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //go back to the device's home screen
        SystemNavigator.pop();
        return false;
        //prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF163057),
          actions: [
            IconButton(
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout),
            ),
          ],
          title: const Text('Home'),
        ),
        body: Center(
          child: Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
          ),
        ),
      ),
    );
  }
}
