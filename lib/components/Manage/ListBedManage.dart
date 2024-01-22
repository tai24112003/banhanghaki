import 'dart:convert';
import 'dart:typed_data';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:http/http.dart' as http;

import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:flutter/material.dart';

class ListBedManager extends StatefulWidget {
  const ListBedManager({super.key,required this.idUser});
final int idUser;
  @override
  State<ListBedManager> createState() => _ListBedManagerState();
}

class _ListBedManagerState extends State<ListBedManager> {
  @override
  void initState() {
    super.initState();

     futureProducts =ProductPresenter.fetchProducts(4);
  }

  void reStart() {
    futureProducts =ProductPresenter.fetchProducts(4);
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
                id: snapshot.data![index].id,idUser: widget.idUser,
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
          return  Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
