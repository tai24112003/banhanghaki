import 'package:flutter/material.dart';

class DropdownAddressItem extends StatefulWidget {
  final String label;
  final List<String> list;
  final Function(String) onChanged;
  const DropdownAddressItem({
    required this.label,
    required this.list,
    required this.onChanged,
  });

  @override
  _DropdownAddressItemState createState() => _DropdownAddressItemState();
}

class _DropdownAddressItemState extends State<DropdownAddressItem> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = !(widget.list.length > 0) ? "" : widget.list[0];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: (value) {
              setState(() {
                selectedItem = value!;
                widget.onChanged(value!);
              });
            },
            items: widget.list
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
