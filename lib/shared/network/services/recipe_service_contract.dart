import 'package:nerd_hossam_task/models/recipe_model.dart';

abstract class RecipeServiceContract {
  Future<List<Recipe>> fetchRecipes();
}
