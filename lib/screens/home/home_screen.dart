import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/Recipe_states.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
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
      body: Padding(
        padding: EdgeInsets.all(AppSize.s12.w),
        child: RecipeBlocBuilder(
          builder: (context, state) {
            if (state is GetRecipiesLoadingState) {
              return const DefaultLoader();
            } else if (state is GetRecipiesSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      label: 'Today\'s Recipe Selection:',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: AppSize.s12.h),
                  Expanded(child: _RecipesList(state.recipes)),
                ],
              );
            } else if (state is GetRecipiesErrorState) {
              return Text('Error: ${state.error}');
            }
            return const Center(child: Text('Welcome to the Recipes App!'));
          },
        ),
      ),
    );
  }
}

class _RecipesList extends StatelessWidget {
  final List<Recipe> recipes;
  const _RecipesList(this.recipes);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: AppSize.s12.w,
        crossAxisSpacing: AppSize.s12.w,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) => RecipeItem(recipe: recipes[index]),
    );
  }
}
