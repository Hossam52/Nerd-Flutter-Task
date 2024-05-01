import 'package:flutter/material.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/Recipe_states.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/widgets/custom_image.dart';
import 'package:nerd_hossam_task/widgets/default_loader.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

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
        title: const TextWidget(label: "Home"),
      ),
      body: RecipeBlocBuilder(
        builder: (context, state) {
          if (state is GetRecipiesLoadingState) {
            return const DefaultLoader();
          } else if (state is GetRecipiesSuccessState) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.recipes.length,
              itemBuilder: (context, index) => ListTile(
                title: RecipeItem(recipe: state.recipes[index]),
              ),
            );
          } else if (state is GetRecipiesErrorState) {
            return Text('Error: ${state.error}');
          }
          return Center(child: Text('Welcome to the Recipes App!'));
        },
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  const RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(imagePath: recipe.image),
        Text(recipe.name),
      ],
    );
  }
}
