class User {
  final id;
  final Fullname;
  final Email;
  final Phone;
  final address;
  final Password;

  User({
    required this.id,
    required this.Fullname,
    required this.Email,
    required this.Phone,
    required this.address,
    required this.Password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['ID'],
        Fullname: json['Fullname'],
        Email: json['Email'],
        Phone: json['PhoneNumber'],
        address: json['Address'],
        Password: json['Password']);
  }
  Map<String, dynamic> toJson() {
    return {
      'Email': Email,
      'Password': Password,
      'FullName': Fullname,
      'PhoneNumber': Phone,
      'Address': address,
    };
  }
}
