import 'dart:typed_data';

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/CartPresenter.dart';
import 'package:bangiayhaki/presenters/ProductPresenter.dart';
import 'package:bangiayhaki/views/CartScreen.dart';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.idUser});
  final id;
  final int idUser;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int idCart = -1;
  int quan = 1;
  late Future<Product?> futureProduct;

  void getIdCart(int idU) {
    CartPresenter.getCartID(idU).then((value) {
      idCart = int.parse(value);
    });
  }

  @override
  void initState() {
    super.initState();
    getIdCart(widget.idUser);
    print(idCart);
    futureProduct = ProductPresenter.fetchProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product?>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
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
                                Uint8List.fromList(snapshot.data!.image),
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
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: FloatingActionButton.extended(
              onPressed: () {
                CartPresenter.addItemToCart(widget.id, idCart, quan);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      idUser: widget.idUser,
                    ),
                  ),
                );
              },
              label: const Text('Add to cart'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_shopping_cart),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
