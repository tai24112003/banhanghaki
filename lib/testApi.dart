import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String _text = "";

  void setText(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  void callApi() async {
    final response = await http.get(Uri.parse('http://192.168.2.19:3000/'));

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành Dart object
      Map<String, dynamic> data = json.decode(response.body);
      setText(data["content"]);
      // print('Title: ${data['title']}');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  void callApi2() async {
    final response =
        await http.get(Uri.parse('http://192.168.2.19:3000/product'));

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành Dart object
      Map<String, dynamic> data = json.decode(response.body);
      setText(data["content"]);
      // print('Title: ${data['title']}');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_text),
          TextButton(onPressed: callApi2, child: const Text("Product Page"))
        ],
      ),
    );
  }
}
