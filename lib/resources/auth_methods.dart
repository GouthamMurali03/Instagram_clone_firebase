import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data_models/user.dart';
import '../resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<OurUser> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('Users').doc(currentUser.uid).get();

    return OurUser.fromSnapData(snap);
  }

// Sign up user
  Future<String> signupUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file
      // Here we are using Uint8 list as the file type for the profile image
      }) async {
    String res = 'Some error Occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        UserCredential cred = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        OurUser user = OurUser(
            bio: bio,
            email: email,
            followers: [],
            following: [],
            password: password,
            photoUrl: photoUrl,
            username: username,
            uid: cred.user!.uid);

        // Add user to our firestore database
        _firestore.collection('Users').doc(cred.user!.uid).set(user.toJson());
        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please Enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
