import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:new_chat/screens/authentication_screen.dart';
import 'package:new_chat/screens/chat_screen.dart';
import 'package:new_chat/constants/theme_and_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterChat',
      theme: ThemeData(
          primarySwatch: DefaultColorsPalette.defoultColorSwatch,
          colorScheme: DefaultColorsPalette.defoultColorScheme,
          textTheme: defoultTextTheme,
          elevatedButtonTheme: defoultElevatedButton),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (authSnapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthenticationScreen();
        },
      ),
    );
  }
}
