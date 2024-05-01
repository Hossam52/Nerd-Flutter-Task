import 'package:flutter/material.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_states.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/color_manager.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({super.key});

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  @override
  Widget build(BuildContext context) {
    return AuthBlocBuilder(
        buildWhen: (previous, current) => current is ChangeIsRememberedState,
        builder: (context, state) {
          final cubit = AuthCubit.instance(context);
          return InkWell(
            onTap: () {
              cubit.onChangeCheckMe(!cubit.isRememberd);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: cubit.isRememberd,
                  onChanged: cubit.onChangeCheckMe,
                  fillColor: MaterialStatePropertyAll(ColorManager.accentColor),
                ),
                const TextWidget(label: 'Remember me?'),
              ],
            ),
          );
        });
  }
}
