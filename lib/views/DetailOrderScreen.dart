import 'package:demo/components/DetailOrderItem.dart';
import 'package:flutter/material.dart';

class DetailOrderScreen extends StatefulWidget {
  const DetailOrderScreen({Key? key}) : super(key: key);

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Đơn hàng: 0333333",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Đang giao ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all(BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
                ),
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(3, 3),
                      ),
                    ],
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Text(
                    "Đã nhận hàng",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  DetailOrderItem(),
                  DetailOrderItem(),
                  DetailOrderItem(),
                  DetailOrderItem(),
                  DetailOrderItem(),
                  DetailOrderItem(),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng tiền:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                  "\$ 95.00:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
