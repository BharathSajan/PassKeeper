import 'dart:core';
import 'package:hive/hive.dart';
import 'package:compsec/model/account.dart';

class DBHelper {
  // fetches the box (table) of accounts
  static Box<Account> getAccountBox() => Hive.box<Account>('accounts');

  List<Account> fetchAllAccounts() => getAccountBox().values.toList();

  bool createAccount(String domain, String username, String password) {
    // check if account is present
    List<Account> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.domain == domain && account.username == username) {
        return false;
      }
    }

    var icon = '';
    if (domain == 'Google') {
      icon = 'google-listicon.png';
    } else if (domain == 'Facebook') {
      icon = 'facebook-listicon.png';
    } else if (domain == 'Twitter') {
      icon = 'twitter-listicon.png';
    } else if (domain == 'SBI') {
      icon = 'sbi-listicon.png';
    } else if (domain == 'Instagram') {
      icon = 'instagram-listicon.png';
    } else if (domain == 'LinkedIn') {
      icon = 'linkedin-listicon.png';
    } else if (domain == 'Eduserver') {
      icon = 'eduserver-listicon.png';
    } else if (domain == 'HDFC') {
      icon = 'hdfc-listicon.png';
    } else if (domain == 'ICICI') {
      icon = 'icici-listicon.png';
    } else if (domain == 'Aternos') {
      icon = 'aternos-listicon.png';
    } else {
      icon = 'default-listicon.png';
    }

    // if no such account present, insert into the box with the key being domain+username
    final account = Account() // create the required account record
      ..domain = domain
      ..username = username
      ..password = password
      ..icon = icon;
    final accountBox = getAccountBox(); // get the box
    accountBox.add(account);
    return true;
  }
// fetch specific accounts
  Account? fetchAccountFromKey(String domain, String username) {
    List<Account> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.domain == domain && account.username == username) {
        return account;
      }
    }
    return null;
  }
// update the password
  void updatePassword(String domain, String username) {
    var i = 0;
    List<Account> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.domain == domain && account.username == username) {
        account.password = 'Nigoos';
        getAccountBox().putAt(i, account);
        return;
      }
      i += 1;
    }
    return;
  }
  void changePassword(String domain, String username, String Newpassword) {
    var i = 0;
    List<Account> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.domain == domain && account.username == username) {
        account.password = Newpassword;
        getAccountBox().putAt(i, account);
        return;
      }
      i += 1;
    }
    return;
  }

  void deleteAccount(String domain, String username) {
    List<Account> accounts = fetchAllAccounts();
    for (var account in accounts) {
      if (account.domain == domain && account.username == username) {
        account.delete();
        return;
      }
    }
  }
}
