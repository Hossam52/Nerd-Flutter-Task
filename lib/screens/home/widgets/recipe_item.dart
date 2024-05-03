import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/screens/recipes/recipe_details/recipe_details_screen.dart';
import 'package:nerd_hossam_task/shared/methods.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/color_manager.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/values.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  const RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Methods.navigateTo(context, RecipeDetailsScreen(recipe: recipe));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: _buildRecipeImage(),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(AppSize.s8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        label: recipe.name,
                        maxLines: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                    SizedBox(height: AppSize.s8.h),
                    Expanded(
                      child: Text(recipe.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp)),
                    ),
                    SizedBox(height: AppSize.s8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _recipeDuration(),
                        _recipeRating(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _recipeRating() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 15.sp),
        TextWidget(label: '${recipe.rating ?? 0}/5', fontSize: 12.sp),
      ],
    );
  }

  Row _recipeDuration() {
    return Row(
      children: [
        Icon(Icons.timer, size: 20.sp),
        Text(Methods.formatDuration(recipe.time),
            style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildRecipeImage() {
    return Hero(
      tag: 'recipe_image_${recipe.id}',
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.image),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s14),
                topRight: Radius.circular(AppSize.s14),
              ),
            ),
          ),
          buildFavoriteIcon(),
        ],
      ),
    );
  }

  Widget buildFavoriteIcon() {
    return RecipeBlocBuilder(
      builder: (context, state) {
        final isFavorite =
            RecipeCubit.instance(context).isRecipeFavorite(recipe.id);
        return IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: ColorManager.favoriteColor,
          onPressed: () => toggleFavorite(context, !isFavorite),
        );
      },
    );
  }

  void toggleFavorite(BuildContext context, bool newValue) {
    RecipeCubit.instance(context).toggleFavorite(recipe.id, newValue);
  }
}
