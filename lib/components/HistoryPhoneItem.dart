import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryPhoneItem extends StatelessWidget {
  const HistoryPhoneItem({super.key, required this.content, required this.txt});
  final String content;
  final TextEditingController txt;

  void onClick(TextEditingController t) {
    t.text = content;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(txt);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color.fromARGB(255, 214, 226, 244)),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.history,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                content.length < 23
                    ? content
                    : "${content.substring(0, 20)}...",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
