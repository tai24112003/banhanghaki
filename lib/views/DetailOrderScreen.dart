import 'package:bangiayhaki/components/DetailOrderItem.dart';
import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/OrderDetailsPresenter.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:flutter/material.dart';

class DetailOrderScreen extends StatefulWidget {
  const DetailOrderScreen(
      {required this.total, required this.stt, required this.id, Key? key})
      : super(key: key);
  final int total;
  final int id;
  final String stt;

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen>
    implements UserView {
  List<OrderDetails> lstdetailorder = [];
  bool isLoading = true;
  UserPresenter? user;
  User? admin;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      admin = await user?.getUserById(1);
      await OrderDetailPresenter.loadData(widget.id);
      setState(() {
        lstdetailorder = OrderDetailPresenter.lstOrderDetails;
        isLoading = false;
      });
    } catch (error) {
      print('Error loading data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ${widget.id.toString().padLeft(5, '0')}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.stt,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.stt.toString() == "Đã giao" ||
                        widget.stt.toString() == "Đã hủy"
                    ? const Text("")
                    : TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(5)),
                          shape:
                              MaterialStateProperty.all(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                        ),
                        onPressed: () {
                          OrderPresenter.updateSttnew(
                              widget.id,
                              widget.stt == "Đang xử lí"
                                  ? "Đã Hủy"
                                  : "Đã giao");
                          NotificationServices().sendFCMNotification(
                              title: "Cập nhật đơn hàng",
                              body: "Đơn hàng đã giao tới",
                              deviceToken: admin!.DVToken);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(3, 3),
                              ),
                            ],
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            widget.stt.toString() == "Đang xử lí"
                                ? "Hủy đơn"
                                : widget.stt.toString() == "Đang giao"
                                    ? "Đã nhận được hàng"
                                    : "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ],
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: lstdetailorder.length,
                      itemBuilder: (context, index) {
                        return DetailOrderItem(myitem: lstdetailorder[index]);
                      },
                    ),
                  ),
            Container(
              margin: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng tiền:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$ 95.00:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
