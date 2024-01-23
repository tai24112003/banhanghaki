import 'dart:typed_data';

import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailOrderItem extends StatefulWidget {
  const DetailOrderItem({required this.myitem, Key? key}) : super(key: key);
  final OrderDetails myitem;

  @override
  State<DetailOrderItem> createState() => _DetailOrderItemState();
}

class _DetailOrderItemState extends State<DetailOrderItem> implements UserView {
  Product? item;
  Uint8List? uint8List;
  UserPresenter? user;
  User? admin;
  @override
  void initState() {
    super.initState();
    loadItem();
    user = UserPresenter(this);
    NotificationServices().sendFCMNotification(title: "title", body: "body", deviceToken: "deviceToken")
    if (kDebugMode) {
      print(uint8List);
    }
  }

  Future<void> loadItem() async {
    try {
    admin=await user.getUserById(1);

      item = await ProductPresenter.fetchProduct(widget.myitem.productID);
      if (kDebugMode) {
        print(item!.image);
      }
      if (item!.image.isNotEmpty) {
        var imageBytes = item!.image;
        setState(() {
          uint8List = Uint8List.fromList(imageBytes);
        });
      } else {
        print('Lỗi: Dữ liệu hình ảnh trống.');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: uint8List != null
                ? Image.memory(
                    uint8List!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 8.5,
                  )
                : Placeholder(), // You can replace Placeholder with any other widget or image for the null case
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7 - 100,
            height: MediaQuery.of(context).size.height * 0.125,
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item!.name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  "${item!.price}\$",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Số lượng: ${widget.myitem.quantity}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
