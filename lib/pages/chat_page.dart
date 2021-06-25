import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/k6jX4gKh0FXICJJfAf94/messages')
            .snapshots(),
        builder: (context, snapshot) {
          print('Snapshot had data - ${snapshot.hasData}');
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text('${snapshot.data!.docs[index]['text']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/k6jX4gKh0FXICJJfAf94/messages')
                .add({'text': 'This was added by clicking the button'});
            //     .listen((event) {
            //   //print(event.docs[0]['text']);
            //   event.docs.forEach((element) {
            //     print(element['text']);
            //   });
            // });
          }),
    );
  }
}
