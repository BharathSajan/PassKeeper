import 'dart:core';
import 'package:hive/hive.dart';
import 'package:compsec/model/mk.dart';

class MKhelper{
  //fetches the box table of accounts


  static Box<Masterkey> getAccountBox() => Hive.box<Masterkey>('masterkey');

  List<Masterkey> fetchAllAccounts() => getAccountBox().values.toList();


  bool mkcheck(String appname, String masterkey) {
    List<Masterkey> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.AppName == appname && account.masterkey == masterkey) {
        return true;
      }
    }
    return false;
  }
  bool mkchange(String appname, String oldmk, String newmk) {
    var i = 0;
    List<Masterkey> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.AppName== appname && account.masterkey== oldmk) {
        account.masterkey = newmk;
        // getAccountBox().putAt(i, account);
        return true;
      }
      // i += 1;
    }
    return false;
  }


}