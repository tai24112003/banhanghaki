import 'dart:io';

import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListBed extends StatefulWidget {
  const ListBed({super.key});

  @override
  State<ListBed> createState() => _ListBedState();
}

late Future<List<Product>> futureProducts;

class _ListBedState extends State<ListBed> {
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
    final response =
        await http.get(Uri.parse('http://localhost:3000/products'));

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu từ API thành danh sách sản phẩm
      final data = json.decode(response.body);
      List<Product> products = [];

      for (var item in data) {
        Product product = Product(
          image: item['image'],
          name: item['name'],
          price: item['price'],
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
              return Item(
                image: snapshot.data![index].image,
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
