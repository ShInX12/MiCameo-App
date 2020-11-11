import 'dart:convert';
import 'dart:typed_data';

List<Ocassion> ocassionsFromBodyBytes(Uint8List bodyBytes) =>
    List<Ocassion>.from(json.decode(utf8.decode(bodyBytes)).map((x) => Ocassion.fromJson(x)));

List<Ocassion> ocassionsFromJson(String str) =>
    List<Ocassion>.from(json.decode(str).map((x) => Ocassion.fromJson(x)));

String ocassionsToJson(List<Ocassion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ocassion {
  Ocassion({
    this.name,
  });

  String name;

  factory Ocassion.fromJson(Map<String, dynamic> json) => Ocassion(
        name: json["occasion_name"],
      );

  Map<String, dynamic> toJson() => {
        "occasion_name": name,
      };
}
