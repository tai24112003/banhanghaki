class Address {
  final ID;
  final NameAddress;
  final FullAddress;

  Address({
    required this.ID,
    required this.NameAddress,
    required this.FullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      ID: json['ID'],
      NameAddress: json['TitleName'],
      FullAddress: json['FullName'],
    );
  }
}

class City {
  final String name;
  final String fullName;
  final int id;

  City({
    required this.name,
    required this.fullName,
    required this.id,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      fullName: json['full_name'],
      id: json['id'],
    );
  }
}

class District {
  final String name;
  final String fullName;
  final int id;

  District({
    required this.name,
    required this.fullName,
    required this.id,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      fullName: json['full_name'],
      id: json['id'],
    );
  }
}

class Ward {
  final String name;
  final String fullName;
  final int id;

  Ward({
    required this.name,
    required this.fullName,
    required this.id,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      name: json['name'],
      fullName: json['full_name'],
      id: json['id'],
    );
  }
}
