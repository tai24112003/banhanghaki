class User {
  final id;
  final Fullname;
  final Email;
  final Phone;
  final address;
  final Password;
  final Status;

  User(
      {required this.id,
      required this.Fullname,
      required this.Email,
      required this.Phone,
      required this.address,
      required this.Password,
      required this.Status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['ID'],
        Fullname: json['FullName'],
        Email: json['Email'],
        Phone: json['Phone'],
        address: json['Address'],
        Password: json['Password'],
        Status: json['Status']);
  }
  Map<String, dynamic> toJson() {
    return {
      'Email': Email,
      'Password': Password,
      'FullName': Fullname,
      'Phone': Phone,
      'Address': address,
      'Status': Status,
    };
  }
}
