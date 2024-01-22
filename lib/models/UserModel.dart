class User {
  final int ID;
  final Fullname;
  final Email;
  final Phone;
  final address;
  final Password;
  final DVToken;
  final Status;

  User(
      {required this.ID,
      required this.Fullname,
      required this.Email,
      required this.Phone,
      required this.address,
      required this.Password,
      required this.DVToken,
      required this.Status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        ID: json['ID'] ?? 0,
        Fullname: json['FullName'],
        Email: json['Email'],
        Phone: json['PhoneNumber'],
        address: json['AddressID'],
        DVToken: json['DVToken'],
        Password: json['Password'],
        Status: json['Status']);
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'Email': Email,
      'Password': Password,
      'FullName': Fullname,
      'Phone': Phone,
      'Address': address,
      'Status': Status,
      'DVToken': DVToken,
    };
  }

  @override
  String toString() {
    return 'User { Fullname: $Fullname, Email: $Email, Phone: $Phone, Address: $address, Password: $Password }';
  }
}
