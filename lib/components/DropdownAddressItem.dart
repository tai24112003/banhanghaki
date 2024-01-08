import 'package:flutter/material.dart';

class DropdownAddressItem extends StatefulWidget {
  final String label;
  final List<String> list;

  const DropdownAddressItem({
    required this.label,
    required this.list,
  });

  @override
  _DropdownAddressItemState createState() => _DropdownAddressItemState();
}

class _DropdownAddressItemState extends State<DropdownAddressItem> {
  String selectedItem = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: (value) {
              setState(() {
                selectedItem = value!;
              });

              updateListBasedOnSelection(value!);
            },
            items: widget.list
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  void updateListBasedOnSelection(String value) {
    if (value == "Thành Phố/Tỉnh") {
      setState(() {
        widget.list.clear();
        widget.list.addAll(["Thành phố A", "Thành phố B", "Thành phố C"]);
      });
    } else if (value == "Quận/Huyện") {
      setState(() {
        widget.list.clear();
        widget.list.addAll(["Quận D", "Quận E", "Quận F"]);
      });
    } else if (value == "Ấp/Phường") {
      setState(() {
        widget.list.clear();
        widget.list.addAll(["Ấp G", "Ấp H", "Ấp I"]);
      });
    }
  }
}
