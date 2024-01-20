import 'dart:convert';
import 'dart:io';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct(
      {super.key,
      required this.id,
      required this.image,
      required this.idCategory,
      required this.name,
      required this.quantity,
      required this.onRestart,
      required this.descreption,
      required this.price});
  final List<int> image;
  final String name, descreption;
  final double price;
  final int id, quantity, idCategory;
  final Function onRestart;

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
  TextEditingController message = TextEditingController();

  TextEditingController _productName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.id != 0) {
        _productName.text = widget.name;
        // _urlImage.text = widget.image;
        _description.text = widget.descreption;
        _price.text = widget.price.toString();
        _quantity.text = widget.quantity.toString();
        _selectedItem = _dropdownItems[widget.idCategory - 1];
      } else {
        _productName = TextEditingController();
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "   Hình ảnh",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 155, 155, 155),
                                fontFamily: 'Gelasio'),
                          ),
                          if (_imageFile != null)
                            Image.file(
                              _imageFile!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                icon: Icon(Icons.photo),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      _pickImage(ImageSource.camera),
                                  icon: Icon(Icons.photo_camera)),
                            ],
                          )
                        ],
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
                  SizedBox(
                    height: 50,
                    child: Text(
                      "${message.text.toString()}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 164, 46, 46),
                          fontFamily: 'Gelasio'),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50,
                      child: widget.id != 0
                          ? ElevatedButton(
                              onPressed: () {
                                if (Test()) {
                                  updateProduct();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsManageScreen(),
                                      ));
                                } else {
                                  setState(() {
                                    Test();
                                  });
                                }
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
                                if (Test()) {
                                  addProduct();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsManageScreen(),
                                      ));
                                } else {
                                  setState(() {
                                    Test();
                                  });
                                }
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

  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      // Kiểm tra dung lượng của ảnh trước khi gán vào biến _imageFile
      if (await isImageSizeValid(pickedFile.path)) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        setState(() {
          message.text = 'Dung lượng ảnh phải dưới 350KB';
        });
        // Xử lý khi ảnh quá lớn, ví dụ: hiển thị thông báo cho người dùng
      }
    }
  }

  Future<bool> isImageSizeValid(String imagePath) async {
    final File file = File(imagePath);
    final int fileSize = await file.length();

    const int maxSizeInBytes = 350 * 350; 
    if (fileSize <= maxSizeInBytes) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addProduct() async {
    if (_imageFile == null) {
      print('Lỗi: Hình ảnh không tồn tại');
      return;
    }

    final url =
        Uri.parse('${GlobalVariable().myVariable}/api/product/add_Product');

    final bytes = await _imageFile!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final product = {
      'CategoryID': _dropdownItems.indexOf(_selectedItem!) + 1,
      'ProductName': _productName.text,
      'Image': base64Image,
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
    if (_imageFile == null) {
      print('Lỗi: Hình ảnh không tồn tại');
      return;
    }

    final url = Uri.parse(
        '${GlobalVariable().myVariable}/api/product/update/${widget.id}');

    final bytes = await _imageFile!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'ID': widget.id,
      'CategoryID': _dropdownItems.indexOf(_selectedItem!) + 1,
      'ProductName': _productName.text,
      'Image': base64Image,
      'Quantity': int.parse(_quantity.text),
      'UnitPrice': double.parse(_price.text),
      'Color': "White",
      'Description': _description.text,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Sản phẩm đã được cập nhật thành công');
    } else {
      print('Lỗi cập nhật sản phẩm: ${response.reasonPhrase}');
    }
  }

  bool Test() {
    if (_selectedItem == null) {
      message.text = "Vui lòng chọn danh mục";
      return false;
    }
    if (_productName.text == '' ||
        _price.text == '' ||
        _quantity.text == '' ||
        _description.text == '') {
      message.text = "Vui lòng nhập đầy đủ thông tin";
      return false;
    }
    if (_quantity.text == '0') {
      message.text = "Số lượng phải lớn hơn 0";
      return false;
    }
    if (_imageFile == null) {
      message.text = "Vui lòng chọn hình ảnh";
      return false;
    }

    return true;
  }
}
