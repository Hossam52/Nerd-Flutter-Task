import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class RecipeRow extends StatelessWidget {
  final IconData icon;
  final String data;
  const RecipeRow({
    Key? key,
    required this.icon,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17.sp),
        SizedBox(width: 8.w),
        TextWidget(label: data, fontSize: 16.sp),
      ],
    );
  }
}
