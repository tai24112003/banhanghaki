import 'dart:typed_data';

import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/views/AddproductScreen.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemManage extends StatefulWidget {
  const ItemManage({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.idCategory,
    required this.quantity,
    required this.description,
    required this.price,
    required this.onReStart,
  }) : super(key: key);

  final List<int> image;
  final String name, description;
  final double price;
  final int id, quantity, idCategory;
  final Function onReStart;

  @override
  State<ItemManage> createState() => _ItemManageState();
}

class _ItemManageState extends State<ItemManage> {
  void test() {
    setState(() {});
  }

  void deleteProduct(int productId) async {
    final url = '${GlobalVariable().myVariable}/api/product/delete/$productId';

    try {
      final response = await http.put(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Sản phẩm đã được xóa thành công');
        widget.onReStart();
      } else {
        print('Lỗi xóa sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  List<int>? imageBytes;
  Uint8List? uint8List;
  @override
  void initState() {
    super.initState();
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
    if (uint8List == null) {
      return Container(
        child: Text(''),
      );
    } else {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProduct(
                          id: widget.id,
                          image: widget.image,
                          idCategory: widget.idCategory,
                          quantity: widget.quantity,
                          descreption: widget.description,
                          name: widget.name,
                          price: widget.price,
                          onRestart: test,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            uint8List!,
                            width: 60, // Set width here
                            height: 60, // Set height here
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Lỗi tải hình ảnh: $error');
                              return Container(
                                child: Text('Lỗi tải hình ảnh'),
                              );
                            },
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            "\$${widget.price}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Gelasio',
                            ),
                          ),
                          Text(
                            "Kho: ${widget.quantity}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Gelasio',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      deleteProduct(widget.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
