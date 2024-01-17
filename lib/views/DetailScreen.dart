import 'package:bangiayhaki/components/Detail.dart';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});
  final id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Detail(
        id: widget.id,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Xử lý sự kiện khi nút thứ hai được nhấn
              },
              label: Text('Add to cart'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Độ bo góc là 8.0
              ),
              backgroundColor: Colors.black, // Màu nền đen
              foregroundColor: Colors.white, // Màu chữ trắng
              icon: Icon(Icons.add_shopping_cart),
            ),
          ) // Khoảng cách giữa hai nút
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
