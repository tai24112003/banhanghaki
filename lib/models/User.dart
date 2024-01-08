class User {
  final Fullname;
  final Email;
  final Phone;
  final Address;
  User(
      {required this.Fullname,
      required this.Email,
      required this.Phone,
      required this.Address});
}

class Address {
  final NameAddress;
  final FullAddress;
  Address({required this.NameAddress, required this.FullAddress});
}
