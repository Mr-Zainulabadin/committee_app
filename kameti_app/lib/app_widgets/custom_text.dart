import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final bool textBaseline;
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color fontColor;
  TextAlign textAlignment;
  double height;
  double? scale;
  CustomText({
    Key? key,
    required this.text,
    this.textBaseline = false,
    this.fontSize = 14,
    this.scale,
    this.fontWeight = FontWeight.w600,
    this.fontColor = Colors.white,
    this.textAlignment = TextAlign.start,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: scale,
      textAlign: textAlignment,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }
}
