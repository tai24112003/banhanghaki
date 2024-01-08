import 'package:flutter/material.dart';

class NotiItem extends StatelessWidget {
  const NotiItem({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: [
          Row(
            children: [
              Image(
                image: AssetImage("assets/st.JPG"),
                width: 100,
                height: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đơn hàng asjkfbhkjasbfkjsdgb của bạn đã được xác nhận",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. adipiscing nec",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: Text(
              "New!",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
