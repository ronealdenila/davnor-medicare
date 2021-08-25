import 'package:flutter/material.dart';

// App Colors. To easily manage our colors. We're going to initialize them here.

const Color infoColor = Color(0xFF4D82F3);

//Sorry sa naming hihi wala koy lain mahunahunaan na dali
//dali ra unta nato maindentify huehue (R)
const Color verySoftMagentaCustomColor = Color(0xFFDB96DF);
const Color verySoftBlueCustomColor = Color(0xFF3B8BD9);
const Color verySoftOrangeCustomColor = Color(0xFFE8C370);
const Color verySoftRedCustomColor = Color(0xFFDE928F);

const Color neutralWhiteColor = Color(0xFF64748B);
const Color neutralBubbleColor = Color(0xFF64748B);
const Color sidePanelColor = Color(0xFFF5F5F5);

// Neutral Color Palette
const MaterialColor neutralColor = MaterialColor(
  _lightFontsValue,
  <int, Color>{
    10: Color(0xFFF6F8FC),
    40: Color(0xFFCBD4E1),
    60: Color(_lightFontsValue),
    80: Color(0xFF27364B),
    100: Color(0xFF0F1A2A),
  },
);
const int _lightFontsValue = 0xFF64748B;

// Very Soft Blue Color Palette
const MaterialColor verySoftBlueColor = MaterialColor(
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

// Very Soft Magenta Color Palette
const MaterialColor verySoftMagenta = MaterialColor(
  _verySoftMagentaPrimaryValue,
  <int, Color>{
    10: Color(0xFFF9E5FA),
    20: Color(0xFFF4D0F6),
    40: Color(0xFFEFBAF2),
    60: Color(_verySoftMagentaPrimaryValue),
    80: Color(0xFFE07AE6),
    100: Color(0xFFDB65E2),
  },
);
const int _verySoftMagentaPrimaryValue = 0xFFEAA5EE;

// Very Soft Orange Color Palette
const MaterialColor verySoftOrange = MaterialColor(
  _verySoftOrangePrimaryValue,
  <int, Color>{
    10: Color(0xFFFAEAC6),
    20: Color(0xFFF7E1AF),
    40: Color(0xFFF5D997),
    60: Color(_verySoftOrangePrimaryValue),
    80: Color(0xFFEFBF51),
    100: Color(0xFFECB63A),
  },
);
const int _verySoftOrangePrimaryValue = 0xFFF3D080;

// Very Soft Red Color Palette
const MaterialColor verySoftRed = MaterialColor(
  _verySoftRedPrimaryValue,
  <int, Color>{
    10: Color(0xFFF8E1E0),
    20: Color(0xFFF3CDCC),
    40: Color(0xFFEFB8B7),
    60: Color(_verySoftRedPrimaryValue),
    80: Color(0xFFE17B78),
    100: Color(0xFFDC6764),
  },
);
const int _verySoftRedPrimaryValue = 0xFFEAA4A2;
