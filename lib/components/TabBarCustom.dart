import 'package:flutter/material.dart';

class TabbarCustom extends StatefulWidget {

  const TabbarCustom({Key? key});

  @override
  State<TabbarCustom> createState() => _TabbarCustomState();
}

class _TabbarCustomState extends State<TabbarCustom> {
  @override
  Widget build(BuildContext context) {
    return  TabBar(
      tabs: [
        Tab(
          icon: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(
              'assets/chair.JPG',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ), 
          text: 'Ghế', 
        ),
        Tab(
          icon: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: Image.asset(
              'assets/table.JPG',
              width: 45,
              height: 40,
              fit: BoxFit.cover,
            ),
          ), 
          text: 'Bàn', 
        ),
        Tab(
          icon: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(
              'assets/sofa.JPG',
              width: 45,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          text: 'Ghế bành',
        ),
        Tab(
          icon: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(
              'assets/bed.JPG',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ), 
          text: 'Giường', // Tiêu đề cho tab 4
        ),
        Tab(
          icon: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(
              'assets/lab.JPG',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ), // Hình ảnh cho tab 5
          text: 'Đèn', // Tiêu đề cho tab 5
        ),
      ],
    );
  }
}
