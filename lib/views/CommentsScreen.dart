import 'package:bangiayhaki/components/MyReviewItem.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Đánh giá của tôi",
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyReviewItem(),
              MyReviewItem(),
              MyReviewItem(),
              MyReviewItem(),
              MyReviewItem(),
            ],
          ),
        ),
      ),
    );
  }
}
