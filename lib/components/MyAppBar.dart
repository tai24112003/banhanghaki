import 'dart:convert';

import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/HistoryPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/CartScreen.dart';
import 'package:bangiayhaki/views/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/History.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, required this.UserId});
  final String title;
  final int UserId;
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> implements UserView {
  bool _isSearching = false;
  late TextEditingController _searchController;
  late User? user;
  late UserPresenter presenter;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    presenter = UserPresenter(this);
    loadUser();
  }

  void loadUser() async {
    user = await presenter.getUserById(widget.UserId);
  }

  List<String> _searchHistory = [];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(_isSearching ? Icons.arrow_back : Icons.search),
        onPressed: () {
          setState(() {
            _isSearching = !_isSearching;
            if (!_isSearching) {
              _searchController.clear();
            }
          });
        },
      ),
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      title: _isSearching
          ? Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm...',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 135, 135),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    if (_searchController.text != null &&
                        _searchController.text.isNotEmpty) {
                      bool hasNetwork =
                          await HitstoryPresenter.hasNetworkConnection();
                      setState(() {
                        HitstoryPresenter.addSearchHistory(
                            _searchController.text, widget.UserId);
                      });
                      if (hasNetwork) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(
                              id: widget.UserId,
                              search: _searchController.text,
                            ),
                          ),
                        );
                      } else {
                        _searchController.text = "Không có internet";
                      }
                    }
                  },
                ),
              ],
            )
          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Text(
                  "${widget.title}",
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          idUser: widget.UserId,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart))
            ]),
      bottom: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(18),
              child: Container(
                  height: 60,
                  child: FutureBuilder<List<HistorySearch>>(
                    future: HitstoryPresenter.fetchAndSaveSearchHistory(
                        widget.UserId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null) {
                        return Text('Data is null');
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final history = snapshot.data![index];
                            return GestureDetector(
                              onTap: () async {
                                bool hasNetwork = await HitstoryPresenter
                                    .hasNetworkConnection();
                                if (hasNetwork) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                        id: widget.UserId,
                                        search: history.content,
                                      ),
                                    ),
                                  );
                                } else {
                                  _searchController.text = "Không có internet";
                                }
                              },
                              child: Card(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(history.content),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              HitstoryPresenter
                                                  .deleteSearchHistory(
                                                      history.id);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            size: 15,
                                          ))
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    },
                  )),
            )
          : null,
    );
  }

  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
