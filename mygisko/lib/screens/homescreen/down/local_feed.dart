//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Localfeed extends StatefulWidget {
  const Localfeed({super.key});

  @override
  State<Localfeed> createState() => _LocalfeedState();
}

class _LocalfeedState extends State<Localfeed> {
   @override
  Widget build(BuildContext context) {
    return const Scaffold( body: Center(
          child: Text("Localfeed"
            //FirebaseAuth.instance.currentUser!.email.toString(),
          ),
        ),);
  }
}