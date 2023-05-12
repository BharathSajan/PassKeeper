import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:compsec/applock.dart';
import 'package:compsec/pages/home.dart';
import 'package:compsec/pages/store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:compsec/model/account.dart';
import 'package:compsec/pages/passwords_list.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:compsec/model/log.model.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:compsec/pages/log_page.dart';
import 'package:compsec/pages/lockscreen.dart';
import 'package:compsec/model/mk.dart';
import 'package:compsec/pages/changemk.dart';
import'package:crypto/crypto.dart';

// import 'package:compsec/pages/password_details.dart';

// String masterkey ="Password";
// String appname = "PassKeeper";
late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  const secureStorage = FlutterSecureStorage();

  final encryptionKeyString = await secureStorage.read(key: 'key');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!);
  Hive.registerAdapter(AccountAdapter());
  await Hive.openBox<Account>('accounts', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));//encrypts/decrypts andloads all the key value pairs from local storage to memory


  Hive.registerAdapter(logModelAdapter());
  await Hive.openBox<logModel>('logDBV');


  // await Hive.openBox<Masterkey>('masterkey');
  Hive.registerAdapter(MasterkeyAdapter());
  box = await Hive.openBox<Masterkey>('masterkey');
  var bytes = utf8.encode("Password");
  // var sha = sha1.convert(bytes);
  var sha512 = sha256.convert(bytes);
  box.put('masterkey', Masterkey(AppName: "PassKeeper", masterkey: sha512.toString()));
  runApp(AppLock(builder: (arg) => const MyApp(),lockScreen: const MyAppLock(),backgroundLockLatency: const Duration(seconds: 90)));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // static final String title = 'PassKeeper App'
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassKeeper',
    // home: Home(),
    initialRoute: '/Home',
    routes: {
      '/lockscreen': (context) =>  LockScreen(),
      '/Home': (context) =>  Home(),
      '/store': (context) =>  Store(),
      '/passwordslist' : (context)=> const AccountsList(),
      '/log' : (context) => const LogPage(),
      '/changemk' : (context) => const Changemk(),
      // '/password_details': (context) =>  Home(),
    },
  );
  }
}


