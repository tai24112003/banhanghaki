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
                  title: const Text('Make Home Beautiful'),
                ),
                const TabbarCustom()
              ],
            ),
          ),
          body: const TabBarView(children: [
            // Nội dung cho tab 1
            ListChairManager(),
            // Nội dung cho tab 2
            ListTableManager(),
            // Nội dung cho tab 3
            ListArmchairManager(),
            // Nội dung cho tab 4
            ListBedManager(),
            // Nội dung cho tab 5
            ListLampManager(),
          ]),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                                image: "",
                                idCategory: 0,
                                quantity: 0,
                                name: "",
                                price: 0,
                                descreption: "",
                              )),
                    );
                  },
                  label: const Text('Thêm sản phẩn'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: const Color.fromARGB(255, 212, 212, 212),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
        ));
  }
}
