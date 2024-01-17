import 'dart:io';
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
    HttpClient().badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    // Gọi API để lấy dữ liệu
    final response = await http
        .get(Uri.parse('${GlobalVariable().myVariable}/api/product/armchair'));

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu từ API thành danh sách sản phẩm
      final data = json.decode(response.body);
      List<Product> products = [];

      for (var item in data) {
        Product product = Product(
            id: item['ID'],
            image: item['Image'],
            idCategory: item['CategoryID'],
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
              return Item(
                id: snapshot.data![index].id,
                image: snapshot.data![index].image,
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
