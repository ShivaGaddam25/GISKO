//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Shorts extends StatefulWidget {
  const Shorts({super.key});

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
      appBar: null,
      body: Center(
          child: Text("Shorts"
            //FirebaseAuth.instance.currentUser!.email.toString(),
          ),
        ),);
  }
}