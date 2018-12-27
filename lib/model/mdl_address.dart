class MdlAddress {
  final String street;
  final String city;

  MdlAddress({this.street, this.city});

  factory MdlAddress.fromJson(Map<String, dynamic> json) {
    return MdlAddress(
      street: json['street'] as String,
      city: json['city'] as String,
    );
  }
}