import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/core/models/menu_item_model.dart';
import 'package:davnor_medicare/routes/app_pages.dart';

class Item {
  const Item(this.name);
  final String name;
}

class ItemNum {
  const ItemNum(this.num);
  final int num;
}

final discomfortData = [
  Category(iconPath: earIconPath, title: 'Ear'),
  Category(iconPath: heartIconPath, title: 'Heart'),
  Category(iconPath: kidneyIconPath, title: 'Kidney'),
  Category(iconPath: liverIconPath, title: 'Liver'),
  Category(iconPath: lungsIconPath, title: 'Lungs'),
  Category(iconPath: skinIconPath, title: 'Skin'),
  Category(iconPath: stomachIconPath, title: 'Stomach'),
  Category(iconPath: throatIconPath, title: 'Throat'),
];

final List<Item> gender = <Item>[
  const Item('Female'),
  const Item('Male'),
];

final List<Item> type = <Item>[
  const Item('None'),
  const Item('Senior'),
  const Item('Pregnant Women'),
  const Item('Person with Disabiity (PWD)'),
  const Item('Indigenous People (IP)'),
];

final List<Item> month = <Item>[
  const Item('Jan'),
  const Item('Feb'),
  const Item('Mar'),
  const Item('Apr'),
  const Item('May'),
  const Item('June'),
  const Item('July'),
  const Item('Aug'),
  const Item('sept'),
  const Item('Oct'),
  const Item('Nov'),
  const Item('Dec'),
];

final List<Item> day = <Item>[
  const Item('01'),
  const Item('02'),
  const Item('03'),
  const Item('04'),
  const Item('05'),
  const Item('06'),
  const Item('07'),
  const Item('08'),
  const Item('09'),
  const Item('10'),
  const Item('11'),
  const Item('12'),
  const Item('13'),
  const Item('14'),
  const Item('15'),
  const Item('16'),
  const Item('17'),
  const Item('18'),
  const Item('19'),
  const Item('20'),
  const Item('21'),
  const Item('22'),
  const Item('23'),
  const Item('24'),
  const Item('25'),
  const Item('26'),
  const Item('27'),
  const Item('28'),
  const Item('29'),
  const Item('30'),
  const Item('31'),
];

List<MenuItem> pswdPSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('On Progress Request', Routes.ON_PROGRESS_REQ_LIST),
  MenuItem('Releasing Area', Routes.RELEASING_AREA_LIST),
  MenuItem('Medical Assistance History', Routes.MA_HISTORY_LIST),
];

List<MenuItem> adminSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  //Change me to my appropriate route
  MenuItem('List Of Doctors', Routes.VERIFICATION_REQ_LIST),
  MenuItem('List of PSWD Personnel', Routes.DASHBOARD),
];

List<MenuItem> pswdHeadSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('For Approval', Routes.ON_PROGRESS_REQ_LIST),
  MenuItem('Medical Assistance History', Routes.MA_HISTORY_LIST),
];
