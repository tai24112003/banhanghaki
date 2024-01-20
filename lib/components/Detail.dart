import 'dart:convert';
import 'dart:typed_data';
import 'package:bangiayhaki/main.dart';
import 'package:http/http.dart' as http;
import 'package:bangiayhaki/models/Item.dart';
import 'package:flutter/material.dart';

late Future<Product> futureProduct;
late String productName;

class Detail extends StatefulWidget {
  const Detail({super.key, required this.id});
  final id;

  @override
  State<Detail> createState() => _DetailState();
}

Future<Product> fetchProduct(int productId) async {
  final response = await http
      .get(Uri.parse('${GlobalVariable().myVariable}/api/product/$productId'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    dynamic imageValue = jsonData['Image'];
    List<dynamic> dataList = imageValue['data'];
    List<int> imageData = dataList.map<int>((value) => value as int).toList();
    Uint8List uint8List = Uint8List.fromList(imageData);

    Product product = Product(
      id: jsonData['ID'],
      name: jsonData['ProductName'],
      idCategory: jsonData['CategoryID'],
      image: uint8List,
      quantity: jsonData['Quantity'],
      price: jsonData['UnitPrice'].toDouble(),
      description: jsonData['Description'],
    );

    return product;
  }

  if (response.statusCode == 404) {
    throw Exception('Product not found');
  }

  throw Exception('Failed to fetch product');
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    super.initState();
    futureProduct = fetchProduct(widget.id).then((product) {
      setState(() {
        productName = product.name;
      });
      return product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: futureProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
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
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                              const Text(
                                "0",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
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
