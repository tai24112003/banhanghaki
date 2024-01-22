import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  const ChatItem(
      {super.key,
      required this.idTo,
      required this.onClick,
      required this.email,
      required this.ten});
  final int idTo;
  final Function(int) onClick;
  final String ten;
  final String email;
  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick(widget.idTo);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 222, 219, 219),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.ten,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.email.length < 20
                      ? widget.email
                      : "${widget.email.substring(0, 17)}...",
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
