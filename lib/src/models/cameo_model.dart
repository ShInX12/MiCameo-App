class Cameo {
    Cameo({
        this.id,
        this.urlVideo,
        this.order,
    });

    int id;
    String urlVideo;
    String order;

    factory Cameo.fromJson(Map<String, dynamic> json) => Cameo(
        id: json["id"],
        urlVideo: json["url_video"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url_video": urlVideo,
        "order": order,
    };
}
