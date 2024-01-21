import 'package:bangiayhaki/components/OrderWithConfirmBtn.dart';
import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/presenters/NotiPresenter.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  List<Order> _lstOrder = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotiPresenter.init(fln);
    loadOrder();
  }

  void loadOrder() {
    OrderPresenter.loadOrderStt().then((value) => {
          setState(() {
            _lstOrder = value;
          })
        });
  }

  void onClick(int id) {
    OrderPresenter.updateStt(id).then((value) {
      NotiPresenter.showNoti(
          title: "Xác nhận thành công",
          body: "Đơn hàng đã được bạn xác nhận",
          fln: fln);
      loadOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    _lstOrder.forEach(
      (element) {
        print(element);
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Xác nhận đơn hàng",
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              children: _lstOrder.map((e) {
            return OrderConfirm(
              ths: e,
              onClick: onClick,
            );
          }).toList()),
        ),
      ),
    );
  }
}
