import 'dart:convert';
import 'package:mi_cameo/src/models/links_model.dart';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));
String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
  CategoriesResponse({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.categories,
  });

  Links links;
  int total;
  int page;
  int pageSize;
  List<Category> categories;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        links     : Links.fromJson(json["links"]),
        total     : json["total"],
        page      : json["page"],
        pageSize  : json["page_size"],
        categories: List<Category>.from(json["results"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links"     : links.toJson(),
        "total"     : total,
        "page"      : page,
        "page_size" : pageSize,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.categories,
    this.url,
  });

  int id;
  String name;
  List<String> categories;
  String url;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id        : json["id"],
        name      : json["name"],
        categories: List<String>.from(json["categorys"].map((x) => x)),
        url       : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id"        : id,
        "name"      : name,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "url"       : url,
      };
}
