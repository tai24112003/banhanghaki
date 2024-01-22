import 'dart:io';
import 'dart:typed_data';

import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListBed extends StatefulWidget {
  const ListBed({super.key,required this.idUser});
final idUser;
  @override
  State<ListBed> createState() => _ListBedState();
}

late Future<List<Product>> futureProducts;

class _ListBedState extends State<ListBed> {
  @override
  void initState() {
    super.initState();

     futureProducts = ProductPresenter.fetchProducts(4);

  }

  void reStart() {
 futureProducts = ProductPresenter.fetchProducts(4);
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
              child: Text('Chưa có sản phẩm thuộc loại giường'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 320,
                  mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Item(
                  idUser: widget.idUser,

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
