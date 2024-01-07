import 'package:flutter/material.dart';

class TabbarCustom extends StatefulWidget {
  const TabbarCustom({super.key});

  @override
  State<TabbarCustom> createState() => _TabbarCustomState();
}

class _TabbarCustomState extends State<TabbarCustom> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
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
          ), // Hình ảnh cho tab 1
          text: 'Ghế', // Tiêu đề cho tab 1
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
          ), // Hình ảnh cho tab 2
          text: 'Bàn', // Tiêu đề cho tab 2
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
          ), // Hình ảnh cho tab 3
          text: 'Ghế bành', // Tiêu đề cho tab 3
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
          ), // Hình ảnh cho tab 4
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
