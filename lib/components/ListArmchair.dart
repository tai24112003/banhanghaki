import 'dart:io';
import 'dart:typed_data';
import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListArmchair extends StatefulWidget {
  const ListArmchair({super.key});

  @override
  State<ListArmchair> createState() => _ListArmchairState();
}

late Future<List<Product>> futureProducts;

class _ListArmchairState extends State<ListArmchair> {
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
          if (snapshot.data!.isEmpty) {
            return  const Center(
              child: Text('Chưa có sản phẩm thuộc loại ghế bành'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Item(
                  id: snapshot.data![index].id,
                  image: snapshot.data![index].image,
                  quantity: snapshot.data![index].quantity,
                  description: snapshot.data![index].description,
                  name: snapshot.data![index].name,
                  price: snapshot.data![index].price,
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
