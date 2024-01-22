import 'dart:io';
import 'dart:typed_data';
import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/components/item.dart';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/HistoryPresenter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.search,required this.id});
  final String search;
  final id;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

late Future<List<Product>> futureProducts;

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> products = [];
  @override
  void initState() {
    super.initState();

    futureProducts = HitstoryPresenter.fetchProducts(widget.search);
  }

  void reStart() {
    futureProducts = HitstoryPresenter.fetchProducts(widget.search);
    setState(() {});
  }

  late Future<List<Product>> futureProducts;

  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar(
          UserId: widget.id,
          title: "Danh sách tìm kiếm",
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Không có sản phẩm'),
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
      ),
    );
  }
}
