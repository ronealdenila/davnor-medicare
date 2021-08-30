import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/models/category_model.dart';

class AppData {
  static List<Category> categories = [
    Category(iconPath: earIconPath, title: 'Ear'),
    Category(iconPath: heartIconPath, title: 'Heart'),
    Category(iconPath: kidneyIconPath, title: 'Kidney'),
    Category(iconPath: liverIconPath, title: 'Liver'),
    Category(iconPath: lungsIconPath, title: 'Lungs'),
    Category(iconPath: noseIconPath, title: 'Lungs'),
    Category(iconPath: skinIconPath, title: 'Skin'),
    Category(iconPath: stomachIconPath, title: 'Stomach'),
    Category(iconPath: throatIconPath, title: 'Throat'),
  ];
}
