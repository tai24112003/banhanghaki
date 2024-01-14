import 'package:bangiayhaki/components/OrderItem.dart';
import 'package:bangiayhaki/models/Order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Order> lstorder = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadData();
  }

  Future<void> loadData() async {
    try {
      await Order.loadData();
      setState(() {
        lstorder = Order.lstOrder;
      });
    } catch (error) {
      print('Error loading data: $error');
    }
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
          lstorder.isEmpty
              ? Center(
                  child: Text("No orders available."),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: lstorder.length,
                  itemBuilder: (context, index) {
                    return OrderItem(myorder: lstorder[index]);
                  },
                ),

          SingleChildScrollView(
            child: Column(
              children: [Text("Content for Đang Xử Lý")],
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [Text("Content for Đã Hủy")],
            ),
          ),
        ],
      ),
    );
  }
}
