// lib/services/remote/remote_recipe_service.dart

import 'package:dio/dio.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/shared/network/services/remote/app_dio_helper.dart';
import 'package:nerd_hossam_task/shared/service_locator.dart';
import '../recipe_service_contract.dart';

class RemoteRecipeService implements RecipeServiceContract {
  final dioHelper = locator.get<AppDioHelper>();

  RemoteRecipeService();

  @override
  Future<List<Recipe>> fetchRecipes() async {
    Response response = await dioHelper.getData(url: '43427003d33f1f6b51cc');
    return (response.data as List)
        .map((data) => Recipe.fromJson(data))
        .toList();
  }
}
