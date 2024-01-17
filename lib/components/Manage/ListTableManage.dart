import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:flutter/material.dart';

class ListTableManager extends StatefulWidget {
  const ListTableManager({super.key});

  @override
  State<ListTableManager> createState() => _ListTableManagerState();
}

class _ListTableManagerState extends State<ListTableManager> {
  List<dynamic> products = [];
  @override
  void initState() {
    super.initState();

    futureProducts = fetchProducts();
  }

  late Future<List<Product>> futureProducts;

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('${GlobalVariable().myVariable}/api/product/table'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products = [];

      for (var item in data) {
        Product product = Product(
            id: item['ID'],
            idCategory: item['CategoryID'],
            image: item['Image'],
            quantity: item['Quantity'],
            color: item['Color'],
            name: item['ProductName'],
            price: (item['UnitPrice']).toDouble(),
            description: item['Description']);
        products.add(product);
      }

      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ItemManage(
                id: snapshot.data![index].id,
                image: snapshot.data![index].image,
                idCategory: snapshot.data![index].idCategory,
                quantity: snapshot.data![index].quantity,
                color: snapshot.data![index].color,
                name: snapshot.data![index].name,
                price: snapshot.data![index].price,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
