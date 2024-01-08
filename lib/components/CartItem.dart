import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quan = 1;
  bool isSelect = false;
  void _setQuan(int Increa) {
    setState(() {
      quan += Increa;
      quan = quan < 0 ? 0 : quan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.75), offset: const Offset(0, 5))
      ]),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  activeColor: Colors.black,
                  value: isSelect,
                  onChanged: (a) {
                    setState(() {
                      isSelect = a!;
                    });
                  }),
              Container(
                height: MediaQuery.of(context).size.height * 0.125,
                width: MediaQuery.of(context).size.height * 0.125,
                decoration: BoxDecoration(border: Border.all()),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7 - 100,
            height: MediaQuery.of(context).size.height * 0.15,
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Item1", style: TextStyle(color: Colors.grey)),
                    Icon(
                      Icons.cancel_outlined,
                      size: 30,
                    )
                  ],
                ),
                const Text("25\$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _setQuan(1);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(158, 158, 158, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 30,
                          height: 30,
                          child: const Center(
                            child: Text(
                              "+",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Text(quan < 10 ? "0${quan.toString()}" : quan.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          _setQuan(-1);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(158, 158, 158, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 30,
                          height: 30,
                          child: const Center(
                            child: Text(
                              "-",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
