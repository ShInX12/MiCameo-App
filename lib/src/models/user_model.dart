// import 'dart:convert';

class User {
    User({
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.url,
    });

    String username;
    String email;
    String firstName;
    String lastName;
    String url;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username : json["username"],
        email    : json["email"],
        firstName: json["first_name"],
        lastName : json["last_name"],
        url      : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "username"  : username,
        "email"     : email,
        "first_name": firstName,
        "last_name" : lastName,
        "url"       : url,
    };
}

class Talent {
    Talent({
        this.user,
        this.profileImage,
        this.description,
        this.responseDays,
        this.price,
        this.url,
        this.categories,
        this.birthday,
    });

    User user;
    String profileImage;
    String description;
    int responseDays;
    String price;
    String url;
    List<String> categories;
    dynamic birthday;

    factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        user        : User.fromJson(json["user"]),
        profileImage: json["profile_image"],
        description : json["description"],
        responseDays: json["response_days"],
        price       : json["price"],
        url         : json["url"],
        categories  : List<String>.from(json["categories"].map((x) => x)),
        birthday    : json["birthday"],
    );

    Map<String, dynamic> toJson() => {
        "user"         : user.toJson(),
        "profile_image": profileImage,
        "description"  : description,
        "response_days": responseDays,
        "price"        : price,
        "url"          : url,
        "categories"   : List<dynamic>.from(categories.map((x) => x)),
        "birthday"     : birthday,
    };

  @override
  String toString() {
    return 'Talento ${this.user.username}';
  }
}

// Client clientFromJson(String str) => Client.fromJson(json.decode(str));
// String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    Client({
        this.user,
        this.profileImage,
        this.phoneNumber,
        this.birthday,
        this.url,
    });

    User user;
    String profileImage;
    String phoneNumber;
    dynamic birthday;
    String url;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        user        : User.fromJson(json["user"]),
        profileImage: json["profile_image"],
        phoneNumber : json["phone_number"],
        birthday    : json["birthday"],
        url         : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "user"         : user.toJson(),
        "profile_image": profileImage,
        "phone_number" : phoneNumber,
        "birthday"     : birthday,
        "url"          : url,
    };
}