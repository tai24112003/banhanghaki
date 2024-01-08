import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({required this.status, super.key});
  final String status;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.all(8),
      height: MediaQuery.sizeOf(context).height * 0.23,
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "No00000000",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "1/1/2003",
                    style: TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                        style:
                            TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                        text: "Số lượng: ",
                        children: [
                          TextSpan(
                              text: "03",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ]),
                  ),
                  RichText(
                    text: const TextSpan(
                        style:
                            TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                        text: "Tổng tiền: ",
                        children: [
                          TextSpan(
                              text: "\$150",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      onPressed: () {},
                      child: const Text(
                        "Chi tiết",
                        style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    widget.status,
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
