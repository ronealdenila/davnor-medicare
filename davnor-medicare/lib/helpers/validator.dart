// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  String? password(String? value) {
    const pattern = r'^.{6,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Password must be at least 6 characters';
    } else {
      return null;
    }
  }

  String? name(String? value) {
    const pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a name';
    } else {
      return null;
    }
  }

  String? number(String? value) {
    const pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.number'.tr;
    } else {
      return null;
    }
  }

  String? amount(String? value) {
    const pattern = r'^\d+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.amount'.tr;
    } else {
      return null;
    }
  }

  String? notEmpty(String? value) {
    const pattern = r'^\S+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'This is a required field';
    } else {
      return null;
    }
  }
}
