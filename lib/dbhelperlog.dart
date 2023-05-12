import 'dart:core';
import 'package:hive/hive.dart';
import 'package:compsec/model/log.model.dart';

class DBHelperLog {
  // fetches the box (table) of accounts
  static Box<logModel> getLogBox() => Hive.box<logModel>('logDBV');

  List<logModel> fetchAllLogs() => getLogBox().values.toList();

  void createLog(String dateIn,String domainIn,String userIn) {
final log = logModel(dateIn,domainIn,userIn) // create the required account record
      ..dateTm = dateIn
      ..domainTm = domainIn
      ..usernameTm=userIn;
    final logBox = getLogBox(); // get the box
    logBox.add(log);
  }
}