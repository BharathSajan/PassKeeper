import 'package:flutter/material.dart';
import 'package:compsec/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:compsec/mkhelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';

class  LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final masterkeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    masterkeyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 250, 1),
    appBar: AppBar(
      title: const Text(
        "Authentication",
        // style: TextStyle(textAlign: TextAlign.center),
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(59, 85, 171, 1.0),
      foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
      // shadowColor: const Color.fromRGBO(255, 255, 255, 1),

    ),
    body: SingleChildScrollView(
    child: Form(
    key: _formKey,
    // padding: const EdgeInsets.all(16.0),
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            Image.asset('assets/images/PassKeeper.png', scale: 2.25),
            const SizedBox(height: 16),
          Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Master Key",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    errorMaxLines: 2,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Masterkey is a required field';
                    }
                    return null;
                  },
                  controller: masterkeyController)),
        const Text(
          "-Enter Masterkey to view Saved passwords.\n \n-When using the application for the first time, the default password is 'Password'.",
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF938F99),
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
      SizedBox(child: ElevatedButton(
            onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
              if (!(_formKey.currentState!.validate())) {
                return;
              }
              var bytes = utf8.encode(masterkeyController.text.trim());
              var sha512 = sha256.convert(bytes);
              final masterkey = sha512.toString();

              if (MKhelper().mkcheck("PassKeeper",masterkey)) {

                Navigator.of(context).pushNamed('/passwordslist');
                masterkeyController.clear();
              } else {
                masterkeyController.clear();
                Fluttertoast.showToast(
                    msg: 'This masterkey is incorrect',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
            }, style: ElevatedButton.styleFrom(
        primary: const Color.fromRGBO(232, 222, 248, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
        child: const Text(
          'Enter',
          style: TextStyle(
            color: Color(0xFF4A4458),
          ),
        ),
        )
      ),
          ],
      ),
    ),
    ),
    ),);
  }
}
