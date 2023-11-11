//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Stores extends StatefulWidget {
  const Stores({super.key});

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold( body: Center(
          child: Text("Stores"
            //FirebaseAuth.instance.currentUser!.email.toString(),
          ),
        ),);
  }
}