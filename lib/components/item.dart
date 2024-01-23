import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:bangiayhaki/presenters/CartPresenter.dart';
import 'package:bangiayhaki/views/CartScreen.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Uint8List? Urluint8List;
  void getIdCart(int idU) {
    CartPresenter.getCartID(idU).then((value) {
      idCart = int.parse(value);
    });
  }void loadImage() async {
  String imageUrl = 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png';  // Thay đổi đường dẫn URL thực tế
  Urluint8List = await loadImageFromUrl(imageUrl);
}
  @override
  void initState() {
    super.initState();
    getIdCart(widget.idUser);
    try {
      if (widget.image.isNotEmpty) {
        imageBytes = widget.image;
        uint8List = Uint8List.fromList(imageBytes ?? <int>[]);
       
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
                child:(uint8List!=null)? Image.memory(
  uint8List!,
  width: MediaQuery.of(context).size.width / 2.5,
  height: MediaQuery.of(context).size.height / 3.5,
  fit: BoxFit.cover,
):Image.asset("assets/st.JPG")
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
  Future<Uint8List?> loadImageFromUrl(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu hình ảnh từ response.body thành Uint8List
      return Uint8List.fromList(response.bodyBytes);
    } else {
      // Xử lý lỗi nếu có
      print('Error loading image: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Xử lý lỗi nếu có
    print('Error loading image: $e');
    return null;
  }
}
}
