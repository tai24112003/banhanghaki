import 'package:bangiayhaki/components/CartItem.dart';
import 'package:bangiayhaki/components/DetailOrderItem.dart';
import 'package:bangiayhaki/models/CartItemModel.dart';
import 'package:bangiayhaki/presenters/CartPresenter.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.idUser});
  final int idUser;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List _lstCartItem = [];
  List _selectedCartItem = [];
  double _total = 0;
  int idCart = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdCart(widget.idUser);
  }

  void onUpdateQuan(int id, int quan) {
    CartPresenter.updateItemInCart(id, quan).then((value) {
      if (value) {
        loadData();
        var a = _selectedCartItem.firstWhere((element) => element.id == id,
            orElse: () => null);
        if (a != null) {
          a.setQuantity = quan;
        }
      }
    });
  }

  void quan() {
    _total = 0;
    _selectedCartItem.forEach((element) {
      _total += element.quantity * element.product.price;
    });
  }

  void processSelected(CartItemModel model, bool isSelected) {
    if (isSelected) {
      CartItemModel? tmp = _selectedCartItem.firstWhere((element) {
        return element.id == model.id;
      }, orElse: () => null);
      if (tmp != null) {
        _selectedCartItem.remove(tmp);
      }
      _selectedCartItem.add(model);
      // _total += model.quantity * model.product.price;
    } else if (!isSelected) {
      CartItemModel? tmp = _selectedCartItem.firstWhere((element) {
        return element.id == model.id;
      }, orElse: () => null);
      if (tmp != null) {
        _selectedCartItem.remove(tmp);
        //_total -= tmp.quantity * tmp.product.price;
      }
    }
    setState(() {
      quan();
    });
    print(_selectedCartItem.length);
  }

  void deleteItem(int id) {
    CartPresenter.deleteItemInCartById(id).then((value) {
      if (value) {
        _selectedCartItem.removeWhere((element) => element.id == id);
        loadData();
      }
    });
  }

  void deleteAllItem() {
    CartPresenter.deleteItemInCart(idCart).then((value) {
      if (value) {
        _selectedCartItem.clear();
        loadData();
      }
    });
  }

  void getIdCart(int idU) {
    CartPresenter.getCartID(idU).then((value) {
      idCart = int.parse(value);
      loadData();
    });
  }

  void loadData() {
    CartPresenter.loadData(idCart).then((value) => {
          setState(() {
            _lstCartItem = CartPresenter.lstProIncart;
            quan();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Giỏ hàng",
              textAlign: TextAlign.center,
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: deleteAllItem,
                  child: Text(
                    "Xoá hết",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          //list product here
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: _lstCartItem.map((e) {
                    return CartItem(
                      cartIt: e,
                      onDelete: deleteItem,
                      onChecked: processSelected,
                      onUpdateQuan: onUpdateQuan,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng tiền:",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "\$ $_total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                          offset: Offset(5, 5))
                    ]),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutScreen(id: widget.idUser),
                            ));
                      },
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.fromLTRB(0, 15, 0, 15)),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      child: const Text(
                        "Đặt hàng",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
