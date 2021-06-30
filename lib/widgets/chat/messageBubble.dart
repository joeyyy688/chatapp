import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final Timestamp messageTime;
  final Key key;
  final String username;

  const MessageBubble(
      {required this.message,
      required this.isMe,
      required this.key,
      required this.messageTime,
      required this.username});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: widget.isMe
                  ? Colors.grey[300]
                  : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft:
                    !widget.isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight:
                    widget.isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 130,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: widget.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text('${widget.username}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.isMe ? Colors.black : Colors.white)),
                Text(
                  widget.message,
                  textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: widget.isMe ? Colors.black : Colors.white),
                ),
                // Row(
                //   children: [
                //     Text(
                //       '${widget.messageTime.toDate().hour.toString() + ":" + widget.messageTime.toDate().minute.toString()}',
                //       style: TextStyle(
                //           fontSize: 9,
                //           color: widget.isMe
                //               ? Colors.black
                //               : Colors.white),
                //     ),
                //     Icon(Icons.done_all_outlined)
                //   ],
                // )
              ],
            )),
      ],
    );
  }
}
