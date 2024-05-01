import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/shared/network/services/recipe_service_contract.dart';
import './Recipe_states.dart';

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
  List<Recipe> get cachedRecipes =>
      _cachedRecipes; // Getter to access the cached recipes

  Future<void> getRecipies() async {
    try {
      emit(GetRecipiesLoadingState());
      if (_cachedRecipes.isNotEmpty) {
        emit(GetRecipiesSuccessState(
            _cachedRecipes)); // Emit loaded state with cached recipes if available
        return;
      }
      final recipes = await remoteService.fetchRecipes();

      _cachedRecipes = recipes;
      emit(GetRecipiesSuccessState(_cachedRecipes));
    } catch (e) {
      emit(GetRecipiesErrorState(e.toString()));
    }
  }
}
