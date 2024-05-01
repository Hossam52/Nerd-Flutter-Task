import 'package:flutter/material.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: const TextWidget(
          label: 'Error happened please try again',
        ),
      ),
    );
  }
}
