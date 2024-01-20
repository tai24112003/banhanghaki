import 'package:bangiayhaki/components/AddressItem.dart';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/presenters/AddressPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/AddAddressScreen.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key, required this.id}) : super(key: key);
  final id;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen>
    implements AddressView {
  List<Address> lstAddress = [];
  late AddressPresenter presenter;
  int? selectedAddressIndex;

  @override
  void initState() {
    super.initState();
    presenter = AddressPresenter(this);
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final addresses = await presenter.getAddressByUserId(widget.id);
    setState(() {
      lstAddress = addresses;
    });
    print(lstAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Địa chỉ giao hàng",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the list of addresses using ListView.builder
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                itemCount: lstAddress.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Đặt làm địa chỉ giao hàng",
                            style: TextStyle(color: Colors.grey),
                          ),
                          leading: Radio(
                            value: index,
                            groupValue: selectedAddressIndex,
                            onChanged: (int? value) {
                              presenter.editAddress(
                                  addressID: lstAddress[index].ID,
                                  userID: widget.id);
                              setState(() {
                                selectedAddressIndex = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AddressItem(
                          address: lstAddress[index],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAddressScreen(id: widget.id),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add, // Biểu tượng dấu cộng đen
          color: Colors.black, // Màu của biểu tượng
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
