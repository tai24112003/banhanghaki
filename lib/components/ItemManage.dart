import 'package:bangiayhaki/views/AddproductScreen.dart';
import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';

class ItemManage extends StatefulWidget {
  const ItemManage(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.idCategory,
      required this.quantity,
      required this.color,
      required this.price});
  final String image, name, color;
  final double price;
  final int id, quantity, idCategory;

  @override
  State<ItemManage> createState() => _ItemManageState();
}

class _ItemManageState extends State<ItemManage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProduct(
                              id: widget.id,
                              image: widget.image,
                              idCategory: widget.idCategory,
                              quantity: widget.quantity,
                              descreption: widget.color,
                              name: widget.name,
                              price: widget.price,
                            )),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 163, 163, 163),
                    fontFamily: 'Gelasio'),
              ),
              Text(
                "\$${widget.price}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gelasio'),
              ),
              Text(
                "Kho: ${widget.quantity}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gelasio'),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.7,
          ),
          Container(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          )
        ],
      ),
    );
  }
}
