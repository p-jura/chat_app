import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chat/widgets/chats/chat_buble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('timeStemp', descending: true)
            .snapshots(),
        builder: (context, chatSnapshot) {
          final List<QueryDocumentSnapshot<Object?>>? docs =
              chatSnapshot.data?.docs;

          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return docs != null
              ? ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) => ChatBubble(
                      message: docs[index]['text'],
                      isMe: docs[index]['userId'] == currentUserId,
                      userName: docs[index]['userName'],
                      userImage: docs[index]['userImage'],
                      key: ValueKey(docs[index].id)),
                )
              : Container();
        },
      ),
    );
  }
}
