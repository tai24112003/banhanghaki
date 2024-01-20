import 'package:flutter/material.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            //row sản phẩm
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/st.JPG',
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minimal Stand",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 163, 163, 163),
                        fontFamily: 'Gelasio'),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("4.5",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  Text("3 Đánh giá",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 19,
                        color: Colors.grey,
                      )),
                ],
              ),
              const SizedBox(
                width: 80,
              ),
            ],
          ),
          Container(
            //container đổ bóng
            margin: const EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                  blurRadius: 5,
                  offset:
                      const Offset(3, 3), // Dịch chuyển bóng theo trục x và y
                ),
              ],
            ),
            child: Container(
              //container chứa preview
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 251, 251),
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 255, 251, 251)),
                  borderRadius: BorderRadius.circular(8)),

              child: const Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/st.JPG"),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mr.Siro",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 163, 163, 163),
                            fontFamily: 'Gelasio'),
                      ),
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
                  SizedBox(
                    height: 15,
                  ),
                  Text(
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                  blurRadius: 5,
                  offset:
                      const Offset(3, 3), // Dịch chuyển bóng theo trục x và y
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 251, 251),
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 255, 251, 251)),
                  borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/st.JPG"),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mr.Siro",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 163, 163, 163),
                            fontFamily: 'Gelasio'),
                      ),
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
                  SizedBox(
                    height: 15,
                  ),
                  Text(
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                  blurRadius: 5,
                  offset:
                      const Offset(3, 3), // Dịch chuyển bóng theo trục x và y
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 251, 251),
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 255, 251, 251)),
                  borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/st.JPG"),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mr.Siro",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 163, 163, 163),
                            fontFamily: 'Gelasio'),
                      ),
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
                  SizedBox(
                    height: 15,
                  ),
                  Text(
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
          ),
        ],
      ),
    );
  }
}
