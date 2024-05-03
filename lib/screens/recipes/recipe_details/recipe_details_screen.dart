import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/models/recipe_model.dart';
import 'package:nerd_hossam_task/shared/methods.dart';
import 'package:nerd_hossam_task/widgets/custom_image.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

import 'widgets/recipe_row.dart';
import 'widgets/recipe_section_info.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(label: recipe.name),
        actions: [
          TextWidget(
            label: '(${recipe.favorites})',
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 14.sp,
          ),
          IconButton(
            icon: Icon(
                recipe.highlighted ? Icons.favorite : Icons.favorite_border),
            onPressed: () => toggleFavorite(recipe.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _recipeImage(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  _headline(),
                  SizedBox(height: 10.h),
                  _displayRating(),
                  const Divider(),
                  _GeneralInformationWidget(recipe: recipe),
                  SizedBox(height: 10.h),
                  _NutritionalInfo(recipe: recipe),
                  const Divider(),
                  RecipeSectionInfo(
                    description: 'Description',
                    children: [
                      TextWidget(label: recipe.description, fontSize: 14.sp),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (recipe.ingredients.isNotEmpty) ...[
                    RecipeSectionInfo(
                        description: 'Ingredients',
                        children: recipe.ingredients
                            .map(
                              (e) => ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.check_circle_outline,
                                    size: 20.sp),
                                title: TextWidget(label: e, fontSize: 14.sp),
                              ),
                            )
                            .toList())
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayRating() {
    return recipe.rating != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  label: 'Rating: (${recipe.ratings})',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
              Expanded(
                child: RatingBar.builder(
                  itemSize: 20.w,
                  initialRating: recipe.rating!,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print('Rating is $rating');
                  },
                  ignoreGestures:
                      true, // Make this false to allow users to rate
                ),
              ),
            ],
          )
        : Container();
  }

  void toggleFavorite(String id) {
    // Implement your favorite toggle logic here
  }

  TextWidget _title() {
    return TextWidget(
        label: recipe.name, fontSize: 22.sp, fontWeight: FontWeight.bold);
  }

  TextWidget _headline() {
    return TextWidget(
      label: recipe.headline,
      fontSize: 14.sp,
      color: Colors.grey,
    );
  }

  Hero _recipeImage() {
    return Hero(
      tag: 'recipe_image_${recipe.id}',
      child: CustomImage(
        imagePath: recipe.image,
        width: double.infinity,
        height: 200.h,
      ),
    );
  }
}

class _GeneralInformationWidget extends StatelessWidget {
  const _GeneralInformationWidget({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return RecipeSectionInfo(
      description: 'General Information',
      children: [
        RecipeRow(icon: Icons.timer, data: Methods.formatDuration(recipe.time)),
        RecipeRow(icon: Icons.fireplace, data: recipe.calories),
        RecipeRow(
            icon: Icons.account_balance_wallet,
            data: 'Country: ${recipe.country}'),
        RecipeRow(
            icon: Icons.dashboard_customize,
            data: 'Difficulty: ${recipe.difficulty}'),
      ],
    );
  }
}

class _NutritionalInfo extends StatelessWidget {
  final Recipe recipe;
  const _NutritionalInfo({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeSectionInfo(
      description: 'Nutritional Information',
      children: [
        RecipeRow(icon: Icons.fastfood, data: 'Fats: ${recipe.fats}'),
        RecipeRow(icon: Icons.line_weight, data: 'Carbs: ${recipe.carbos}'),
        RecipeRow(
            icon: Icons.fitness_center, data: 'Proteins: ${recipe.proteins}'),
        RecipeRow(
            icon: Icons.fiber_manual_record, data: 'Fibers: ${recipe.fibers}'),
      ],
    );
  }
}
