import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF996C59);
  static const Color secondaryColor = Color(0xFFEDE9D0);
  static const Color shadowColor = Color(0xFF3A001E);
  static const Color brightColor = Color(0xFFFF864C);

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(25));

  static ThemeData appThemeInventory(BuildContext context) =>
      ThemeData.light().copyWith(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: secondaryColor,
          cardColor: brightColor,
          useMaterial3: true,
          iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(brightColor),
              iconSize: MaterialStatePropertyAll(25),
            ),
          ),
          primaryTextTheme:
              GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
            bodyLarge: const TextStyle(
              fontSize: 16,
              color: shadowColor,
            ),
          ),
          dialogTheme: DialogTheme(
              backgroundColor: secondaryColor,
              titleTextStyle:
                  GoogleFonts.lilitaOne(color: shadowColor, fontSize: 25),
              contentTextStyle: GoogleFonts.lato(
                  color: shadowColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(
                shadowColor,
              ),
              textStyle: MaterialStatePropertyAll(
                GoogleFonts.lato(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
            textStyle: GoogleFonts.lato(
              color: shadowColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: GoogleFonts.lato(
                color: shadowColor,
                fontWeight: FontWeight.w700,
              ),
              hintStyle: GoogleFonts.lato(
                color: shadowColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: shadowColor,
                  width: 2,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
              ),
            ),
            menuStyle: const MenuStyle(
              backgroundColor: MaterialStatePropertyAll(AppTheme.brightColor),
              elevation: MaterialStatePropertyAll(3),
              shadowColor: MaterialStatePropertyAll(AppTheme.shadowColor),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            iconColor: shadowColor,
            floatingLabelStyle: GoogleFonts.lato(
                color: brightColor, fontWeight: FontWeight.bold),
            labelStyle: GoogleFonts.lato(
              color: shadowColor,
              fontWeight: FontWeight.w700,
            ),
            hintStyle: GoogleFonts.lato(
              color: shadowColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: shadowColor,
                width: 2,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: brightColor,
                width: 2,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: brightColor,
              shadows: [
                Shadow(
                  color: shadowColor,
                  offset: Offset(1, 2),
                  blurRadius: 5,
                )
              ],
            ),
            centerTitle: true,
            titleTextStyle: GoogleFonts.lilitaOne(
              shadows: [
                const Shadow(
                  color: shadowColor,
                  offset: Offset(1, 2),
                  blurRadius: 2.5,
                )
              ],
              fontSize: 22,
            ),
            color: primaryColor,
            elevation: 3.0,
            shadowColor: shadowColor,
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: secondaryColor,
            surfaceTintColor: secondaryColor,
            elevation: 5.0,
            shadowColor: shadowColor,
            headerBackgroundColor: primaryColor,
            headerForegroundColor: secondaryColor,
            headerHeadlineStyle: GoogleFonts.lilitaOne(fontSize: 40),
            headerHelpStyle: GoogleFonts.lilitaOne(fontSize: 15),
            dayStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
            weekdayStyle: GoogleFonts.lato(fontWeight: FontWeight.w700),
            yearStyle: GoogleFonts.lato(fontWeight: FontWeight.w400),
            todayBackgroundColor: const MaterialStatePropertyAll(primaryColor),
            todayForegroundColor: const MaterialStatePropertyAll(brightColor),
            dayOverlayColor: const MaterialStatePropertyAll(primaryColor),
            rangePickerBackgroundColor: primaryColor,
            dividerColor: brightColor,
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: shadowColor,
            contentTextStyle: GoogleFonts.lato(color: brightColor),
            elevation: 3,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(primaryColor),
              shadowColor: const MaterialStatePropertyAll(shadowColor),
              foregroundColor: const MaterialStatePropertyAll(secondaryColor),
              iconColor: const MaterialStatePropertyAll(brightColor),
              elevation: const MaterialStatePropertyAll(5.5),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: brightColor),
                ),
              ),
              textStyle: MaterialStatePropertyAll(
                GoogleFonts.lilitaOne(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
          cardTheme: const CardTheme(elevation: 3, shadowColor: shadowColor));
}
