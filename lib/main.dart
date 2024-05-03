import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nerd_hossam_task/bloc_observer.dart';
import 'package:nerd_hossam_task/constants/constants.dart';
import 'package:nerd_hossam_task/cubits/app_cubit/app_cubit.dart';
import 'package:nerd_hossam_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:nerd_hossam_task/cubits/recipe_cubit/recipe_cubit.dart';
import 'package:nerd_hossam_task/screens/auth/login_screen.dart';
import 'package:nerd_hossam_task/shared/network/services/local/cache_helper.dart';
import 'package:nerd_hossam_task/shared/presentation/resourses/theme_manager.dart';
import 'package:nerd_hossam_task/shared/service_locator.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  HttpOverrides.global = MyHttpOverrides();

  await CacheHelper.init();
  Constants.token = await CacheHelper.getData(key: 'token');
  Bloc.observer = MyBlocObserver();

  setupLocator();

  runApp(const MyApp());
  // runApp(IAPTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context) => locator.get<RecipeCubit>()),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'NERD',

          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.light(),

          theme: ThemeData.dark(),
          locale: const Locale('en', 'us'),
          //           locale: const Locale('ar'),
          // supportedLocales: const [
          //   Locale('ar'),
          //   Locale('en'),
          // ],
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          // ],
          //  ThemeData(
          //     scaffoldBackgroundColor: scaffoldBackgroundColor,
          //     appBarTheme: AppBarTheme(
          //       color: cardColor,
          //     )),

          // home: const ConfirmPhoneScreen(phoneNumber: '+201115425561'),
          home: const LoginScreen(),
          // home: Constants.token != null
          //     ? const HomeScreen()
          //     : const OnBoardingScreen(),
        ),
      ),
    );
  }
}
