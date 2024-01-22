import 'dart:io';
import 'dart:typed_data';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/models/Product.dart';

class ListTable extends StatefulWidget {
  const ListTable({super.key});

  @override
  State<ListTable> createState() => _ListTableState();
}

late Future<List<Product>> futureProducts;

class _ListTableState extends State<ListTable> {
  @override
  void initState() {
    super.initState();

    futureProducts = ProductPresenter.fetchProducts(22);
  }

  void reStart() {
    futureProducts = ProductPresenter.fetchProducts(2);
    setState(() {});
  }

  late Future<List<Product>> futureProducts;

  

  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 10,
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
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
