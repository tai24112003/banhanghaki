import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              address.NameAddress,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              address.FullAddress,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
