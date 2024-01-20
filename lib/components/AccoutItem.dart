import 'package:bangiayhaki/presenters/AccountManagePresenter.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatefulWidget {
  const AccountItem({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    this.onTap,
    this.onClickBtn,
  });
  final int id;
  final String name;
  final String email;
  final String status;
  final void Function(int id, String email)? onTap;
  final void Function(int id)? onClickBtn;

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  late bool _status;

  @override
  Widget build(BuildContext context) {
    widget.status == "1" ? _status = true : _status = false;
    return GestureDetector(
      onTap: () {
        widget.onTap!(widget.id, widget.email);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(color: Colors.grey),
                    softWrap: true,
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, color: Colors.grey, offset: Offset(3, 2))
                  ]),
              child: TextButton(
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    widget.onClickBtn!(widget.id.toInt());
                  },
                  child: Text(
                    _status ? "Khoá" : "Mở",
                    style: const TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
