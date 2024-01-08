import 'package:flutter/material.dart';

class OrderOfCus extends StatefulWidget {
  const OrderOfCus({super.key, required this.email});
  final String email;
  @override
  State<OrderOfCus> createState() => _OrderOfCusState();
}

class _OrderOfCusState extends State<OrderOfCus> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Các đơn của ${widget.email}:",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: [
                      Text("Đã giao"),
                      Text("Đang xử lí"),
                      Text("Đã huỷ")
                    ]),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Các đơn hàng của khách",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hoàn thành"),
                Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Đang xử lí"),
                Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Đã huỷ"),
                Container(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
