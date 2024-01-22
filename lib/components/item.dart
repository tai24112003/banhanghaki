import 'dart:typed_data';

import 'package:bangiayhaki/presenters/CartPresenter.dart';
import 'package:bangiayhaki/views/CartScreen.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.description,
      required this.idUser,
      required this.price,});
  final List<int> image;
  final String name, description;
  final double price;
  final int? id;final int quantity,idUser;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int idCart = -1;
  List<int>? imageBytes;
  Uint8List? uint8List;
  void getIdCart(int idU) {
    CartPresenter.getCartID(idU).then((value) {
      idCart = int.parse(value);
    });
  }
  @override
  void initState() {
    super.initState();
    getIdCart(widget.idUser);
    try {
      if (widget.image.isNotEmpty) {
        imageBytes = widget.image;
        uint8List = Uint8List.fromList(imageBytes!);
        print(uint8List);
      } else {
        print('Lỗi: Dữ liệu hình ảnh trống.');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    idUser: widget.idUser,
                    id: widget.id,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  uint8List!,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 3.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {CartPresenter.addItemToCart(widget.id, idCart, 1);Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(idUser: widget.idUser,
                  ),
                ),
              );},
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/caitui.JPG",
                        width: MediaQuery.of(context).size.width / 12,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Text(
        widget.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 163, 163, 163),
          fontFamily: 'Gelasio',
        ),
      ),
      Text(
        "\$" + widget.price.toString(),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'Gelasio',
        ),
      ),
    ],
  ),
);
      
    
  }
}
