import 'package:bangiayhaki/components/AccoutItem.dart';
import 'package:bangiayhaki/components/HistoryPhoneItem.dart';
import 'package:bangiayhaki/models/History.dart';
import 'package:bangiayhaki/presenters/AccountManagePresenter.dart';
import 'package:bangiayhaki/presenters/StoreLocal.dart';
import 'package:bangiayhaki/views/OrderOfCus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _showDialog(BuildContext context, TextEditingController txt,
    Function(String) onSearch, List<String> a, String keyStore) async {
  a.remove('');
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [Icon(Icons.search), Text('Tìm kiếm')],
        ),
        content: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: txt,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5),
                            gapPadding: 0), // Thêm viền
                        labelText: 'PhoneNumber or Email?',
                      ),
                    ),
                  ),
                  Column(
                    children: a.map((v) {
                      return HistoryPhoneItem(content: v, txt: txt);
                    }).toList(),
                  )
                ],
              ),
            )),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  if (txt.text != "") {
                    a.remove(txt.text);
                    a.insert(0, txt.text);
                    a = a.take(15).toList();
                    Stored.saveText(keyStore, a.join("->"));
                  }
                  onSearch(txt.text);
                  txt.text = "";

                  Navigator.of(context).pop();
                },
                child: Text('Tìm'),
              ),
              TextButton(
                onPressed: () {
                  txt.text = "";
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

class AccoutManageScreen extends StatefulWidget {
  const AccoutManageScreen({super.key});
  @override
  State<AccoutManageScreen> createState() => _AccoutManageScreenState();
}

class _AccoutManageScreenState extends State<AccoutManageScreen> {
  late List<dynamic> lstAcc = [];
  late List<dynamic> lstFiltered = [];
  TextEditingController _textFieldController = TextEditingController();
  String _history = "";
  final String keyStore = "history_search";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountManagePresenter().getListUser().then((value) {
      setState(() {
        lstAcc = value;
        lstFiltered = lstAcc;
      });
    });
    Stored.loadStoredText(keyStore).then((value) {
      _history = value;
    });
  }

  void findAccount(String acc) {
    lstFiltered = lstAcc.where((element) {
      return (element.Phone == acc || element.Email.contains(acc));
    }).toList();
    if (acc == "") lstFiltered = lstAcc;
    setState(() {
      Stored.loadStoredText(keyStore).then((value) {
        _history = value;
      });
    });
  }

  void onClickHistory(TextEditingController txt, String value) {
    txt.text = value;
  }

  void updateAccout(int id) {
    AccountManagePresenter().updateByUser(id).then((value) => {
          if (value["status"] == "Success")
            {
              AccountManagePresenter().getListUser().then((value) {
                setState(() {
                  lstAcc = value;
                  lstFiltered = lstAcc;
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Tài khoản khách hàng",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showDialog(context, _textFieldController, findAccount,
                  _history.split("->"), keyStore);
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Có ${lstFiltered.length} tài khoản khách hàng"),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: lstFiltered.isNotEmpty
                        ? lstFiltered.map((e) {
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
