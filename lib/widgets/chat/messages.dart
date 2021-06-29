import 'package:chatapp/widgets/chat/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        final currentUserID = FirebaseAuth.instance.currentUser!.uid;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              messageTime: chatDocs[index]['createdAt'],
              key: ValueKey(chatDocs[index].id),
              message: chatDocs[index]['text'],
              isCurrentUser:
                  chatDocs[index]['userId'] == currentUserID ? true : false,
            );
          },
        );
      },
    );
  }
}
