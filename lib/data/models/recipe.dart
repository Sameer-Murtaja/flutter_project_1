class Recipe {
  int id;
  String name;
  String image;
  String caloriesPerServing;
  String time;

  List<String> ingridients;
  List<String> instructions;
  List<String> mealType;

  Recipe({
    this.id = 0,
    required this.name,
    required this.image,
    required this.caloriesPerServing,
    required this.time,
    required this.ingridients,
    required this.instructions,
    required this.mealType,
  });

  Recipe.fromJson(Map<dynamic, dynamic> map)
    : id = map['id'],
      name = map['name'],
      image = map['image'],
      caloriesPerServing = map['caloriesPerServing'].toString(),
      time = map['prepTimeMinutes'].toString(),
      ingridients = List<String>.from(map['ingredients']),
      instructions = List<String>.from(map['instructions']),
      mealType = List<String>.from(map['mealType']);
}
