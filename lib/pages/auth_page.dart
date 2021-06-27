import 'package:chatapp/widgets/authForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username, 'email': email});
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
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString().substring(37)),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, isLoading));
  }
}
