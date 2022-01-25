import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'savedb.g.dart';

@HiveType(typeId: 0)
class Savedb extends HiveObject with EquatableMixin {
  @HiveField(0)
  late String numbers;

  @HiveField(1)
  late DateTime date;

  @override
  List<Object> get props => [Savedb];
}
