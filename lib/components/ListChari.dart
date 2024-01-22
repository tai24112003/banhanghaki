import 'dart:io';
import 'dart:typed_data';
import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ListChair extends StatefulWidget {
  const ListChair({super.key});

  @override
  State<ListChair> createState() => _ListChairState();
}

late Future<List<Product>> futureProducts;

class _ListChairState extends State<ListChair> {
  List<dynamic> products = [];
  @override
  void initState() {
    super.initState();

    futureProducts = ProductPresenter.fetchProducts(1);
  }

  void reStart() {
    futureProducts = ProductPresenter.fetchProducts(1);
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
                child: Text('Chưa có sản phẩm thuộc loại ghế'),
              );
            } else {
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
