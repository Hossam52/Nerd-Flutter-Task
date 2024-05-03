import 'dart:convert';

class Recipe {
  final String id;
  final String name;
  final String time;
  final String image;
  final List<String> weeks;
  final String fats;
  final String carbos;
  final String fibers;
  final double? rating;
  final String country;
  final int? ratings;
  final String calories;
  final String headline;
  final List<String> keywords;
  final List<String> products;
  final String proteins;
  int favorites;
  final int difficulty;
  final String description;
  final bool highlighted;
  final List<String> ingredients;
  final List<String> deliverableIngredients;
  final List<String> undeliverableIngredients;

  Recipe({
    required this.id,
    required this.name,
    required this.time,
    required this.image,
    required this.weeks,
    required this.fats,
    required this.carbos,
    required this.fibers,
    this.rating,
    required this.country,
    this.ratings,
    required this.calories,
    required this.headline,
    required this.keywords,
    required this.products,
    required this.proteins,
    required this.favorites,
    required this.difficulty,
    required this.description,
    required this.highlighted,
    required this.ingredients,
    required this.deliverableIngredients,
    required this.undeliverableIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        name: json['name'],
        time: json['time'],
        image: json['image'],
        weeks: List<String>.from(json['weeks']),
        fats: json['fats'],
        carbos: json['carbos'],
        fibers: json['fibers'] ?? "",
        rating: json['rating']?.toDouble(),
        country: json['country'],
        ratings: json['ratings'],
        calories: json['calories'],
        headline: json['headline'],
        keywords: List<String>.from(json['keywords']),
        products: List<String>.from(json['products']),
        proteins: json['proteins'],
        favorites: json['favorites'],
        difficulty: json['difficulty'],
        description: json['description'],
        highlighted: json['highlighted'],
        ingredients: List<String>.from(json['ingredients']),
        deliverableIngredients:
            List<String>.from(json['deliverable_ingredients']),
        undeliverableIngredients:
            List<String>.from(json['undeliverable_ingredients']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'time': time,
        'image': image,
        'weeks': weeks,
        'fats': fats,
        'carbos': carbos,
        'fibers': fibers,
        'rating': rating,
        'country': country,
        'ratings': ratings,
        'calories': calories,
        'headline': headline,
        'keywords': keywords,
        'products': products,
        'proteins': proteins,
        'favorites': favorites,
        'difficulty': difficulty,
        'description': description,
        'highlighted': highlighted,
        'ingredients': ingredients,
        'deliverableIngredients': deliverableIngredients,
        'undeliverableIngredients': undeliverableIngredients,
      };
}

List<Recipe> parseRecipes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
}
