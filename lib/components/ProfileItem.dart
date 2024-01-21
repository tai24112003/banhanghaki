import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem(
      {required this.mywidget,
      required this.detail,
      required this.title,
      super.key});
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final detail;
  final Widget mywidget;
  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(0.01))),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget.mywidget;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.75),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurStyle: BlurStyle.solid,
                  offset: const Offset(3, 3),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.detail,
                      style: const TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 10),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: (MediaQuery.of(context).size.width *
                        MediaQuery.of(context).size.height) *
                    0.00018,
                color: Colors.black.withOpacity(0.6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
