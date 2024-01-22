import 'package:bangiayhaki/components/OrderItem.dart';
import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/presenters/OrderDetailsPresenter.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/views/DetailOrderScreen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({required this.id, Key? key}) : super(key: key);

  final int id;
  @override
  // ignore: library_private_types_in_public_api
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Order> lstorder_dahuy = [];
  List<Order> lstorder_dangxuli = [];
  List<Order> lstorder_dagiao = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        lstorder_dagiao = OrderPresenter.statusFilter("Đã giao");
        lstorder_dahuy = OrderPresenter.statusFilter("Đã hủy");
        lstorder_dangxuli = OrderPresenter.statusFilter("Đang xử lí");
        isLoading = false;
      });
    } catch (error) {
      print('Error loading data: $error');
      setState(() {
        isLoading = false;
      });
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
          tabs: const [
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
          _buildOrderList(lstorder_dagiao),
          _buildOrderList(lstorder_dangxuli),
          _buildOrderList(lstorder_dahuy),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (orders.isEmpty) {
      return Center(child: Text("No orders available."));
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItem(myorder: orders[index]);
        },
      );
    }
  }
}
