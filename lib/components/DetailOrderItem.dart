import 'package:flutter/material.dart';

class DetailOrderItem extends StatefulWidget {
  const DetailOrderItem({super.key});

  @override
  State<DetailOrderItem> createState() => _DetailOrderItemState();
}

class _DetailOrderItemState extends State<DetailOrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.75), offset: const Offset(0, 5))
      ]),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.125,
            width: MediaQuery.of(context).size.height * 0.125,
            decoration: BoxDecoration(border: Border.all()),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7 - 100,
            height: MediaQuery.of(context).size.height * 0.125,
            margin: const EdgeInsets.all(8),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Item1", style: TextStyle(color: Colors.grey)),
                    Icon(
                      Icons.delete_outline_rounded,
                      size: 30,
                    )
                  ],
                ),
                Text("25\$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text("Số lượng: 01",
                    style: TextStyle(
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
