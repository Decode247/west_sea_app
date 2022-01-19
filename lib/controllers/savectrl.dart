import 'package:get/get.dart';
import 'package:west_sea_app/data/savedb.dart';

class SaveCtrl extends GetxController {
  var save = (String numbers) {}.obs;

  @override
  void onInit() {
    final saveTemp = (String numbers) {
      final saveDb = Savedb();
      saveDb.numbers = numbers;
      saveDb.date = DateTime.now();
    }.obs;
    super.onInit();
    save.value = saveTemp();
  }
}
