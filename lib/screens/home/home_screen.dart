import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_states.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_states.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/screens/auth/login_screen.dart';
import 'package:nerd_hossam_task/shared/methods.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/color_manager.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/values.dart';
import 'package:nerd_hossam_task/widgets/default_loader.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

import 'widgets/recipe_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    RecipeCubit.instance(context).getRecipies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(label: "Recipes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => RecipeCubit.instance(context).getRecipies(),
          )
        ],
      ),
      floatingActionButton: AuthBlocConsumer(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Methods.navigateTo(context, const LoginScreen(),
                isReplacement: true);
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              RecipeCubit.instance(context).clearData();
              AuthCubit.instance(context).logout();
            },
            tooltip: 'Logout',
            backgroundColor: ColorManager.error,
            child: const Icon(Icons.exit_to_app),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.s12.w),
        child: RecipeBlocBuilder(
          builder: (context, state) {
            final cubit = RecipeCubit.instance(context);
            final recipes = cubit.cachedRecipes;
            if (state is GetRecipiesLoadingState) {
              return const DefaultLoader();
            } else if (state is GetRecipiesErrorState) {
              return Text('Error: ${state.error}');
            }
            return Column(
              children: [
                if (cubit.favoriteRecipes.isNotEmpty)
                  Flexible(
                    flex: 2,
                    child: _RecipeListSection(
                      title: 'My Favorite Recipes',
                      recipes: cubit.favoriteRecipes,
                      isVertical: false,
                      crossCount: 1,
                    ),
                  ),
                Expanded(
                  flex: 3,
                  child: _RecipeListSection(
                      title: 'Today\'s Recipe Selection', recipes: recipes),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecipeListSection extends StatelessWidget {
  const _RecipeListSection({
    required this.recipes,
    required this.title,
    this.isVertical = true,
    this.crossCount = 2,
  });
  final String title;
  final List<Recipe> recipes;
  final bool isVertical;
  final int crossCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
            label: '$title:', fontSize: 18.sp, fontWeight: FontWeight.bold),
        SizedBox(height: AppSize.s12.h),
        Expanded(child: _RecipesList(recipes, isVertical, crossCount)),
      ],
    );
  }
}

class _RecipesList extends StatelessWidget {
  final List<Recipe> recipes;
  final bool isVertical;
  final int crossCount;
  const _RecipesList(this.recipes, this.isVertical, this.crossCount);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        childAspectRatio: 0.8,
        mainAxisSpacing: AppSize.s12.w,
        crossAxisSpacing: AppSize.s12.w,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) => RecipeItem(recipe: recipes[index]),
    );
  }
}
