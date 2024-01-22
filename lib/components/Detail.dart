import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:http/http.dart' as http;
import 'package:bangiayhaki/models/Product.dart';
import 'package:flutter/material.dart';

late Future<Product> futureProduct;
late String productName;

class Detail extends StatefulWidget {
  const Detail({super.key, required this.id});
  final int id;

  @override
  State<Detail> createState() => _DetailState();
}



class _DetailState extends State<Detail> {
  int quan = 1;

  late Future<Product?> futureProduct;

  Future<void> fetchData() async {
    try {
      Product? product = await ProductPresenter.fetchProduct(widget.id);
      if (product != null) {
        setState(() {
          productName = product.name;
        });
      } else {
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProduct = ProductPresenter.fetchProduct(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product?>(
      future: futureProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
Uint8List? uint8list;
        uint8list=  Uint8List.fromList(snapshot.data!.image);
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 40),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                            ),
                            child: Image.memory(
                             uint8list,
                              width: MediaQuery.of(context).size.width,
                              height: 455,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          left: 5,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        snapshot.data!.name,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Gelasio',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " \$ ${snapshot.data!.price}",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Gelasio',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quan == 1 ? quan = 1 : quan -= 1;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text(
                                quan.toString(),
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quan += 1;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.5",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "(50 preview)",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 19,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    snapshot.data!.description,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 15,
                      color: Color.fromARGB(255, 61, 61, 61),
                    ),
                    softWrap: true,
                    maxLines: 10,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}


