
class Place{
  int? id;
  String? name;
  double? star;
  String? image;

  Place({this.id, this.name, this.star, this.image});

  factory Place.valueFromJson(Map<String, dynamic> json){
    return Place(
      id: json["id"] as int,
      name: json["name"] as String,
      star: json["star"] as double,
      image: json["image"] as String,
    );
  }
}