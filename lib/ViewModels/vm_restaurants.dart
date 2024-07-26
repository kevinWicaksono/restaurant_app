class VmRestaurants {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String city;
  final double rating;
  // final List menus;

  VmRestaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.city,
    required this.rating,
    // required this.menus,
  });

  factory VmRestaurants.fromJson(Map<String, dynamic> input) => VmRestaurants(
        id: input['id'],
        name: input['name'],
        description: input['description'],
        imageUrl: input['pictureId'],
        city: input['city'],
        rating: input['rating'] * 1.0,
        // menus: input['menus'],
      );
}
