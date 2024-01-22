import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/components/NotiItem.dart';
import 'package:bangiayhaki/components/BottomBarCustom.dart';
import 'package:bangiayhaki/models/NotificationModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/NotiPresenter.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({required this.userId, super.key});
  final int userId;
  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  @override
  List<Notifications> lstNotifications = [];
  late NotiPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = NotiPresenter();
    loadNotificationses();
  }

  Future<void> loadNotificationses() async {
    final Notificationses = await presenter.getNotificationbyId(widget.userId);
    setState(() {
      lstNotifications = Notificationses;
    });
    print(lstNotifications);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar(title: "Thông báo", UserId: widget.userId),
        preferredSize: const Size.fromHeight(100),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                itemCount: lstNotifications.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return NotiItem(
                      title: lstNotifications[index].name,
                      content: lstNotifications[index].content);
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(active: 1, userid: widget.userId),
    );
  }
}
