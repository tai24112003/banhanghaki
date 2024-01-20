import 'dart:async';

import 'package:bangiayhaki/components/DropdownAddressItem.dart';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/presenters/AddressPresenter.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, required this.id});
  final int id;
  @override
  State<AddAddressScreen> createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen>
    implements AddressView {
  AddressPresenter? presenter;

  List<City> cities = [];
  List<District> districts = [];
  List<Ward> wards = [];
  City selectedCity = City(name: '', fullName: '', id: 89);
  District selectedDistrict = District(name: '', fullName: '', id: 886);
  Ward selectedWard = Ward(name: '', fullName: '', id: 30337);
  late TextEditingController titleName;
  late TextEditingController numberStreet;
  @override
  void initState() {
    super.initState();
    titleName = TextEditingController();
    numberStreet = TextEditingController();
    presenter = AddressPresenter(this);
    presenter?.fetchCities().then((cityList) {
      setState(() {
        cities = cityList;
        selectedCity = cities[0];
      });
    });
    presenter?.fetchWardDetails(selectedDistrict.id).then((ward) {
      setState(() {
        wards = ward;
        selectedWard = wards[0];
      });
    });
    presenter?.fetchDistrictDetails(selectedCity.id).then((district) {
      setState(() {
        districts = district;
        selectedDistrict = districts[0];
      });
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
              "Thêm địa chỉ",
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên gợi nhớ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                  TextField(
                    controller: titleName,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhà riêng',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Địa chỉ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                  TextField(
                    controller: numberStreet,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '244 Thái Văn Lung',
                    ),
                  ),
                ],
              ),
            ),
            DropdownAddressItem(
              label: "Thành Phố/Tỉnh",
              list: cities.map((city) => city.fullName).toList(),
              onChanged: (selectedValue) async {
                selectedCity =
                    cities.firstWhere((city) => city.fullName == selectedValue);

                final district =
                    await presenter?.fetchDistrictDetails(selectedCity.id);
                setState(() {
                  districts = district!;
                  selectedDistrict = districts.first;
                });

                final ward =
                    await presenter?.fetchWardDetails(selectedDistrict.id);
                setState(() {
                  wards = ward!;
                });
              },
            ),
            DropdownAddressItem(
              label: "Quận/Huyện",
              list: districts.map((district) => district.fullName).toList(),
              onChanged: (selectedValue) async {
                selectedDistrict = districts.firstWhere(
                    (district) => district.fullName == selectedValue);
                final ward =
                    await presenter?.fetchWardDetails(selectedDistrict.id);
                setState(() {
                  wards = ward!;
                });
              },
            ),
            DropdownAddressItem(
              label: "Ấp/Phường",
              list: wards.map((ward) => ward.fullName).toList(),
              onChanged: (selectedValue) {
                selectedWard = wards
                    .firstWhere((element) => element.fullName == selectedValue);
              },
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    presenter?.addAddress(
                        fullName: (numberStreet.text +
                            " " +
                            selectedWard.fullName +
                            " " +
                            selectedDistrict.fullName +
                            " " +
                            selectedCity.fullName),
                        titleName: titleName.text,
                        id: widget.id);
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    "Lưu Địa Chỉ",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
