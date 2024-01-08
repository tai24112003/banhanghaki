import 'package:bangiayhaki/components/AccoutItem.dart';
import 'package:flutter/material.dart';

class AccoutManageScreen extends StatefulWidget {
  const AccoutManageScreen({super.key});

  @override
  State<AccoutManageScreen> createState() => _AccoutManageScreenState();
}

class _AccoutManageScreenState extends State<AccoutManageScreen> {
  void Cham() {
    print("Cham123");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Tài khoản khách hàng",
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Có 22 khách hàng trong hôm nay"),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountItem(
                        name: "Tài Nguyễn",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                      AccountItem(
                        name: "Quân Đặng",
                        email: "Tai@gmail.com",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
