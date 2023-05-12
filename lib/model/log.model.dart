import 'package:hive/hive.dart';

part 'log.model.g.dart';

@HiveType(typeId: 1)
class logModel{
  @HiveField(0)
  String dateTm;
  @HiveField(1)
  String domainTm;
  @HiveField(2)
  String usernameTm;
  logModel(this.dateTm, this.domainTm,this.usernameTm);
}