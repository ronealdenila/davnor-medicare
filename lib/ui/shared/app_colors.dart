import 'package:flutter/material.dart';

// App Colors. To easily manage our colors. We're going to initialize them here.

// const Color kcVerySoftBlueColor = Color(0xff90C3F4);
const Color kcNeutralColor = Color(0xFF64748B);
const Color kcInfoColor = Color(0xFF4D82F3);


// Custom Color Palette
const MaterialColor kcVerySoftBlueColor = MaterialColor(
  _verySoftBlueColorPrimaryValue,
  <int, Color>{
    10: Color(0xFFD6E9FB),
    20: Color(0xFFBEDCF9),
    40: Color(0xFFA7D0F6),
    60: Color(_verySoftBlueColorPrimaryValue),
    80: Color(0xFF62AAEF),
    100: Color(0xFF4A9DED),
  },
);
const int _verySoftBlueColorPrimaryValue = 0xFF90C3F4;
