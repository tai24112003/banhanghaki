import 'dart:convert';
import 'dart:typed_data';

import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListArmchairManager extends StatefulWidget {
  const ListArmchairManager({super.key});

  @override
  State<ListArmchairManager> createState() => _ListArmchairManagerState();
}

class _ListArmchairManagerState extends State<ListArmchairManager> {
  List<dynamic> products = [];
  @override
  void initState() {
    super.initState();

    futureProducts = fetchProducts();
  }

  void reStart() {
    futureProducts = fetchProducts();
    setState(() {});
  }

  late Future<List<Product>> futureProducts;

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('${GlobalVariable().myVariable}/api/product/armchair'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      List<Product> products = [];

      for (var item in data) {
        dynamic imageValue = item['Image'];
        List<dynamic> dataList = imageValue['data'];

        List<int> imageData =
            dataList.map<int>((value) => value as int).toList();
        Uint8List uint8List = Uint8List.fromList(imageData);

        Product product = Product(
          id: item['ID'],
          idCategory: item['CategoryID'],
          image: uint8List,
          quantity: item['Quantity'],
          name: item['ProductName'],
          price: (item['UnitPrice'] as num).toDouble(),
          description: item['Description'],
        );
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
                description: snapshot.data![index].description,
                name: snapshot.data![index].name,
                price: snapshot.data![index].price,
                onReStart: reStart,
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
