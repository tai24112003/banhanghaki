class Address {
  final NameAddress;
  final FullAddress;

  Address({
    required this.NameAddress,
    required this.FullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      NameAddress: json['NameAddress'],
      FullAddress: json['FullAddress'],
    );
  }
}

class User {
  final Fullname;
  final Email;
  final Phone;
  final Address address;

  User({
    required this.Fullname,
    required this.Email,
    required this.Phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Fullname: json['Fullname'],
      Email: json['Email'],
      Phone: json['Phone'],
      address: Address.fromJson(json['Address']),
    );
  }
}
