import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item(
      {super.key,
      required this.image,
      required this.name,
      required this.price});
  final String image, name;
  final double price;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      width: MediaQuery.of(context).size.width / 2.55,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 25,
                  right: 25,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/caitui.JPG",
                                width: MediaQuery.of(context).size.width / 12,
                                fit: BoxFit.cover,
                              )),
                        ),
                      )
                    ],
                  )),
            ],
          ),
          Text(
            widget.name,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 163, 163, 163),
                fontFamily: 'Gelasio'),
          ),
          Text(
            "\$" + widget.price.toString(),
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Gelasio'),
          ),
        ],
      ),
    );
  }
}
