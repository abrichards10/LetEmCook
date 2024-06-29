import 'dart:core';

class RecipeInfo {
  final String name;
  final String pictureUrl;
  final String description;

  RecipeInfo({
    required this.name,
    required this.pictureUrl,
    required this.description,
  });

  // Optional: Convert a Recipe object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pictureUrl': pictureUrl,
      'description': description,
    };
  }
}
