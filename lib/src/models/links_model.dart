class Links {
  Links({
    this.next,
    this.previous,
  });

  String next;
  String previous;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next    : json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "next"    : next,
        "previous": previous,
      };
}