import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/StoreLocal.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/AdminProfileScreen.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/NotiScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:bangiayhaki/views/ProfileScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomBarCustom extends StatefulWidget {
  const BottomBarCustom({required this.userid, Key? key, required this.active})
      : super(key: key);

  final int active;
  final int userid;

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  @override
  void initState() {
    super.initState();
    Stored.saveText("userid", widget.userid.toString());
    setState(() {});
  }

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return widget.userid == 1
                              ? AdminProfileScreen(
                                  id: widget.userid,
                                )
                              : ProfileScreen(
                                  id: widget.userid,
                                );
                        }));
                      }
                    },
                    icon: Icon(
                        widget.active != 0 ? Icons.home_outlined : Icons.home)),
                IconButton(
                    onPressed: () {
                      if (widget.active != 1)
                        Navigator.pushReplacementNamed(context, "/noti");
                    },
                    icon: Icon(widget.active != 1
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_active)),
                IconButton(
                    onPressed: () async {
                      String id = await Stored.loadStoredText("userid");
                      setState(() {});

                      if (kDebugMode) {
                        print(id);
                      }
                      if (widget.active != 2) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return int.parse(id) == 1
                              ? AdminProfileScreen(id: int.parse(id))
                              : ProfileScreen(
                                  id: int.parse(id),
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
