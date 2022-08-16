import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_chat/widgets/chats/messages.dart';
import 'package:new_chat/widgets/chats/new_messages.dart';
import 'package:new_chat/constants/theme_and_style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //FC messaging functions

  void _onDataInForeground(RemoteMessage message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: DefaultColorsPalette.defoultColorSwatch,
        duration: const Duration(seconds: 30),
        content: Text(
          message.data['message'],
        ),
      ),
    );
  }

  @override
  void initState() {
    // ignore: avoid_print
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    FirebaseMessaging.onMessage.listen(_onDataInForeground);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              DefaultColorsPalette.defoultColorScheme.primary,
              DefaultColorsPalette.defoultColorScheme.secondary,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: const Text('Flutter New Chat'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: DefaultColorsPalette.defoultColorScheme.onPrimary,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'logot',
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: DefaultColorsPalette
                                .defoultColorScheme.secondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Logot',
                            style: TextStyle(
                                color: DefaultColorsPalette
                                    .defoultColorScheme.secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'logot') {
                      FirebaseAuth.instance.signOut();
                    }
                  }),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/background-chat.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 0.08),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            Messages(),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
