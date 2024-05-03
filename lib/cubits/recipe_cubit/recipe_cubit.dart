import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nerd_hossam_task/constants/constants.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_states.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/shared/network/services/recipe_service_contract.dart';

//Bloc builder and bloc consumer methods
typedef RecipeBlocBuilder = BlocBuilder<RecipeCubit, RecipeStates>;
typedef RecipeBlocConsumer = BlocConsumer<RecipeCubit, RecipeStates>;

//
class RecipeCubit extends Cubit<RecipeStates> {
  final RecipeServiceContract remoteService;
  List<Recipe> _cachedRecipes = []; // Cache for recipes

  RecipeCubit({required this.remoteService}) : super(IntitalRecipeState());

  static RecipeCubit instance(BuildContext context) =>
      BlocProvider.of<RecipeCubit>(context);

  final Box<bool> _favoritesBox = Hive.box<bool>(Constants.favoriteBox);

  List<Recipe> get cachedRecipes =>
      _cachedRecipes; // Getter to access the cached recipes

  Future<void> getRecipies() async {
    try {
      emit(GetRecipiesLoadingState());
      // if (_cachedRecipes.isNotEmpty) {
      //   emit(GetRecipiesSuccessState(
      //       _cachedRecipes)); // Emit loaded state with cached recipes if available
      //   return;
      // }
      final recipes = await remoteService.fetchRecipes();

      _cachedRecipes = recipes;
      emit(GetRecipiesSuccessState(_cachedRecipes));
    } catch (e) {
      emit(GetRecipiesErrorState(e.toString()));
    }
  }

  List<Recipe> get favoriteRecipes =>
      _cachedRecipes.where((recipe) => isRecipeFavorite(recipe.id)).toList();
  bool isRecipeFavorite(String recipeId) =>
      _favoritesBox.get(recipeId, defaultValue: false) ?? false;

  Future<void> toggleFavorite(String recipeId, bool isFavorite) async {
    try {
      emit(ToggleFavoriteLoadingState());
      await _favoritesBox.put(recipeId, isFavorite);
      final index =
          _cachedRecipes.indexWhere((recipe) => recipe.id == recipeId);
      if (index != -1) {
        _cachedRecipes[index].favorites += isFavorite ? 1 : -1;
      }
      emit(ToggleFavoriteSuccessState());
    } catch (e) {
      emit(ToggleFavoriteErrorState(e.toString()));
    }
  }

  void clearData() {
    _cachedRecipes.clear();
  }
}
