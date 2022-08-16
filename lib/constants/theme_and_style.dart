import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme defoultTextTheme = TextTheme(
  caption: GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 12),
  button: GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 14),
  subtitle1: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 16),
  subtitle2: GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 14),
  bodyText1: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 16),
  bodyText2: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 14),
  headline6: GoogleFonts.quicksand(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: const Color(0xFF140b24),
  ),
  headline5: GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 24),
  headline4: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 34),
  headline3: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 48),
  headline2: GoogleFonts.quicksand(fontWeight: FontWeight.w200, fontSize: 60),
  headline1: GoogleFonts.quicksand(fontWeight: FontWeight.w200, fontSize: 96),
);

ElevatedButtonThemeData defoultElevatedButton = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);

class DefaultColorsPalette {
  static const MaterialColor defoultColorSwatch = MaterialColor(
    0xFF02735E,
    <int, Color>{
      50: Color(0xFFcce3de), //10%
      100: Color(0xff99c7be), //20%
      200: Color(0xff67ab9e), //30%
      300: Color(0xff348f7e), //40%
      400: Color(0xff02735e), //50%
      500: Color(0xff015c4b), //60%
      600: Color(0x0ff14538), //70%
      700: Color(0xff002e25), //80%
      800: Color(0xff001712), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const ColorScheme defoultColorScheme = ColorScheme.light(
    primary: Color(0xFF02735E),
    primaryContainer: Color(0xFFcce3de),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF140b24),
    secondary: Color(0xFF034159),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFccd9dd),
    tertiary: Color(0xFF0CF25D),
    onTertiary: Color(0xFF023012),
    onSecondaryContainer: Color(0xFF1b240b),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    error: Colors.red,
  );
}
