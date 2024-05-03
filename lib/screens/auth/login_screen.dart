import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_states.dart';
import 'package:nerd_hossam_task/screens/auth/widgets/remember_me_widget.dart';
import 'package:nerd_hossam_task/screens/home/home_screen.dart';
import 'package:nerd_hossam_task/shared/methods.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/color_manager.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/font_manager.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/styles_manager.dart';
import 'package:nerd_hossam_task/widgets/custom_button.dart';
import 'package:nerd_hossam_task/widgets/default_loader.dart';
import 'package:nerd_hossam_task/widgets/text_widget.dart';
import 'widgets/auth_text_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_validators/queen_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordSecured = true;
  @override
  void initState() {
    _loadCachedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TextWidget(label: 'NERD\'s Task '),
        ),
        body: AuthBlocConsumer(listener: (context, state) {
          if (state is LoginSuccessState) {}
          if (state is LoginErrorState) {
            Methods.showErrorSnackBar(context, state.error);
          }
        }, builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            label: 'Login',
                            fontSize: FontSize.s24,
                            color: ColorManager.white.withOpacity(0.8)),
                        SizedBox(height: 30.h),
                        SizedBox(
                          height: 70.h,
                          child: AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              displayFullTextOnTap: true,
                              // totalRepeatCount: 1,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Welcome again in NERD company',
                                  speed: const Duration(milliseconds: 100),
                                  textStyle: getRegularStyle(
                                      fontSize: FontSize.s24,
                                      color:
                                          ColorManager.white.withOpacity(0.8)),
                                ),
                              ]),
                        ),
                        SizedBox(height: 50.h),
                        AuthTextField(
                            label: 'Email',
                            hint: 'Enter Email ',
                            validationRules: const [
                              IsEmail('Email is not valid'),
                            ],
                            controller: emailController),
                        StatefulBuilder(builder: (context, setState) {
                          return AuthTextField(
                              label: 'Password',
                              hint: 'Enter you password',
                              password: isPasswordSecured,
                              onIconPressed: () {
                                setState(() {
                                  log(isPasswordSecured.toString());
                                  isPasswordSecured = !isPasswordSecured;
                                });
                              },
                              validationRules: const [],
                              controller: passwordController);
                        }),
                        const RememberMeWidget(),
                        if (kDebugMode)
                          TextButton(
                              onPressed: () async {
                                await AuthCubit.instance(context).login(
                                    'hossam.hassan.fcis@gmail.com', '123456');
                              },
                              child: const Text('Test')),
                        const SizedBox(height: 50),
                        if (state is LoginLoadingState)
                          const DefaultLoader()
                        else
                          CustomButton(
                            text: 'Login',
                            onPressed: () {
                              Methods.navigateTo(context, const HomeScreen(),
                                  isReplacement: true);
                              Methods.showSuccessSnackBar(
                                  context, 'Welcome NERD\'s user');
                              if (formKey.currentState!.validate()) {
                                AuthCubit.instance(context).login(
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            backgroundColor: ColorManager.accentColor,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _loadCachedData() async {
    log('${'-' * 20}Begin load Cached data');
    final instance = AuthCubit.instance(context);
    await AuthCubit.instance(context).loadCahcedRemember();
    emailController.text = instance.cachedEmail;
    passwordController.text = instance.cachedPassword;
    log('${'-' * 20}Endload Cached data');
  }
}
