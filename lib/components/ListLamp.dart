import 'dart:io';
import 'dart:typed_data';

import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListLamp extends StatefulWidget {
  const ListLamp({super.key});

  @override
  State<ListLamp> createState() => _ListLampState();
}

late Future<List<Product>> futureProducts;

class _ListLampState extends State<ListLamp> {
  @override
  void initState() {
    super.initState();

    futureProducts = futureProducts = ProductPresenter.fetchProducts(5);
  }

  void reStart() {
    futureProducts = futureProducts = ProductPresenter.fetchProducts(5);
    setState(() {});
  }

  late Future<List<Product>> futureProducts;

  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Chưa có sản phẩm thuộc loại đèn'),
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
