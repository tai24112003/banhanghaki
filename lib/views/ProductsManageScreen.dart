import 'package:bangiayhaki/models/BottomBarCustom.dart';
import 'package:bangiayhaki/models/TabBarCustom.dart';
import 'package:bangiayhaki/presenters/Manage/ListArmchairManage.dart';
import 'package:bangiayhaki/presenters/Manage/ListBedManage.dart';
import 'package:bangiayhaki/presenters/Manage/ListChairManage.dart';
import 'package:bangiayhaki/presenters/Manage/ListLampManage.dart';
import 'package:bangiayhaki/presenters/Manage/ListTableManage.dart';
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
        length: 5, // Số lượng tab
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  130), // Tính kích thước tối ưu cho AppBar và TabBar
              child: Column(
                children: [
                  AppBar(
                    title: Text('Make Home Beautiful'),
                  ),
                  TabbarCustom()
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
                  margin: EdgeInsets.only(bottom: 50),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductsScreen()),
                      );
                    },
                    label: Text('Thêm sản phẩn'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Color.fromARGB(255, 212, 212, 212),
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ) // Khoảng cách giữa hai nút
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: BottomBarCustom(
              active: 2,
            )));
  }
}
