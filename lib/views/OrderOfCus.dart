import 'package:bangiayhaki/components/OrderItem.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:flutter/material.dart';

class OrderOfCus extends StatefulWidget {
  const OrderOfCus({super.key, required this.email, required this.id});
  final String email;
  final int id;
  @override
  State<OrderOfCus> createState() => _OrderOfCusState();
}

class _OrderOfCusState extends State<OrderOfCus> {
  List _lstOr = [];
  List _lstDG = [];
  List _lstDXL = [];
  List _lstDH = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    await OrderPresenter.loadData(widget.id).then((value) {
      _lstOr = OrderPresenter.lstOrder;
      _lstDG = _lstOr.where((element) {
        return element.status == "Đã giao";
      }).toList();
      _lstDXL = _lstOr.where((element) {
        return element.status == "Đang xử lí";
      }).toList();
      _lstDH = _lstOr.where((element) {
        return element.status == "Đã hủy";
      }).toList();
      setState(() {});
    });
  }

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
            child: SingleChildScrollView(
              child: Column(
                children: _lstDG.map((e) {
                  return OrderItem(myorder: e);
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: SingleChildScrollView(
              child: Column(
                children: _lstDXL.map((e) {
                  return OrderItem(myorder: e);
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: SingleChildScrollView(
              child: Column(
                children: _lstDH.map((e) {
                  return OrderItem(myorder: e);
                }).toList(),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
