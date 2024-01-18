
import 'package:flutter/material.dart';

class MyReviewItem extends StatelessWidget {
  const MyReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(3, 3), // Dịch chuyển bóng theo trục x và y
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 251, 251),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 255, 251, 251)),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.width / 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Image.asset(
                      "assets/st.JPG",
                      fit: BoxFit.contain,
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Table",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 163, 163, 163),
                          fontFamily: 'Gelasio'),
                    ),
                    Text(
                      "\$ 15.00",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Gelasio'),
                    ),
                  ],
                ),
              )
            ]),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ]),
                Text(
                  "08/01/2023",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 163, 163, 163),
                      fontFamily: 'Gelasio'),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price",
              softWrap: true,
              maxLines: 5,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 163, 163, 163),
                  fontFamily: 'Gelasio'),
            ),
          ],
        ),
      ),
    );
  }
}
