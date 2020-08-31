import 'dart:convert';
import 'package:mi_cameo/src/models/links_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';

TalentSearchResponse talentSearchResponseFromJson(String str) => TalentSearchResponse.fromJson(json.decode(str));
String talentSearchResponseToJson(TalentSearchResponse data) => json.encode(data.toJson());

class TalentSearchResponse {
  TalentSearchResponse({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.talents,
  });

  Links links;
  int total;
  int page;
  int pageSize;
  List<Talent> talents;

  factory TalentSearchResponse.fromJson(Map<String, dynamic> json) =>
      TalentSearchResponse(
        links   : Links.fromJson(json["links"]),
        total   : json["total"],
        page    : json["page"],
        pageSize: json["page_size"],
        talents :List<Talent>.from(json["results"].map((x) => Talent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links"    : links.toJson(),
        "total"    : total,
        "page"     : page,
        "page_size": pageSize,
        "talents"  : List<dynamic>.from(talents.map((x) => x.toJson())),
      };
}
