import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("This works"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/k6jX4gKh0FXICJJfAf94/messages')
                .snapshots()
                .listen((event) {
              //print(event.docs[0]['text']);
              event.docs.forEach((element) {
                print(element['text']);
              });
            });
          }),
    );
  }
}
