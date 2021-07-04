import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage = '';
  TextEditingController messageController = TextEditingController();

  void _sendMessage() async {
    //FocusNode().unfocus();
    final currentUserID = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc('${currentUserID!.uid}')
        .get();

    print(userData['username']);

    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': currentUserID.uid,
      'username': userData['username'],
      'userImage': userData['userImage']
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Type Message'),
              controller: messageController,
              onChanged: (value) {
                setState(() {
                  enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
