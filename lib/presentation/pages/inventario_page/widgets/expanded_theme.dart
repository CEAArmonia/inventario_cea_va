import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';

ExpandedTileThemeData expandedThemeTile = const ExpandedTileThemeData(
  contentPadding: EdgeInsets.all(0),
  headerColor: AppTheme.primaryColor,
  headerSplashColor: AppTheme.brightColor,
);

var expandedTextStyle = GoogleFonts.lato(
  color: AppTheme.shadowColor,
  fontSize: 12,
);
