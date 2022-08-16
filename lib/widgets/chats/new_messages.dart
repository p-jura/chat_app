import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String? _userMessage = '';
  final _fieldController = TextEditingController();

  void sendMessage() async {
    try {
      final User user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      FirebaseFirestore.instance.collection('chat').add({
        'text': _userMessage,
        'timeStemp': Timestamp.now(),
        'userId': user.uid,
        'userName': userData['username'],
        'userImage': userData['image_url']
      });
      setState(() {
        _userMessage = '';
      });
      _fieldController.clear();
    } catch (er) {
      // ignore: avoid_print
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _fieldController,
              onChanged: (value) {
                setState(() {
                  _userMessage = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                label: Text('Send message'),
              ),
            ),
          ),
          IconButton(
            onPressed: _userMessage!.trim().isEmpty
                ? null
                : () {
                    sendMessage();
                    FocusScope.of(context).unfocus();
                  },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
