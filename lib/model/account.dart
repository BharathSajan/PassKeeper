import 'package:hive/hive.dart';
part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {

  @HiveField(0)
  late String domain;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String password;

  @HiveField(3)
  late String icon;
}