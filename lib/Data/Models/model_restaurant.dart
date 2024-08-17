class ModelRestaurants {
  String id;
  String name;
  String description;
  String imageUrl;
  String city;
  double rating;
  ModelMenus menus;

  ModelRestaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory ModelRestaurants.fromJson(Map<String, dynamic> input) => ModelRestaurants(
        id: input['id'],
        name: input['name'],
        description: input['description'],
        imageUrl: input['pictureId'],
        city: input['city'],
        rating: input['rating']?.toDouble(),
        menus: ModelMenus.fromJson(input['menus']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': imageUrl,
        'city': city,
        'rating': rating,
        'menus': menus.toJson(),
      };
}

class ModelMenus {
  List<Menu> foods;
  List<Menu> drinks;

  ModelMenus({
    required this.foods,
    required this.drinks,
  });

  factory ModelMenus.fromJson(Map<String, dynamic> input) => ModelMenus(
        foods: List<Menu>.from(input['foods'].map((x) => Menu.fromJson(x))),
        drinks: List<Menu>.from(input['drinks'].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'foods': List<dynamic>.from(foods.map((x) => x.toJson())),
        'drinks': List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Menu {
  String name;

  Menu({
    required this.name,
  });

  factory Menu.fromJson(Map<String, dynamic> input) => Menu(
        name: input['name'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
