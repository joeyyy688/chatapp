import 'dart:io';

import 'package:chatapp/widgets/pickers/imagePicker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFnSignUp, this.isLoading, this.submitFnLogin);
  final void Function(
    String email,
    String password,
    String userName,
    File userImageFile,
    bool isLogin,
  ) submitFnSignUp;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFnLogin;
  final isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _passwordVisibile = true;
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String userEmail = '';
  String userName = '';
  String userPassword = '';
  File? userImageFile;

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
    }

    if (!_isLogin) {
      widget.submitFnSignUp(userEmail.trim(), userPassword.trim(),
          userName.trim(), userImageFile!, _isLogin);
    } else {
      widget.submitFnLogin(
          userEmail.trim(), userPassword.trim(), userName.trim(), _isLogin);
    }

    // widget.submitFn(userEmail.trim(), userPassword.trim(), userName.trim(),
    //     userImageFile!, _isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(
                      imagePickFunction: (pickedImage) {
                        userImageFile = pickedImage;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter a Valid E-mail';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        //labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      onSaved: (newValue) {
                        userEmail = newValue!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name field cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      //labelText: 'Username',
                      //labelStyle: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    onSaved: (newValue) {
                      userName = newValue!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    obscureText: _passwordVisibile,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisibile
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisibile = !_passwordVisibile;
                            });
                          },
                        )
                        //labelStyle: TextStyle(fontWeight: FontWeight.bold)
                        ),
                    onSaved: (newValue) {
                      userPassword = newValue!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) ...{
                    Center(child: CircularProgressIndicator()),
                  } else ...{
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                trySubmit();
                              },
                              child: Text(_isLogin ? 'Login' : 'Sign Up')),
                          TextButton(
                              style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create New Account'
                                    : 'I already have an account',
                              ))
                        ],
                      ),
                    )
                  }
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
