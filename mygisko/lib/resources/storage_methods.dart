import 'package:flutter/foundation.dart';
// ignore: unused_import
import "package:flutter/material.dart";

import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to the firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost, String contentType) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // Determine content type based on the file extension
    String contentType = 'image/jpeg';
    if (childName.toLowerCase().endsWith('.png')) {
      contentType = 'image/png';
    }

    SettableMetadata metadata = SettableMetadata(contentType: contentType);

    UploadTask uploadTask = ref.putData(file, metadata);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
