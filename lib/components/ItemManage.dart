import 'package:bangiayhaki/views/DetailScreen.dart';
import 'package:flutter/material.dart';

class ItemManage extends StatefulWidget {
  const ItemManage({super.key});

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
                        builder: (context) => const DetailScreen()),
                  );
                },
                child: Container(
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
              Text(
                "\$12.00",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gelasio'),
              ),
              Text(
                "Kho: 1",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gelasio'),
              ),
            ],
          ),
          const SizedBox(
            width: 80,
          ),
          Container(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          )
        ],
      ),
    );
  }
}
