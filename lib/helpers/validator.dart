// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validatorEmail'.tr;
    } else {
      return null;
    }
  }

  String? password(String? value) {
    const pattern = r'^.{6,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validatorPW'.tr;
    } else {
      return null;
    }
  }

  String? number(String? value) {
    if (value == null) {
      return null;
    }
    bool isNum = double.tryParse(value) != null;
    if (!isNum) {
      return 'validatorNum'.tr;
    }
    return null;
  }

  String? notEmpty(String? value) {
    if (value == '') {
      return 'validatorEmpty'.tr;
    } else {
      return null;
    }
  }
}
