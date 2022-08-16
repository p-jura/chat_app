// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:new_chat/pickers/user_image_picker.dart';
import 'package:new_chat/constants/theme_and_style.dart';

class AuthenticationFormWidget extends StatefulWidget {
  const AuthenticationFormWidget(
      {required this.submitForm, required this.isLoading, Key? key})
      : super(key: key);

  final bool isLoading;

  final void Function(
      {required String email,
      required String password,
      required String userName,
      required bool isLogin,
      required File? userImage,
      required BuildContext ctx}) submitForm;

  @override
  State<AuthenticationFormWidget> createState() =>
      _AuthenticationFormWidgetState();
}

class _AuthenticationFormWidgetState extends State<AuthenticationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool _isLogin = true;

  String? _userEmail;
  String? _userPassword;
  String? _userName;
  File? _userImage;

  void pickImage(File pickedImage) {
    _userImage = pickedImage;
  }

  void _tryToSubmit() {
    try {
      if (_userImage == null && !_isLogin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please take a picture',
              textAlign: TextAlign.center,
            ),
          ),
        );
        return;
      }
      var isValid = _formKey.currentState!.validate();

      FocusScope.of(context).unfocus();
      if (isValid) {
        _formKey.currentState!.save();

        widget.submitForm(
            email: _userEmail!.trim(),
            password: _userPassword!.trim(),
            userName: _userName == null ? '' : _userName!.trim(),
            isLogin: _isLogin,
            userImage: _userImage,
            ctx: context);
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text('Validation was unsuccessfull $error'),
        ),
      );
    }
  }

  @override
  void dispose() {
    userNameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme themeColorScheme = Theme.of(context).colorScheme;
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: deviceSize.width / 1.15,
                    height: deviceSize.height / 15,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      elevation: 5,
                      child: TextFormField(
                        key: const ValueKey('email'),
                        onFieldSubmitted: (_) {
                          if (!_isLogin) {
                            userNameFocusNode.requestFocus();
                          } else {
                            passwordFocusNode.requestFocus();
                          }
                        },
                        onSaved: (newValue) {
                          _userEmail = newValue;
                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email adress.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          errorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedErrorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.email_rounded),
                          isDense: true,
                          labelText: 'Email adress',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!_isLogin)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: deviceSize.width / 1.15,
                      height: deviceSize.height / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserImagePicker(
                            pickImagFn: pickImage,
                            deviceSize: deviceSize.height / 15,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Material(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                elevation: 5,
                                child: TextFormField(
                                  focusNode: userNameFocusNode,
                                  key: const ValueKey('userName'),
                                  onFieldSubmitted: (_) {
                                    passwordFocusNode.requestFocus();
                                  },
                                  onSaved: (newValue) {
                                    _userName = newValue;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Enter at least 4 characters ';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    isDense: true,
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'User name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: deviceSize.width / 1.15,
                    height: deviceSize.height / 15,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      elevation: 5,
                      child: TextFormField(
                        focusNode: passwordFocusNode,
                        onSaved: (newValue) {
                          _userPassword = newValue;
                        },
                        onFieldSubmitted: (_) {
                          _tryToSubmit();
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          errorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedErrorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.key),
                          isDense: true,
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator(
                      color: DefaultColorsPalette.defoultColorScheme.tertiary,
                    ),
                  if (!widget.isLoading)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: deviceSize.width / 1.15,
                      height: deviceSize.height / 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5, primary: themeColorScheme.secondary),
                        onPressed: _tryToSubmit,
                        child: Text(
                          _isLogin ? 'LOGIN' : 'REGISTER',
                          style: Theme.of(context).textTheme.button!.copyWith(
                              fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 6,
                  ),
                  if (!widget.isLoading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLogin)
                          const Text(
                            'Dont hava an account?',
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                              _formKey.currentState!.reset();
                            });
                          },
                          child: Text(
                            _isLogin ? 'Register' : 'I hava an account',
                            style: TextStyle(
                                color: themeColorScheme.primary,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
