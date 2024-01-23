import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/DetailOrderScreen.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({required this.myorder, super.key});
  final Order myorder;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> implements UserView {
  String dateformat(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  UserPresenter? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = UserPresenter(this);
  }

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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "#${widget.myorder.id.toString().padLeft(5, '0')}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    dateformat(widget.myorder.date),
                    style: const TextStyle(
                        color: Color.fromRGBO(128, 128, 128, 1)),
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
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(128, 128, 128, 1)),
                        text: "Số lượng: ",
                        children: [
                          TextSpan(
                              text: widget.myorder.quantity.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(128, 128, 128, 1)),
                        text: "Tổng tiền: ",
                        children: [
                          TextSpan(
                              text: "\$ ${widget.myorder.totalAmount}",
                              style: const TextStyle(
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailOrderScreen(
                                total: widget.myorder.totalAmount,
                                id: widget.myorder.id,
                                stt: widget.myorder.status);
                          },
                        ));
                      },
                      child: const Text(
                        "Chi tiết",
                        style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    widget.myorder.status,
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
  
  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
