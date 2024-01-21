import 'package:bangiayhaki/components/Manage/ListArmchairManage.dart';
import 'package:bangiayhaki/components/Manage/ListBedManage.dart';
import 'package:bangiayhaki/components/Manage/ListChairManage.dart';
import 'package:bangiayhaki/components/Manage/ListLampManage.dart';
import 'package:bangiayhaki/components/Manage/ListTableManage.dart';
import 'package:bangiayhaki/components/TabBarCustom.dart';
import 'package:bangiayhaki/views/AddProductScreen.dart';
import 'package:flutter/material.dart';

class ProductsManageScreen extends StatefulWidget {
  const ProductsManageScreen({super.key});

  @override
  State<ProductsManageScreen> createState() => _ProductsManageScreenState();
}

class _ProductsManageScreenState extends State<ProductsManageScreen> {
  void test() {
    setState(() {
      print("Thêm ++++++++");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'Quản lý sản phẩm',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const TabbarCustom()
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ListChairManager(),
                  ListTableManager(),
                  ListArmchairManager(),
                  ListBedManager(),
                  ListLampManager(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width * 0.96,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProduct(
                        id: 0,
                        image: [],
                        idCategory: 0,
                        quantity: 0,
                        name: "",
                        price: 0,
                        descreption: "",
                        onRestart: test,
                      ),
                    ),
                  );
                },
                label: const Text('Thêm sản phẩm'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: const Color.fromARGB(255, 212, 212, 212),
                foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
