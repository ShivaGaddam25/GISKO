//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygisko/screens/homescreen/down/home_screen.dart';
import 'package:mygisko/screens/homescreen/down/local_feed.dart';
import 'package:mygisko/screens/homescreen/down/profile_screen.dart';
import 'package:mygisko/screens/homescreen/down/shorts_screen.dart';
import 'package:mygisko/screens/homescreen/down/stores_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  //const Listl(),
  // const Search(),
  //const Cart(),
  //const Notifications(),
  const Homescreen(),
  const Stores(),
  const Shorts(),
  const Profile(),
  const Localfeed(),
  // const Text('notifications'),
  //const Profile(
  //uid: FirebaseAuth.instance.currentUser!.uid,
  //),
];
