import 'package:bangiayhaki/components/item.dart';
import 'package:flutter/material.dart';

class ListBed extends StatefulWidget {
  const ListBed({super.key});

  @override
  State<ListBed> createState() => _ListBedState();
}

class _ListBedState extends State<ListBed> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [Item(), Item()],
        ),
        Row(
          children: [Item(), Item()],
        )
      ],
    );
  }
}