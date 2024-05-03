import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class RecipeSectionInfo extends StatelessWidget {
  final String description;
  final List<Widget> children;

  const RecipeSectionInfo(
      {Key? key, required this.description, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(description: description),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...children.map((e) {
                return Column(
                  children: [
                    e,
                    SizedBox(height: 10.h),
                  ],
                );
              }).toList(),
            ],
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return TextWidget(
        label: '$description:', fontSize: 18.sp, fontWeight: FontWeight.bold);
  }
}
