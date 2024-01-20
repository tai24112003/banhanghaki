import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:flutter/material.dart';

class DetailOrderItem extends StatefulWidget {
  const DetailOrderItem({required this.myitem, super.key});
  final OrderDetails myitem;
  @override
  State<DetailOrderItem> createState() => _DetailOrderItemState();
}

class _DetailOrderItemState extends State<DetailOrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 5)
          ]),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.125,
            width: MediaQuery.of(context).size.height * 0.125,
            decoration: BoxDecoration(border: Border.all(width: 2.0)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7 - 100,
            height: MediaQuery.of(context).size.height * 0.125,
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.myitem.ProductName,
                        style: const TextStyle(color: Colors.grey)),
                    const Icon(
                      Icons.delete_outline_rounded,
                      size: 30,
                    )
                  ],
                ),
                const Text("25\$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text("Số lượng: ${widget.myitem.quantity}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
