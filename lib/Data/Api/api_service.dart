import 'dart:convert';

import 'package:restaurant_app/Data/Models/model_responses.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";

  static const String imageUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";
  String getImageUrl() {
    return imageUrl;
  }

  Future<ModelResponseList> getRestaurantList() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return ModelResponseList.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load restaurants list");
    }
  }

  Future<ModelResponseList> searchRestaurant(String searchQuery) async {
    final response =
        await http.get(Uri.parse("$baseUrl/search?q=$searchQuery"));
    if (response.statusCode == 200) {
      return ModelResponseList.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load restaurants list");
    }
  }

  Future<ModelResponseDetail> getDetailRestaurant(String restaurantId) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$restaurantId"));
    if (response.statusCode == 200) {
      return ModelResponseDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load detail restaurant");
    }
  }

  Future<ModelResponseDetail> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$baseUrl/review"),
      body: {
        "id": id,
        "name": name,
        "review": review,
      },
    );
    if (response.statusCode == 200) {
      return ModelResponseDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load restaurant's review");
    }
  }
}
