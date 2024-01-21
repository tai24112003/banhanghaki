import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({super.key, required this.ths, required this.onClick});
  final Order ths;
  final Function(int)? onClick;
  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(5, 5),
            blurRadius: 6),
        BoxShadow(
            color: const Color.fromARGB(255, 246, 234, 234),
            offset: Offset(-5, -5),
            blurRadius: 6),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${widget.ths.id.toString().padLeft(4, '0')}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(formatDate(widget.ths.date),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18)),
                    )
                  ],
                ),
                Text.rich(TextSpan(
                  text: "Total:",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                        text: " \$${widget.ths.totalAmount}",
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                onPressed: () {
                  widget.onClick!(widget.ths.id);
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
