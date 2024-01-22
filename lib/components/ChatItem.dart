import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({super.key, required this.idTo, required this.onClick});
  final int idTo;
  final Function(int) onClick;
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
      child: Container(
        width: MediaQuery.of(context).size.height / 8,
        child: Column(
          children: [Text("Ten"), Text("Tin nhắn")],
        ),
      ),
    );
  }
}
