import 'package:get_it/get_it.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/shared/network/services/auth_services.dart';
import 'package:nerd_hossam_task/shared/network/services/recipe_service_contract.dart';
import 'package:nerd_hossam_task/shared/network/services/remote/app_dio_helper.dart';
import 'package:nerd_hossam_task/shared/network/services/remote/remote_recipe_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<AppDioHelper>(() => AppDioHelper());
  locator.registerLazySingleton<AuthServices>(() => AuthServices());

  locator.registerLazySingleton<RecipeServiceContract>(
      () => RemoteRecipeService(),
      instanceName: 'RemoteRecipe');

  // Register cubits
  locator.registerFactory(() => RecipeCubit(
      remoteService:
          locator<RecipeServiceContract>(instanceName: 'RemoteRecipe')));
}
