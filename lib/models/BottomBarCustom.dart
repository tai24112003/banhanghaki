import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:flutter/material.dart';

class BottomBarCustom extends StatefulWidget {
  BottomBarCustom({super.key, required this.active});
  final active;
  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: BottomAppBar(
            color: Color.fromARGB(255, 255, 255, 255),
            height: MediaQuery.of(context).size.height / 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.active != 0)
                        Navigator.pushReplacementNamed(context, "/home");
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
                    onPressed: () {
                      if (widget.active != 2)
                        Navigator.pushReplacementNamed(context, "/profile");
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
