import 'package:flutter/material.dart';

const Color oziNavyBlueLight = Color(0xFF3B394F);
const Color oziNavyBlueDark = Color(0xFF252331);
const Color oziSkyBlueLight = Color(0xFF3484FB);
const Color oziSkyBlueDark = Color(0xFF1C55FC);
const Color oziAviRedBGLight = Color(0xFFFFB5B5);
const Color oziAviGreenBGLight = Color(0xFFB5FFB5);
const Color oziAviBlueBGLight = Color(0xFFB5B5FF);
const Color oziAviRedBGDark = Color(0xFF680000);
const Color oziAviGreenBGDark = Color(0xFF006800);
const Color oziAviBlueBGDark = Color(0xFF000068);
const Color oziGrey1 = Color(0xFFE6E6E6);
const Color oziGrey2 = Color(0xFFCCCCCC);
const Color oziGreenLight = Color(0xFF00FF00);
const Color oziGreenDark = Color(0xFF009A00);

const ColorScheme oziDarkColorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: oziSkyBlueDark,
    onPrimary: Colors.white,
    secondary: oziSkyBlueLight,
    onSecondary: Colors.white,
    tertiary: oziGreenDark,
    onTertiary: Colors.white,
    onError: Colors.white,
    background: oziNavyBlueDark,
    onBackground: Colors.white,
    surface: oziNavyBlueLight,
    onSurface: Colors.white,
);

const ColorScheme oziLightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: oziSkyBlueDark,
    onPrimary: Colors.white,
    secondary: oziSkyBlueLight,
    onSecondary: Colors.white,
    tertiary: oziGreenDark,
    onTertiary: Colors.white,
    onError: Colors.white,
    background: oziGrey1,
    onBackground: Colors.black,
    surface: oziGrey2,
    onSurface: Colors.black,
);


const TextTheme oziTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'ErasB',
        fontSize: 26
    ),

    titleMedium: TextStyle(
        fontFamily: 'ErasB',
        fontSize: 22
    ),

    bodyLarge: TextStyle(
        fontFamily: 'ErasB',
        fontSize: 18
    ),

    bodyMedium: TextStyle(
        fontFamily: 'ErasR',
        fontSize: 16
    ),

    labelLarge: TextStyle(
        fontFamily: 'ErasL',
        fontSize: 12
    ),

    labelMedium : TextStyle(
        fontFamily : 'ErasL',
        fontSize : 12
    ),

    labelSmall : TextStyle(
        fontFamily : 'ErasL',
        fontSize : 10
    )
);
