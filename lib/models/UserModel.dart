class User {
  final int ID;
  final Fullname;
  final Email;
  final Phone;
  final address;
  final Password;

  User({
    required this.ID,
    required this.Fullname,
    required this.Email,
    required this.Phone,
    required this.address,
    required this.Password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        ID: json['ID'] ?? "",
        Fullname: json['Fullname'] ?? "",
        Email: json['Email'] ?? "",
        Phone: json['PhoneNumber'] ?? "",
        address: json['AddressID'] ?? "",
        Password: json['Password'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'Email': Email,
      'Password': Password,
      'FullName': Fullname,
      'PhoneNumber': Phone,
      'Address': address,
    };
  }

  @override
  String toString() {
    return 'User { Fullname: $Fullname, Email: $Email, Phone: $Phone, Address: $address, Password: $Password }';
  }
}
