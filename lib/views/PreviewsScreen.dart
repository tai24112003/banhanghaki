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
      appBar: AppBar(
        title: Text('Đánh giá'),
      ),
      body: Preview(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Viết đánh giá'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icon(Icons.add_shopping_cart),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
