import 'dart:convert';
import 'dart:io';
import 'package:bangiayhaki/components/Detail.dart';
import 'package:bangiayhaki/presenters/NotiPresenter.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  AddProduct({
    Key? key,
    required this.id,
    required this.idUser,
    required this.image,
    required this.idCategory,
    required this.name,
    required this.quantity,
    required this.onRestart,
    required this.description,
    required this.price,
  }) : super(key: key);
  final int idUser;
  final List<int> image;
  final String name, description;
  final double price;
  final int? id;
  final quantity, idCategory;
  final Function onRestart;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController message = TextEditingController();

  TextEditingController _productName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.id != 0) {
        _productName.text = widget.name;
        _description.text = widget.description;
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
                  Text("Thông tin sản phẩm"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 226, 226, 226),
                          ),
                        ),
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
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                          fontFamily: 'Gelasio',
                        ),
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
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: Icon(Icons.photo),
                          ),
                          IconButton(
                            onPressed: () => _pickImage(ImageSource.camera),
                            icon: Icon(Icons.photo_camera),
                          ),
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
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                    fontFamily: 'Gelasio',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: widget.id != 0
                    ? ElevatedButton(
                        onPressed: () {
                          if (Test()) {
                            ProductPresenter.updateProduct(
                              _imageFile,
                              _dropdownItems.indexOf(_selectedItem.toString()) +
                                  1,
                              _productName.text,
                              _quantity.text,
                              _price.text,
                              _description.text,
                              widget.id,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsManageScreen(
                                  idUser: widget.idUser,
                                ),
                              ),
                            );
                          } else {
                            Test();
                          }
                        },
                        child: const Text("Cập nhật"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 186, 186, 186),
                          onPrimary: const Color.fromARGB(255, 59, 59, 59),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (Test()) {
                            ProductPresenter.addProduct(
                              _imageFile,
                              _dropdownItems.indexOf(_selectedItem.toString()) +
                                  1,
                              _productName.text,
                              _quantity.text,
                              _price.text,
                              _description.text,
                            );
                            NotiPresenter().insertNotification(
                                Name: "Sản phẩm " +
                                    _productName.text +
                                    " vừa được thêm vào",
                                content: "Mời bạn đen xem",
                                NotificationType: "Public",
                                UserID: widget.idUser);
                            NotificationServices().sendFCMNotificationToAll(
                                title: "Thông báo",
                                body:
                                    "HaKi Store vừa thêm sản phẩm mới vào xem ngay!");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsManageScreen(
                                  idUser: widget.idUser,
                                ),
                              ),
                            );
                          } else {
                            Test();
                          }
                        },
                        child: const Text("Thêm"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 186, 186, 186),
                          onPrimary: const Color.fromARGB(255, 59, 59, 59),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _selectedItem;

  List<String> _dropdownItems = [
    'Ghế',
    'Bàn',
    'Ghế bành',
    'Giường',
    'Đèn',
  ];

  void _onDropdownItemSelected(String? selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (await isImageSizeValid(pickedFile.path)) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        setState(() {
          message.text = 'Dung lượng ảnh phải dưới 350KB';
        });
      }
    }
  }

  Future<bool> isImageSizeValid(String imagePath) async {
    final File file = File(imagePath);
    final int fileSize = await file.length();
    const int maxSizeInBytes = 350 * 350;
    return fileSize <= maxSizeInBytes;
  }

  bool Test() {
    if (_selectedItem == null) {
      message.text = "Vui lòng chọn danh mục";
      return false;
    }
    if (_productName.text.isEmpty ||
        _price.text.isEmpty ||
        _quantity.text.isEmpty ||
        _description.text.isEmpty) {
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
