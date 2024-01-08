import 'package:bangiayhaki/components/OrderItem.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng'),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          unselectedLabelStyle: TextStyle(fontSize: 14, color: Colors.grey),
          dividerColor: Colors.transparent,
          indicatorColor: Colors.black,
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Đã Giao',
            ),
            Tab(text: 'Đang Xử Lý'),
            Tab(text: 'Đã Hủy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Đã Giao Tab
          SingleChildScrollView(
              child: Column(
            children: [
              OrderItem(status: "Đã giao"),
              OrderItem(status: "Đã giao"),
              OrderItem(status: "Đã giao"),
              OrderItem(status: "Đã giao"),
              OrderItem(status: "Đã giao"),
              OrderItem(status: "Đã giao"),
            ],
          )),

          SingleChildScrollView(
              child: Column(
            children: [
              OrderItem(status: "Đang xử lí"),
            ],
          )),

          SingleChildScrollView(
              child: Column(
            children: [
              OrderItem(status: "Đã hủy"),
            ],
          ))
        ],
      ),
    );
  }
}
