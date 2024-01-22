import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/NotiScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/ProfileScreen.dart';
import 'package:flutter/material.dart';

class BottomBarCustom extends StatefulWidget {
  const BottomBarCustom(
      {required this.userid, super.key, required this.active});
  final active;
  final userid;
  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  late User user;
  UserPresenter? tmp;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      user = (await tmp?.getUserById(widget.userid))!;
      print("object" + user.Fullname);
      setState(() {});
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: BottomAppBar(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: MediaQuery.of(context).size.height / 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.active != 0) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileScreen(
                            user: user,
                          );
                        }));
                      }
                    },
                    icon: Icon(
                        widget.active != 0 ? Icons.home_outlined : Icons.home)),
                IconButton(
                    onPressed: () {
                      if (widget.active != 1)
                        Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotiScreen(userId: widget.userid),
                          ));
                    },
                    icon: Icon(widget.active != 1
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_active)),
                IconButton(
                    onPressed: () {
                      if (widget.active != 2) {
                        Navigator.popUntil(context, (route) => route.isFirst);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileScreen(
                            user: user,
                          );
                        }));
                      }
                    },
                    icon: Icon(widget.active != 2
                        ? Icons.person_outline
                        : Icons.person)),
              ],
            )),
      ),
    );
  }
}
