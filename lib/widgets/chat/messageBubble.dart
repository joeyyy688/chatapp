import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp messageTime;
  final Key key;

  const MessageBubble(
      {required this.message,
      required this.isCurrentUser,
      required this.key,
      required this.messageTime});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.isCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: widget.isCurrentUser
                  ? Colors.grey[300]
                  : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !widget.isCurrentUser
                    ? Radius.circular(0)
                    : Radius.circular(12),
                bottomRight: widget.isCurrentUser
                    ? Radius.circular(0)
                    : Radius.circular(12),
              ),
            ),
            width: 130,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: TextStyle(
                      color:
                          widget.isCurrentUser ? Colors.black : Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.messageTime.toDate().hour.toString() + ":" + widget.messageTime.toDate().minute.toString()}',
                      style: TextStyle(
                          fontSize: 9,
                          color: widget.isCurrentUser
                              ? Colors.black
                              : Colors.white),
                    ),
                    Icon(Icons.done_all_outlined)
                  ],
                )
              ],
            )),
      ],
    );
  }
}
