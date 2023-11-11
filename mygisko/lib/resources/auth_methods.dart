import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/rendering.dart';
import 'package:mygisko/resources/storage_methods.dart';
import 'package:mygisko/services/facebook_sign_in.dart';
import 'package:mygisko/services/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String gender,
    required String mblno,
    required String ibrands,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          mblno.isNotEmpty ||
          gender.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (kDebugMode) {
          print(cred.user!.uid);
        }

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false, 'image/*');

        // Add user to our database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'mblno': mblno,
          'password': password,
          'photoUrl': photoUrl,
          'followers': [],
          'following': [],
          'ibrands': ibrands,
          'gender': gender,
        });

        res = "success";
      } else {
        res = "Please enter your details";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter your email and password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Check if a user is already registered based on UID
  Future<bool> isUserRegistered(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      return userDoc.exists;
    } catch (error) {
      print('Error checking user registration: $error');
      return false; // Assume not registered in case of error
    }
  }

  Future<String> signOut(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final googleSignInService = GoogleSignInService();
    final signInWithFacebook = FacebookSignInService();

    String res = "Some error occurred";

    try {
      if (user != null) {
        final isUserRegistered = await AuthMethods().isUserRegistered(user.uid);
        if (isUserRegistered) {
          await FirebaseAuth.instance.signOut();
        }
      }

      await googleSignInService.googleSignOut();
      await signInWithFacebook.facebooksignOut();

      res = "success";
      if (res == "success") {
        res = "success";
      } else {
        res = "Error signing out";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching user profile: $error');
      return null;
    }
  }
}
