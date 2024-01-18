
class User {
  final Fullname;
  final Email;
  final Phone;
  final address;
  final Password;

  User({
    required this.Fullname,
    required this.Email,
    required this.Phone,
    required this.address,
    required this.Password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Fullname: json['Fullname'],
        Email: json['Email'],
        Phone: json['Phone'],
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