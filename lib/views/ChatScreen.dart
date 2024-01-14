import 'dart:math';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double heightChatBox = 0.0;
  List<Map<String, String>> a = [
    {"au": "k", "cont": "Hi Shop"},
    {"au": "s", "cont": "Hi you, Can I help you?"}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "HAKI STORE",
            textAlign: TextAlign.center,
          ),
        ),
        actions: const [Icon(Icons.video_call_rounded)],
      ),
      body: GestureDetector(
        onVerticalDragStart: (e) {
          _focusNode.unfocus();
        },
        onTap: () {
          _focusNode.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.withOpacity(0.5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Shop sẽ phản hồi sau khoảng 2 giờ"),
                  ),
                  //Nội dung tin nhắn

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
                    child: SizedBox(
                      height: heightChatBox == 0.0
                          ? MediaQuery.of(context).size.height * 0.65
                          : heightChatBox,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: a.length,
                          itemBuilder: (BuildContext context, int idx) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: a[idx]["au"] == "s"
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: a[idx]["au"] != "s"
                                                ? Colors.blue
                                                : Colors.purple,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Text(
                                          a[idx]["cont"]!,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          softWrap: true,
                                        )),
                                  ],
                                ));
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width * 0.78,
                            child: TextField(
                              maxLines: null,
                              expands: true,
                              minLines: null,
                              focusNode: _focusNode,
                              onTapOutside: (e) {
                                setState(() {
                                  heightChatBox =
                                      MediaQuery.of(context).size.height * 0.65;
                                });
                              },
                              onEditingComplete: () {
                                if (_controller.text.trim() != '') {
                                  Map<String, String> newMes = {
                                    "au": "k",
                                    "cont": _controller.text
                                  };
                                  setState(() {
                                    _controller.text = "";
                                    a.add(newMes);
                                  });
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent +
                                        50,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                  );
                                } else {}
                              },
                              onTap: () {
                                setState(() {
                                  heightChatBox =
                                      MediaQuery.of(context).size.height * 0.25;
                                });
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent +
                                      500,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                );
                              },
                              controller: _controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white, // Màu nền mong muốn
                                  hintText: 'Chat here', // Gợi ý văn bản
                                  border: OutlineInputBorder(
                                    // Đường viền
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_controller.text.trim() != '') {
                              Map<String, String> newMes = {
                                "au": "k",
                                "cont": _controller.text
                              };
                              setState(() {
                                heightChatBox =
                                    MediaQuery.of(context).size.height * 0.25;
                                _controller.text = "";
                                a.add(newMes);
                              });
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent +
                                    1000,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            } else {
                              setState(() {
                                heightChatBox =
                                    MediaQuery.of(context).size.height * 0.25;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
