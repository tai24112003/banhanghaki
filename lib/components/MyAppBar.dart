import 'dart:convert';

import 'package:bangiayhaki/main.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/views/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/History.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  bool _isSearching = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

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
      backgroundColor: Colors.transparent,
      title: _isSearching
          ? Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text != null &&
                        _searchController.text.isNotEmpty) {
                      addSearchHistory(_searchController.text, 2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            search: _searchController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "${widget.title}",
                textAlign: TextAlign.start,
              ),
            ),
      bottom: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(18),
              child: Container(
                  height: 60,
                  child: FutureBuilder<List<History>>(
                    future: fetchSearchHistory(2),
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                            search: history.content,
                                          )),
                                );
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
                                              deleteSearchHistory(history.id);
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

  Future<void> addSearchHistory(String content, int userId) async {
    final url = '${ApiConstants.baseUrl}/api/product/add-history';

    final Map<String, dynamic> requestData = {
      'Content': content,
      'UserId': userId.toString(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Thêm thành công history');
    } else {
      print('Error adding search history: ${response.statusCode}');
    }
  }

  Future<List<History>> fetchSearchHistory(int userId) async {
    final url = '${ApiConstants.baseUrl}/api/product/search-history/$userId';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final searchHistory = data
          .map((item) => History(
                id: item['ID'],
                content: item['Content'],
                idUser: item['UserID'],
              ))
          .toList();
      return searchHistory.cast<History>();
    } else {
      throw Exception('Failed to fetch search history');
    }
  }

  Future<void> deleteSearchHistory(int id) async {
    final url = '${ApiConstants.baseUrl}/api/product/delete-history/$id';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // Xóa thành công, thực hiện các thao tác khác nếu cần
    } else {
      // Xử lý lỗi và trả về phản hồi thích hợp
      print('Error deleting search history: ${response.statusCode}');
    }
  }
}
