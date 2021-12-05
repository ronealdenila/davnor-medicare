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
      title: 'icons1', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: heartburnIcon,
      title: 'icons2',
      specialist: 'Gastroenterologist',
      categoryID: 'category1'),
  Category(
      iconPath: vomitingIcon,
      title: 'icons3', //
      specialist: 'Gastroenterologist',
      categoryID: 'category1'),
  Category(
      iconPath: diarrheaIcon,
      title: 'icons4', //
      specialist: 'Gastroenterologist',
      categoryID: 'category1'),
  Category(
      iconPath: abdominalpainIcon,
      title: 'icons5', //
      specialist: 'Gastroenterologist',
      categoryID: 'category1'),
  Category(
      iconPath: sinusitisIcon,
      title: 'icons6', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: coughIcon,
      title: 'icons7', //
      specialist: 'Pulmonologist'), //pedia or family department
  Category(
      iconPath: hypertensionIcon,
      title: 'icons8', //
      specialist: 'Nephrologist'), //pedia or family department
  Category(
      iconPath: backpainIcon,
      title: 'icons9', //
      specialist: 'Orthopedist'), //pedia or family department
  Category(
      iconPath: conjunctivitisIcon,
      title: 'icons10', //
      specialist: 'Ophthalmologist'), //pedia or family department
  Category(
      iconPath: diabetesIcon,
      title: 'icons11', //
      specialist: 'Diabetologist',
      categoryID: 'category12'),
  Category(
      iconPath: asthma,
      title: 'icons12', //
      specialist: 'Pulmonologist'), //pedia or family department
  Category(
      iconPath: foodallergyIcon,
      title: 'icons13', //
      specialist: 'Immunologist'), //pedia or family department
  Category(
      iconPath: sorethroatIcon,
      title: 'icons14', //
      specialist: 'Otolaryngologist (ENT)'), //pedia or family department
  Category(
      iconPath: pneomoniaIcon,
      title: 'icons15', //
      specialist: 'Pulmonologist'), //pedia or family department
];

final List<Item> gender = <Item>[
  const Item('Female'),
  const Item('Male'),
];

final List<Item> cSenior = <Item>[
  const Item('None'),
  const Item('Senior'),
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

List<MenuItem> patientSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.PATIENT_WEB_HOME),
  MenuItem('Live Consultation', Routes.PATIENT_WEB_LIVE_CONS),
  MenuItem('Consultation History', Routes.PATIENT_WEB_CONS_HISTORY),
  MenuItem('Medical Assistance History', Routes.PATIENT_WEB_MA_HISTORY),
  MenuItem('Change Language', Routes.CONS_HISTORY_WEB),
  MenuItem('App Info', Routes.MA_HISTORY_LIST),
];

List<MenuItem> doctorSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DOC_WEB_HOME),
  MenuItem('Consultation Requests', Routes.CONS_REQ_WEB),
  MenuItem('Live Consultation', Routes.LIVE_CONS_WEB),
  MenuItem('Consultation History', Routes.CONS_HISTORY_WEB),
];

List<MenuItem> pswdHeadSideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('For Approval', Routes.FOR_APPROVAL_LIST),
  MenuItem('On Progress Request', Routes.ON_PROGRESS_REQ_LIST),
  MenuItem('Releasing Area', Routes.RELEASING_AREA_LIST),
  MenuItem('Medical Assistance History', Routes.MA_HISTORY_LIST),
];
