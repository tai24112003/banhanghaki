import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

String? _selectedItem;
TextEditingController _productName = TextEditingController();
TextEditingController _urlImage = TextEditingController();
TextEditingController _description = TextEditingController();
TextEditingController _price = TextEditingController();
TextEditingController _quantity = TextEditingController();
List<String> _dropdownItems = [
  'Ghế',
  'Bàn',
  'Ghế bành',
  'Giường',
  'Đèn',
];

class _AddProductState extends State<AddProduct> {
  @override
  void _onDropdownItemSelected(String? selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Column(children: [
            Row(
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
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 226, 226, 226))),
                          child: DropdownButton(
                            value: _selectedItem,
                            hint: Text('Danh mục'),
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                controller: _productName,
                decoration: InputDecoration(
                  labelText: 'Tên sản phẩm',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 155, 155, 155),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(231, 231, 231, 1), // Màu của border
                      width: 2, // Độ dày của border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          111, 111, 111, 1), // Màu của border khi được chọn
                      width: 2, // Độ dày của border
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                controller: _price,
                decoration: InputDecoration(
                  labelText: 'Giá bán',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 155, 155, 155),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(231, 231, 231, 1), // Màu của border
                      width: 2, // Độ dày của border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          111, 111, 111, 1), // Màu của border khi được chọn
                      width: 2, // Độ dày của border
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                controller: _quantity,
                decoration: InputDecoration(
                  labelText: 'Số lượng',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 155, 155, 155),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(231, 231, 231, 1), // Màu của border
                      width: 2, // Độ dày của border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          111, 111, 111, 1), // Màu của border khi được chọn
                      width: 2, // Độ dày của border
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                controller: _urlImage,
                decoration: InputDecoration(
                  labelText: 'Liên kết hình ảnh',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 155, 155, 155),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(231, 231, 231, 1), // Màu của border
                      width: 2, // Độ dày của border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          111, 111, 111, 1), // Màu của border khi được chọn
                      width: 2, // Độ dày của border
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                controller: _description,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 155, 155, 155),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(231, 231, 231, 1), // Màu của border
                      width: 2, // Độ dày của border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          111, 111, 111, 1), // Màu của border khi được chọn
                      width: 2, // Độ dày của border
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Thêm"),
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromARGB(255, 186, 186, 186), // Màu nền của nút
                  onPrimary:
                      const Color.fromARGB(255, 59, 59, 59), // Màu chữ trên nút
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0), // Kích thước lề nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc nút
                  ),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }
}
