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
  Category(
      iconPath: earacheIcon,
      title: 'Earache', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: heartburnIcon,
      title: 'Heartburn or GERD',
      specialist: 'Gastroenterologist',
      categoryID: 'category25'),
  Category(
      iconPath: vomitingIcon,
      title: 'Nausea or Vomiting', //
      specialist: 'Gastroenterologist',
      categoryID: 'category25'),
  Category(
      iconPath: diarrheaIcon,
      title: 'Diarrhea or Constipation', //
      specialist: 'Gastroenterologist',
      categoryID: 'category25'),
  Category(
      iconPath: abdominalpainIcon,
      title: 'Ulcer or Abdonimal Pain', //
      specialist: 'Gastroenterologist',
      categoryID: 'category25'),
  Category(
      iconPath: sinusitisIcon,
      title: 'Sinusitis', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: coughIcon,
      title: 'Cold or Cough', //
      specialist: 'Pulmonologist'), //pedia or family department
  Category(
      iconPath: hypertensionIcon,
      title: 'Hypertension', //
      specialist: 'Nephrologist'), //pedia or family department
  Category(
      iconPath: backpainIcon,
      title: 'Back Pain', //
      specialist: 'Orthopedist'), //pedia or family department
  Category(
      iconPath: conjunctivitisIcon,
      title: 'Conjunctivitis', //
      specialist: 'Ophthalmologist'), //pedia or family department
  Category(
      iconPath: diabetesIcon,
      title: 'Diabetes', //
      specialist: 'Diabetologist',
      categoryID: 'category23'),
  Category(
      iconPath: asthma,
      title: 'Asthma', //
      specialist: 'Pulmonologist'), //pedia or family department
  Category(
      iconPath: foodallergyIcon,
      title: 'Food Allergy', //
      specialist: 'Immunologist'), //pedia or family department
  Category(
      iconPath: sorethroatIcon,
      title: 'Sore Throat', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: pneomoniaIcon,
      title: 'Pneumonia', //
      specialist: 'Pulmonologist'), //pedia or family department
];

final List<Item> gender = <Item>[
  const Item('Female'),
  const Item('Male'),
];

final List<Item> department = <Item>[
  const Item('Pediatrics Department'),
  const Item('Family Department'),
  const Item('Internal Medicine Department'),
];

final List<Item> deptDropdown = <Item>[
  const Item('All'),
  const Item('Pediatrics Department'),
  const Item('Family Department'),
  const Item('Internal Medicine Department'),
];

final List<Item> title = <Item>[
  const Item('Orthopedist'),
  const Item('Ophthalmologist'),
  const Item('Diabetologist'),
  const Item('Otolaryngologist (ENT)'),
  const Item('Gastroenterologist'),
  const Item('Dermatologist'),
  const Item('Pulmonologist'),
  const Item('Nephrologist'),
  const Item('Immunologist'),
  //const Item('General Medicine'),
];

final List<Item> titleDropdown = <Item>[
  const Item('All'),
  const Item('Orthopedist'),
  const Item('Ophthalmologist'),
  const Item('Diabetologist'),
  const Item('Otolaryngologist (ENT)'),
  const Item('Gastroenterologist'),
  const Item('Dermatologist'),
  const Item('Pulmonologist'),
  const Item('Nephrologist'),
  const Item('Immunologist'),
  //const Item('General Medicine'),
];

final List<Item> position = <Item>[
  const Item('Personnel'),
  const Item('Head'),
];

final List<Item> positionDropdown = <Item>[
  const Item('All'),
  const Item('Personnel'),
  const Item('Head'),
];

final List<Item> pswdfilterDropdown = <Item>[
  const Item('All'),
  const Item('Last 30 days'),
];

final List<Item> type = <Item>[
  const Item('None'),
  const Item('Senior'),
  const Item('Pregnant Women'),
  const Item('Person with Disability (PWD)'),
  const Item('Indigenous People (IP)'),
];

final List<Item> typeDropdown = <Item>[
  const Item('All'),
  const Item('None'),
  const Item('Senior'),
  const Item('Pregnant Women'),
  const Item('Person with Disability (PWD)'),
  const Item('Indigenous People (IP)'),
];

List<MenuItem> pswdPSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('MA Request', Routes.MA_REQ_LIST),
  MenuItem('On Progress Request', Routes.ON_PROGRESS_REQ_LIST),
  MenuItem('Releasing Area', Routes.RELEASING_AREA_LIST),
  MenuItem('Medical Assistance History', Routes.MA_HISTORY_LIST),
];

List<MenuItem> adminSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('List Of Doctors', Routes.DOCTOR_LIST),
  MenuItem('List of PSWD Personnel', Routes.PSWD_STAFF_LIST),
  MenuItem('Verification Requests', Routes.VERIFICATION_REQ_LIST),
  MenuItem('Disabled Doctors', Routes.DISABLED_DOCTORS),
  MenuItem('Disabled PSWD Personnel', Routes.DISABLED_PSWD_STAFF),
];

List<MenuItem> doctorSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DOC_WEB_HOME),
  MenuItem('Consultation Requests', Routes.CONS_REQ_WEB),
  MenuItem('Live Consultation', Routes.PSWD_STAFF_LIST),
  // MenuItem('Verification Requests', Routes.VERIFICATION_REQ_LIST),
  // MenuItem('Disabled Doctors', Routes.DISABLED_DOCTORS),
  //MenuItem('Disabled PSWD Personnel', Routes.DISABLED_PSWD_STAFF),
];

List<MenuItem> pswdHeadSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('For Approval', Routes.FOR_APPROVAL_LIST),
  MenuItem('On Progress Request', Routes.ON_PROGRESS_REQ_LIST),
  MenuItem('Releasing Area', Routes.RELEASING_AREA_LIST),
  MenuItem('Medical Assistance History', Routes.MA_HISTORY_LIST),
];
