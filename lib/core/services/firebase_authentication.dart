import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:walk_win/core/constants/app_consts.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      EasyLoading.show(
        status: "Loading...",
        indicator: const CircularProgressIndicator(),
        dismissOnTap: true,
      );
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCode.password) {
        Fluttertoast.showToast(msg: "Please check your password.");
        return null;
      } else if (e.code == FirebaseErrorCode.network) {
        Fluttertoast.showToast(msg: "Please check your internet connection.");
        return null;
      } else if (e.code == FirebaseErrorCode.email) {
        Fluttertoast.showToast(msg: "Please enter valid email.");
        return null;
      } else if (e.code == FirebaseErrorCode.user) {
        Fluttertoast.showToast(msg: "User not found.");
        return null;
      } else if (e.code == FirebaseErrorCode.manyRequest) {
        Fluttertoast.showToast(
            msg:
                "We have blocked all requests from this device due to unusual activity. Try again later.");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    } finally {
      EasyLoading.dismiss();
    }

    return null;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createUser(
      String name, String surname, String email, String password) async {
    try {
      EasyLoading.show(
        status: "Loading...",
        indicator: const CircularProgressIndicator(),
        dismissOnTap: true,
      );

      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("Users").doc(user.user?.uid).set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password
      });

      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCode.emailAlreadyExists) {
        Fluttertoast.showToast(msg: "This email already use.");
      } else if (e.code == FirebaseErrorCode.network) {
        Fluttertoast.showToast(msg: "Please check your internet connection.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }
}
