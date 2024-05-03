import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //Main Colors
      scaffoldBackgroundColor: ColorManager.primary,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme:
          ColorScheme.fromSwatch(accentColor: ColorManager.accentColor),
      splashColor: ColorManager.primaryOpacity70,
      //Card Theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4,
        shadowColor: ColorManager.grey,
      ),
      //AppBar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        // elevation: 0,
        backgroundColor: ColorManager.primary,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularStyle(fontSize: FontSize.s16),
      ),
      //Button Theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.white,
            ),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12))),
      ),
      // TextTheme
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          titleMedium: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          bodySmall: getMediumStyle(
              color: ColorManager.cpationColor, fontSize: FontSize.s14),
          bodyLarge: getRegularStyle(color: ColorManager.grey)),
      //Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.grey1),
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        fillColor: ColorManager.fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
      fontFamily: FontConstants.fontFamily);
}

ThemeData getDarkApplicationTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorManager.primary,

    //AppBar
    appBarTheme:
        AppBarTheme(centerTitle: true, backgroundColor: ColorManager.primary),
    //Button Theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            color: ColorManager.white,
          ),
          backgroundColor: ColorManager.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
    // TextTheme
    textTheme: TextTheme(
        titleLarge: TextStyle(
            color: ColorManager.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: ColorManager.lightGrey,
            fontSize: 14,
            fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(
            color: ColorManager.cpationColor,
            fontSize: 14,
            fontWeight: FontWeight.normal),
        bodyLarge: TextStyle(
            color: ColorManager.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal)),
    //Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      hintStyle: TextStyle(color: ColorManager.grey),
      labelStyle: TextStyle(color: ColorManager.darkGrey),
      errorStyle: TextStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      fillColor: ColorManager.fillColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
