import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

var _selectedValue;

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
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
                        child: Image.asset(
                          'assets/st.JPG',
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
                        )),
                    Positioned(
                        top: 190,
                        left: 17,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  radioTheme: RadioThemeData(
                                    fillColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  ),
                                ),
                                child: Radio(
                                  value: 1,
                                  groupValue: _selectedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue = newValue;
                                    });
                                  },
                                  activeColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  radioTheme: RadioThemeData(
                                    fillColor:
                                        MaterialStateProperty.all(Colors.brown),
                                  ), // Màu sắc cho radio button không được chọn
                                ),
                                child: Radio(
                                  value: 2,
                                  groupValue: _selectedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue = newValue;
                                    });
                                  },
                                  activeColor: Colors.brown,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  radioTheme: RadioThemeData(
                                    fillColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 197, 62, 62)),
                                  ), // Màu sắc cho radio button không được chọn
                                ),
                                child: Radio(
                                  value: 3,
                                  groupValue: _selectedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue = newValue;
                                    });
                                  },
                                  activeColor:
                                      const Color.fromARGB(255, 190, 58, 58),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Minimal Stand",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Gelasio'),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("\$ 50",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Gelasio'))
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
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
                          const Text("0",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Colors.black,
                              )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          )
                        ],
                      )
                    ],
                  )
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
                  Text("4.5",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: 25,
                  ),
                  Text("(50 preview)",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 19,
                        color: Colors.grey,
                      )),
                ],
              ),
              const Text(
                "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
                softWrap: true,
                maxLines: 10,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ));
  }
}
