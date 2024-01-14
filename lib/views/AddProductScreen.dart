import 'package:bangiayhaki/components/Addproduct.dart';
import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddProduct(),
    );
  }
}
