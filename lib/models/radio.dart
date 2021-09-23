

class MyradioList {
  // MyradioList({
  //   required this.radios,
  // });

  static List<MyRadio> ?radios;

  // factory MyradioList.fromJson(Map<String, dynamic> json) => MyradioList(
  //       radios:
  //           List<MyRadio>.from(json["radios"].map((x) => MyRadio.fromJson(x))),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "radios": List<dynamic>.from(radios.map((x) => x.toJson())),
  //     };
}

class MyRadio {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String lang;
  MyRadio({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    required this.lang,
  });

  factory MyRadio.fromJson(Map<String, dynamic> json) => MyRadio(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        color: json["color"],
        desc: json["desc"],
        url: json["url"],
        icon: json["icon"],
        image: json["image"],
        lang: json["lang"],
        category: json["category"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tagline": tagline,
        "color": color,
        "desc": desc,
        "url": url,
        "icon": icon,
        "image": image,
        "lang": lang,
        "category": category,
        "order": order,
      };
}
