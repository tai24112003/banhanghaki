import 'dart:convert';
import 'package:bangiayhaki/main.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct(
      {super.key,
      required this.id,
      required this.image,
      required this.idCategory,
      required this.name,
      required this.quantity,
      required this.descreption,
      required this.price});
  final String image, name, descreption;
  final double price;
  final int id, quantity, idCategory;

  @override
  State<AddProduct> createState() => _AddProductState();
}

String? _selectedItem;

List<String> _dropdownItems = [
  'Ghế',
  'Bàn',
  'Ghế bành',
  'Giường',
  'Đèn',
];

class _AddProductState extends State<AddProduct> {
  TextEditingController _productName = TextEditingController();
  TextEditingController _urlImage = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.id != 0) {
        _productName.text = widget.name;
        _urlImage.text = widget.image;
        _description.text = widget.descreption;
        _price.text = widget.price.toString();
        _quantity.text = widget.quantity.toString();
        _selectedItem = _dropdownItems[widget.idCategory - 1];
      } else {
        _productName = TextEditingController();
        _urlImage = TextEditingController();
        _description = TextEditingController();
        _price = TextEditingController();
        _quantity = TextEditingController();
      }
    });
  }

  @override
  void dispose() {
    _productName.dispose();
    super.dispose();
  }

  void _onDropdownItemSelected(String? selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  Future<void> addProduct() async {
    final url = Uri.parse('${GlobalVariable().myVariable}/api/add_Product');

    final product = {
      'CategoryID': _dropdownItems.indexOf(_selectedItem!) + 1,
      'ProductName': _productName.text,
      'Image': _urlImage.text,
      'Quantity': int.parse(_quantity.text),
      'UnitPrice': double.parse(_price.text),
      'Color': "White",
      'Description': _description.text,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );

    if (response.statusCode == 200) {
      print('Sản phẩm đã được thêm thành công');
    } else {
      print('Lỗi thêm sản phẩm: ${response.reasonPhrase}');
    }
  }

  Future<void> updateProduct() async {
    final url = Uri.parse(
        '${GlobalVariable().myVariable}/api/update/product/${widget.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'ID': widget.id,
      'CategoryID': _dropdownItems.indexOf(_selectedItem!) + 1,
      'ProductName': _productName.text,
      'Image': _urlImage.text,
      'Quantity': int.parse(_quantity.text),
      'UnitPrice': double.parse(_price.text),
      'Color': "White",
      'Description': _description.text,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Product updated successfully');
    } else {
      print('Error updating product: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 150),
          physics: ClampingScrollPhysics(),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Thông tin sản phẩm")
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            255, 226, 226, 226))),
                                child: DropdownButton(
                                  value: _selectedItem,
                                  hint: const Text('Danh mục'),
                                  onChanged: _onDropdownItemSelected,
                                  items: _dropdownItems.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                ),
                              )))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _productName,
                      decoration: InputDecoration(
                        labelText: 'Tên sản phẩm',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(231, 231, 231, 1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: 'Giá bán',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(231, 231, 231, 1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _quantity,
                      decoration: InputDecoration(
                        labelText: 'Số lượng',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(231, 231, 231, 1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _urlImage,
                      decoration: InputDecoration(
                        labelText: 'Liên kết hình ảnh',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(231, 231, 231, 1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _description,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(231, 231, 231, 1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50,
                      child: widget.id != 0
                          ? ElevatedButton(
                              onPressed: () {
                                updateProduct();
                                Navigator.pop(context);
                              },
                              child: const Text("Cập nhật"),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 186, 186, 186),
                                onPrimary:
                                    const Color.fromARGB(255, 59, 59, 59),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                addProduct();
                                Navigator.pop(context);
                              },
                              child: const Text("Thêm"),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 186, 186, 186),
                                onPrimary:
                                    const Color.fromARGB(255, 59, 59, 59),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            )),
                ])
          ]),
    );
  }
}
