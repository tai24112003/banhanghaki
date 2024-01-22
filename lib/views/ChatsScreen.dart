import 'package:bangiayhaki/components/ChatItem.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/AccountManagePresenter.dart';
import 'package:bangiayhaki/views/ChatScreen.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<dynamic> lst = [];
  void onClick(int id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChatScreen(
        idUser: 1,
        toUser: id,
      );
    }));
  }

  void loadUser() {
    dynamic ad;
    AccountManagePresenter().getListUser().then((value) {
      lst = value;
      lst.removeAt(0);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tin nhắn khách hàng"),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: lst.map((e) {
          return ChatItem(
            idTo: e.id,
            onClick: onClick,
            email: e.Email,
            ten: e.Fullname,
          );
        }).toList() /*[
          // ChatItem(idTo: 2, onClick: onClick),
          // ChatItem(idTo: 3, onClick: onClick),
          // ChatItem(idTo: 4, onClick: onClick),
          // ChatItem(idTo: 5, onClick: onClick),
          // ChatItem(idTo: 6, onClick: onClick),
          // ChatItem(idTo: 7, onClick: onClick),
          // ChatItem(idTo: 8, onClick: onClick),
          // ChatItem(idTo: 9, onClick: onClick),
          // ChatItem(idTo: 10, onClick: onClick),
          // ChatItem(idTo: 11, onClick: onClick),
        ]*/
            ),
      ),
    );
  }
}
