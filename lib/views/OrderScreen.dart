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
  List<Order> lstorder_dahuy = [];
  List<Order> lstorder_dangxuli = [];
  List<Order> lstorder_dagiao = [];
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
        lstorder_dagiao = Order.statusfilter("Đã giao");
        lstorder_dahuy = Order.statusfilter("Đã hủy");
        lstorder_dangxuli = Order.statusfilter("Đang xử lí");
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
          lstorder_dagiao.isEmpty
              ? const Center(
                  child: Text("No orders available."),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: lstorder_dagiao.length,
                  itemBuilder: (context, index) {
                    return OrderItem(myorder: lstorder_dagiao[index]);
                  },
                ),
          lstorder_dangxuli.isEmpty
              ? const Center(
                  child: Text("No orders available."),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: lstorder_dangxuli.length,
                  itemBuilder: (context, index) {
                    return OrderItem(myorder: lstorder_dangxuli[index]);
                  },
                ),
          lstorder_dahuy.isEmpty
              ? const Center(
                  child: Text("No orders available."),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: lstorder_dahuy.length,
                  itemBuilder: (context, index) {
                    return OrderItem(myorder: lstorder_dahuy[index]);
                  },
                ),
        ],
      ),
    );
  }
}
