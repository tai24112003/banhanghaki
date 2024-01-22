import 'package:flutter/material.dart';

class NotiItem extends StatelessWidget {
  const NotiItem({Key? key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(content),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
