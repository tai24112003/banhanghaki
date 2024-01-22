import 'package:bangiayhaki/components/AccoutItem.dart';
import 'package:bangiayhaki/presenters/AccountManagePresenter.dart';
import 'package:bangiayhaki/views/OrderOfCus.dart';
import 'package:flutter/material.dart';

class AccoutManageScreen extends StatefulWidget {
  const AccoutManageScreen({super.key});
  @override
  State<AccoutManageScreen> createState() => _AccoutManageScreenState();
}

class _AccoutManageScreenState extends State<AccoutManageScreen> {
  late List<dynamic> lstAcc = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountManagePresenter().getListUser().then((value) {
      setState(() {
        lstAcc = value;
      });
    });
  }

  void updateAccout(int id) {
    AccountManagePresenter().updateByUser(id).then((value) => {
          if (value["status"] == "Success")
            {
              AccountManagePresenter().getListUser().then((value) {
                setState(() {
                  lstAcc = value;
                });
              })
            }
        });
  }

  void onClickAccount(int id, String email) {
    print(id);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderOfCus(email: email, id: id),
        ));
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
            Text("Có ${lstAcc.length} tài khoản khách hàng"),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: lstAcc.isNotEmpty
                        ? lstAcc.map((e) {
                            return AccountItem(
                              id: e.id,
                              name: e.Fullname,
                              email: e.Email,
                              status: e.Status,
                              onTap: onClickAccount,
                              onClickBtn: updateAccout,
                            );
                          }).toList()
                        : [],
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
