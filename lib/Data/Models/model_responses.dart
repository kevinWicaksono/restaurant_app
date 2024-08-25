class ModelResponseList {
  bool error;
  String message;
  int count;
  List<ModelRestaurant> restaurants;

  ModelResponseList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(
            restaurants.map((restaurant) => restaurant.toJson()))
      };

  factory ModelResponseList.fromJson(Map<String, dynamic> input) =>
      ModelResponseList(
        error: input["error"],
        message: input["message"] ?? "",
        count: input["count"] ?? 0,
        restaurants: List<ModelRestaurant>.from((input["restaurants"] as List)
            .map((restaurant) => ModelRestaurant.fromJson(restaurant))),
      );
}

class ModelRestaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  ModelRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  factory ModelRestaurant.fromJson(Map<String, dynamic> input) =>
      ModelRestaurant(
        id: input["id"],
        name: input["name"],
        description: input["description"],
        pictureId: input["pictureId"],
        city: input["city"],
        rating: input["rating"]?.toDouble(),
      );
}

class ModelResponseDetail {
  bool error;
  String message;
  ModelDetailRestaurant restaurant;

  ModelResponseDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };

  factory ModelResponseDetail.fromJson(Map<String, dynamic> input) =>
      ModelResponseDetail(
        error: input["error"],
        message: input["message"] ?? "",
        restaurant: ModelDetailRestaurant.fromJson(input["restaurant"]),
      );
}

class ModelDetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<ModelCategories> categories;
  ModelMenu menus;
  double rating;
  List<ModelCustomerReview> customerReviews;

  ModelDetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories":
            List<dynamic>.from(categories.map((category) => category.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews": List<dynamic>.from(
            customerReviews.map((customerReview) => customerReview.toJson())),
      };

  factory ModelDetailRestaurant.fromJson(Map<String, dynamic> input) =>
      ModelDetailRestaurant(
        id: input["id"],
        name: input["name"],
        description: input["description"],
        city: input["city"],
        address: input["address"],
        pictureId: input["pictureId"],
        categories: List<ModelCategories>.from((input["categories"] as List)
            .map((category) => ModelCategories.fromJson(category))),
        menus: ModelMenu.fromJson(input["menus"]),
        rating: input["rating"]?.toDouble(),
        customerReviews: List<ModelCustomerReview>.from(
            (input["customerReviews"] as List).map((customerReview) =>
                ModelCustomerReview.fromJson(customerReview))),
      );
}

class ModelCategories {
  String name;

  ModelCategories({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  factory ModelCategories.fromJson(Map<String, dynamic> input) =>
      ModelCategories(
        name: input["name"],
      );
}

class ModelMenu {
  List<ModelMenuName> foods;
  List<ModelMenuName> drinks;

  ModelMenu({
    required this.foods,
    required this.drinks,
  });

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((food) => food.toJson())),
        "drinks": List<dynamic>.from(drinks.map((drink) => drink.toJson())),
      };

  factory ModelMenu.fromJson(Map<String, dynamic> input) => ModelMenu(
        foods: List<ModelMenuName>.from((input["foods"] as List)
            .map((food) => ModelMenuName.fromJson(food))),
        drinks: List<ModelMenuName>.from((input["drinks"] as List)
            .map((drink) => ModelMenuName.fromJson(drink))),
      );
}

class ModelMenuName {
  String name;

  ModelMenuName({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  factory ModelMenuName.fromJson(Map<String, dynamic> input) => ModelMenuName(
        name: input["name"],
      );
}

class ModelResponseReview {
  bool error;
  String message;
  List<ModelCustomerReview> customerReviews;

  ModelResponseReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ModelResponseReview.fromJson(Map<String, dynamic> json) =>
      ModelResponseReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<ModelCustomerReview>.from(json["customerReviews"]
            .map((x) => ModelCustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class ModelCustomerReview {
  String name;
  String review;
  String date;

  ModelCustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };

  factory ModelCustomerReview.fromJson(Map<String, dynamic> input) =>
      ModelCustomerReview(
        name: input["name"],
        review: input["review"],
        date: input["date"],
      );
}
