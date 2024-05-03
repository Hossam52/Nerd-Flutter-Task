import 'package:nerd_hossam_task/models/recipe_model.dart';

abstract class RecipeStates {}

abstract class RecipeSuccessState extends RecipeStates {
  final String message;
  RecipeSuccessState([this.message = ""]);
}

abstract class RecipeErrorState extends RecipeStates {
  final String error;
  RecipeErrorState(this.error);
}

class IntitalRecipeState extends RecipeStates {}
//

//GetRecipies online fetch data
class GetRecipiesLoadingState extends RecipeStates {}

class GetRecipiesSuccessState extends RecipeSuccessState {
  final List<Recipe> recipes;
  GetRecipiesSuccessState(this.recipes, [super.message = ""]);
}

class GetRecipiesErrorState extends RecipeErrorState {
  GetRecipiesErrorState(super.error);
}

//ToggleFavorite online fetch data
class ToggleFavoriteLoadingState extends RecipeStates {}

class ToggleFavoriteSuccessState extends RecipeSuccessState {
  ToggleFavoriteSuccessState([super.message = ""]);
}

class ToggleFavoriteErrorState extends RecipeErrorState {
  ToggleFavoriteErrorState(super.error);
}
