import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:new_chat/widgets/authentication/authenticate_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chat/constants/theme_and_style.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthenticationForm(
      {required String email,
      required String password,
      required String userName,
      required bool isLogin,
      required File? userImage,
      required BuildContext ctx}) async {
    UserCredential result;

    try {
      setState(() {
        _isLoading = !_isLoading;
      });

      if (isLogin) {
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${result.user!.uid}.jpg');

        await ref.putFile(userImage!).whenComplete(() => null);

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          'username': userName,
          'email': email,
          'image_url': imageUrl,
        });
      }
      setState(() {
        _isLoading = !_isLoading;
      });
    } catch (error) {
      var message = 'An error occured. Email is probably in use';
      if (mounted) {
        setState(() {
          _isLoading = !_isLoading;
        });
        // ignore: avoid_print
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultColorsPalette.defoultColorScheme.error,
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    DefaultColorsPalette.defoultColorScheme.primary,
                    DefaultColorsPalette.defoultColorScheme.secondary
                  ], begin: Alignment.topLeft),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(deviceSize.height / 6),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.linearToSrgbGamma(),
                        child: FlutterLogo(size: deviceSize.height / 8),
                      ),
                      Text(
                        'Flutter Chat',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            flex: 4,
            child: AuthenticationFormWidget(
                submitForm: _submitAuthenticationForm, isLoading: _isLoading),
          )
        ],
      ),
    );
  }
}
