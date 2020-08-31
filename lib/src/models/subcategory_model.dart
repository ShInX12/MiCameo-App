import 'dart:convert';
import 'package:mi_cameo/src/models/links_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';

SubcategoriesResponse subcategoriesResponseFromJson(String str) => SubcategoriesResponse.fromJson(json.decode(str));
String subcategoriesResponseToJson(SubcategoriesResponse data) => json.encode(data.toJson());

class SubcategoriesResponse {
  SubcategoriesResponse({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.subcategories,
  });

  Links links;
  int total;
  int page;
  int pageSize;
  List<Subcategory> subcategories;

  factory SubcategoriesResponse.fromJson(Map<String, dynamic> json) =>
      SubcategoriesResponse(
        links        : Links.fromJson(json["links"]),
        total        : json["total"],
        page         : json["page"],
        pageSize     : json["page_size"],
        subcategories: List<Subcategory>.from(json["results"].map((x) => Subcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links"        : links.toJson(),
        "total"        : total,
        "page"         : page,
        "page_size"    : pageSize,
        "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class Subcategory {
  Subcategory({
    this.id,
    this.subName,
    this.category,
    this.talents,
  });

  int id;
  String subName;
  String category;
  List<Talent> talents;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id      : json["id"],
        subName : json["sub_name"],
        category: json["category"],
        talents : List<Talent>.from(json["talent_category"].map((x) => Talent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id"             : id,
        "sub_name"       : subName,
        "category"       : category,
        "talent_category": List<dynamic>.from(talents.map((x) => x.toJson())),
      };
}
