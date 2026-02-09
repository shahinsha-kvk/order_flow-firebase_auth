// To parse this JSON data, do
//
//     final menuModel = menuModelFromMap(jsonString);

import 'dart:convert';

MenuModel menuModelFromMap(String str) => MenuModel.fromMap(json.decode(str));

String menuModelToMap(MenuModel data) => json.encode(data.toMap());

class MenuModel {
  List<Category> categories;

  MenuModel({
    required this.categories,
  });

  factory MenuModel.fromMap(Map<String, dynamic> json) => MenuModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
  };
}

class Category {
  int id;
  String name;
  List<Dish> dishes;

  Category({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "dishes": List<dynamic>.from(dishes.map((x) => x.toMap())),
  };
}

class Dish {
  int id;
  String name;
  String price;
  Currency currency;
  int calories;
  String description;
  List<Addon> addons;
  String imageUrl;
  bool customizationsAvailable;
  bool isVeg;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.addons,
    required this.imageUrl,
    required this.customizationsAvailable,
    required this.isVeg,
  });

  factory Dish.fromMap(Map<String, dynamic> json) => Dish(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    currency: currencyValues.map[json["currency"]]!,
    calories: json["calories"],
    description: json["description"],
    addons: List<Addon>.from(json["addons"].map((x) => Addon.fromMap(x))),
    imageUrl: json["image_url"],
    customizationsAvailable: json["customizations_available"],
    isVeg: json["is_veg"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "price": price,
    "currency": currencyValues.reverse[currency],
    "calories": calories,
    "description": description,
    "addons": List<dynamic>.from(addons.map((x) => x.toMap())),
    "image_url": imageUrl,
    "customizations_available": customizationsAvailable,
    "is_veg": isVeg,
  };
}

class Addon {
  int id;
  String name;
  String price;

  Addon({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Addon.fromMap(Map<String, dynamic> json) => Addon(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "price": price,
  };
}

enum Currency {
  indianRupee
}

final currencyValues = EnumValues({
  "INR": Currency.indianRupee
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
