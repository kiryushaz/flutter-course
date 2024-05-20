class Location {
  final int id;
  final String address;
  final double lat;
  final double lng;

  const Location(
      {required this.id,
      required this.address,
      required this.lat,
      required this.lng});

  @override
  String toString() => address;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "address": address, "lat": lat, "lng": lng};
}
