import 'dart:convert';
import 'dart:typed_data';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
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
  @override
  void initState() {
    super.initState();

    futureProducts =ProductPresenter.fetchProducts(2);
  }

  void reStart() {
    futureProducts =ProductPresenter.fetchProducts(2);
    setState(() {});
  }

  late Future<List<Product>> futureProducts;

  

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
