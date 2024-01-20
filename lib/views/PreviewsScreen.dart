import 'package:bangiayhaki/components/Previews.dart';
import 'package:flutter/material.dart';

class PreviewsScreen extends StatefulWidget {
  const PreviewsScreen({super.key});

  @override
  State<PreviewsScreen> createState() => _PreviewsScreenState();
}

class _PreviewsScreenState extends State<PreviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: // Tính kích thước tối ưu cho AppBar và TabBar

          AppBar(
        title: Text('Đánh giá'),
      ),
      body: Preview(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Xử lý sự kiện khi nút thứ hai được nhấn
              },
              label: Text('Viết đánh giá'),
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
