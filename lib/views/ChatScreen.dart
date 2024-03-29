import 'package:bangiayhaki/models/MessageModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/Message.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:flutter/scheduler.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.idUser, required this.toUser});
  final int idUser;
  final int toUser;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements UserView {
  late io.Socket socket;

  List<String> messages = [];
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late final ScrollController _scrollController;
  double heightChatBox = 0.0;
  List<MessageConvert> a = [];
  late User user;
  late User userto;
  @override
  void dispose() {
    // TODO: implement dispose
    socket.disconnect();
    socket.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void upUi(dynamic data) {
    a.add(MessageConvert.fromJson({
      "FromID": data["content"]["from"],
      "MessageText": data["content"]["content"]
    }));
    setState(() {});
  }

  void loadDt() async {
    user = (await UserPresenter(this).getUserById(widget.idUser))!;
    userto = (await UserPresenter(this).getUserById(widget.toUser))!;
    print(userto.ID.toString() + "ID ne");
    if (widget.idUser != 1) {
      MessagePresenter.loadData(widget.idUser).then((value) {
        setState(() {
          a = MessagePresenter.lstProIncart;
        });
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent + 1000);
        });
      });
    } else {
      MessagePresenter.loadDataAdmin(widget.toUser).then((value) {
        setState(() {
          a = MessagePresenter.lstProIncart;
        });
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent + 1000);
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    loadDt();

    socket = io.io(ApiConstants.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('message', (data) {
      if ((data["content"]["to"] == widget.idUser.toString() &&
              widget.idUser.toString() != "1") ||
          (data["content"]["to"] == "1" &&
              data["content"]["from"] == widget.toUser.toString())) {
        loadDt();
      }
    });
    if (widget.idUser < 2) {
      socket.emit('admin', {"from": widget.idUser, "to": widget.toUser});
    } else {
      socket.emit('client', {"from": widget.idUser, "to": 1});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "HAKI STORE",
          textAlign: TextAlign.center,
        ),
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
                                  mainAxisAlignment: a[idx].au.toString() !=
                                          widget.idUser.toString()
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7, // Giới hạn chiều rộng tối đa của container
                                        ),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: a[idx].au.toString() !=
                                                    widget.idUser.toString()
                                                ? Colors.blue
                                                : Colors.purple,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Text(
                                          a[idx].cont,
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
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width * 0.75,
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
                                  dynamic newMes = {
                                    "au": widget.idUser.toString(),
                                    "cont": _controller.text
                                  };
                                  setState(() {
                                    _controller.text = "";
                                    a.add(MessageConvert.fromJson(newMes));
                                  });
                                  _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent +
                                        50,
                                  );
                                } else {}
                              },
                              onTap: () {
                                setState(() {
                                  heightChatBox =
                                      MediaQuery.of(context).size.height * 0.25;
                                });
                                _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent +
                                      1000,
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
                              socket.emit('message', {
                                'from': widget.idUser.toString(),
                                'to': widget.toUser.toString(),
                                'content': _controller.text,
                              });
                              setState(() {
                                heightChatBox =
                                    MediaQuery.of(context).size.height * 0.25;
                                a.add(MessageConvert.fromJson({
                                  "FromID": widget.idUser,
                                  "MessageText": _controller.text
                                }));
                                _controller.text = "";
                                _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent +
                                      1000,
                                );
                                // a.add(newMes);
                                NotificationServices().sendFCMNotification(
                                    title: user.Fullname + "vừa gửi tin nhắn",
                                    body: _controller.text,
                                    deviceToken: userto.DVToken);
                              });
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

  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
