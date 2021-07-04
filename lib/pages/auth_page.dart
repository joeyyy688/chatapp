import 'dart:io';

import 'package:chatapp/widgets/auth/authForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  Future<void> _submitAuthFormSignUp(String email, String password,
      String username, File userImageFile, bool isLogin) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: username, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final storageReference = FirebaseStorage.instance
            .ref()
            .child('userImage')
            .child(authResult.user!.uid + '.png');

        await storageReference.putFile(userImageFile).whenComplete(() => null);

        final url = await storageReference.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'userImage': url,
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = "An Error Occured, please check your credentials";

      if (e.message != null) {
        errorMessage = e.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  Future<void> _submitAuthFormLogin(
      String email, String password, String username, bool isLogin) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: username, password: password);
      }
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = "An Error Occured, please check your credentials";

      if (e.message != null) {
        errorMessage = e.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthFormSignUp, isLoading, _submitAuthFormLogin));
  }
}
