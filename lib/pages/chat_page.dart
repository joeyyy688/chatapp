import 'package:chatapp/widgets/chat/messages.dart';
import 'package:chatapp/widgets/chat/newMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging();
  }

  Future<void> firebaseCloudMessaging() async {
    FirebaseAuth.instance.currentUser!
        .getIdToken()
        .then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JKD Messanger'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert_outlined,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app_outlined),
                      Text("Logout")
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: Messages(),
            ),
            Container(
              //height: 100,
              child: NewMessage(),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.message),
      //     onPressed: () {
      //       FirebaseFirestore.instance
      //           .collection('chats/k6jX4gKh0FXICJJfAf94/messages')
      //           .add({'text': 'This was added by clicking the button'});
      //       //     .listen((event) {
      //       //   //print(event.docs[0]['text']);
      //       //   event.docs.forEach((element) {
      //       //     print(element['text']);
      //       //   });
      //       // });
      //     }),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('chats/k6jX4gKh0FXICJJfAf94/messages')
//             .snapshots(),
//         builder: (context, snapshot) {
//           print('Snapshot had data - ${snapshot.hasData}');
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) => Container(
//               padding: EdgeInsets.all(8),
//               child: Text('${snapshot.data!.docs[index]['text']}'),
//             ),
//           );
//         },
//       ),
