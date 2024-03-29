import 'package:bangiayhaki/components/AddressItem.dart';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/AddressPresenter.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/CongratScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/PayMethodScreen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {super.key,
      required this.id,
      required this.detailOrder,
      required this.totalAmount});
  final id;
  final detailOrder;
  final totalAmount;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    implements AddressView, UserView {
  List<Address> lstAddress = [];
  late AddressPresenter presenter;
  Address curAdd =
      Address(ID: 0, NameAddress: "Chưa có", FullAddress: "Chưa có");
  late UserPresenter userPresenter;
  @override
  void initState() {
    super.initState();
    presenter = AddressPresenter(this);
    userPresenter = UserPresenter(this);
    print("Init");
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final user = await userPresenter.getUserById(widget.id);
    final addresses = await presenter.getAddressByUserId(widget.id);
    print("Load");
    print(addresses);
    if (mounted)
      setState(() {
        lstAddress = addresses;
        curAdd = lstAddress
                .firstWhereOrNull((element) => element.ID == user?.address) ??
            curAdd;
        print(curAdd.FullAddress);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Đặt hàng",
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Địa chỉ giao hàng",
                  style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAddressScreen(id: widget.id),
                    ),
                  );
                  loadAddresses();
                },
                icon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AddressItem(address: curAdd),
            ListTile(
              title: Text("Thanh toán", style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayMethodScreen(),
                        ));
                  },
                  icon: Icon(Icons.edit)),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Thanh toán trực tiếp",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Text("Mã giảm giá"),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Chưa ra mắt",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Colors.amberAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const ListTile(
              title: Text("Phương thức giao hàng",
                  style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.edit),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: const Text("Nhanh (2-3 ngày)"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
              child: Column(
                children: [
                  ListTile(
                    title:
                        Text("Đơn hàng", style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "${widget.totalAmount}\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title: Text("Phí vận chuyển",
                        style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "5\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title:
                        Text("Giảm giá", style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "0\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title: Text("Tổng đơn hàng",
                        style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "${widget.totalAmount + 5}\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () async {
                    if (curAdd.ID != 0) {
                      int idorder = await OrderPresenter().Checkout(
                          quantity: widget.detailOrder.length,
                          totalAmount: widget.totalAmount + 5,
                          addressID: curAdd.ID,
                          userID: widget.id,
                          detailOrders: widget.detailOrder);
                      if (idorder != 0) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CongratScreen(
                                id: widget.id,
                                idorder: idorder,
                              ),
                            ));
                      }
                    } else {
                      displayMessage("Chưa chọn địa chỉ");
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    "Xác nhận đơn hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    // Hiển thị thông báo cho người dùng (ví dụ: sử dụng SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
