import 'dart:developer';
import 'dart:math';

import 'package:get/get.dart';

class NumberGenerator extends GetxController {
  final numbers = <String>['', '', '', '', '', '', '', ''].obs;

  @override
  void onInit() {
    RxList<String> tempNumbers = [''].obs;
    super.onInit();
    for (int i = 0; i < 7; i++) {
      String radNum = (Random(Timeline.now - 21).nextInt(49) + 1).toString();
      if (!tempNumbers.contains(radNum)) {
        tempNumbers.add(radNum);
      } else {
        tempNumbers.add((Random(Timeline.now).nextInt(49) + 1).toString());
      }
    }
    numbers.value = tempNumbers;
  }
}
