import 'package:hive/hive.dart';
import 'package:west_sea_app/data/savedb.dart';

class Boxes {
  static Box<Savedb> getSaveDb() => Hive.box<Savedb>('Savedb');
}
