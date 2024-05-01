import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/assets_manager.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/color_manager.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class EmptyContentWidget extends StatelessWidget {
  const EmptyContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.emptyData,
            color: ColorManager.accentColor.withOpacity(0.7),
            width: width * 0.4,
            height: width * 0.4,
          ),
          SizedBox(height: 20.h),
          const TextWidget(
            label: 'No cotent found here!',
          ),
        ],
      ),
    );
  }
}
