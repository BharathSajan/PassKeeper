import 'package:hive/hive.dart';

part 'mk.g.dart';

@HiveType(typeId: 2)
class Masterkey extends HiveObject {
  Masterkey({required this.AppName, required this.masterkey});
  @HiveField(0)
  late String AppName;

  @HiveField(1)
  late String masterkey;
}