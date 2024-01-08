import 'package:flutter/material.dart';

class CongratScreen extends StatelessWidget {
  const CongratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Thành Công!",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image(
                  image: AssetImage("assets/congra.png"),
                  width: 300,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: -20,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            const Text(
              "Đơn hàng sẽ sớm được giao\nCảm ơn đã lựa chọn sản phẩm chúng tôi",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: const Text(
                    "Theo Dõi Đơn Hàng",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: const Text(
                    "Quay lại",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
