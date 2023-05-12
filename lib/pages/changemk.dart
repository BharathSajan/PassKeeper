import 'package:compsec/mkhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class Changemk extends StatefulWidget {
  const Changemk({Key? key}) : super(key: key);

  @override
  State<Changemk> createState() => _ChangemkState();
}

class _ChangemkState extends State<Changemk> {
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();
  bool validateUserKey = false;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    oldpassController.dispose();
    newpassController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 250, 1),
      appBar: AppBar(
        title: const Text(
          "Change Masterkey",
          // style: TextStyle(textAlign: TextAlign.center),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(59, 85, 171, 1.0),
        foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
        // shadowColor: const Color.fromRGBO(255, 255, 255, 1),

      ),
        body:SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const SizedBox(height: 16),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: TextFormField(
              decoration: InputDecoration(
                labelText: "Old Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,//the label text effect,whether it will appear or disappear
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[350]),
              ),
              validator: (value) {
                if (value == '') {
                  return '';
                }
                return null;
              },
              controller:  oldpassController)),
      const Text(
        " When using the application for first time the default password is 'Password'.",
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF938F99),
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: TextFormField(
              // obscureText: _obscureText,//This argument gives us the power to hide the data entered in the input field. The default of this is false, which makes it visible to us. If we make this true, the actual text will be invisible.
              // obscuringCharacter: '*',
              decoration: InputDecoration(
                labelText: "New Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,//the label text effect,whether it will appear or disappear
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "eg. ab765418",
                hintStyle: TextStyle(color: Colors.grey[350]),
              ),
              validator: (value) {
                if (value == '') {
                  return 'New Password is a required field';
                }
                return null;
              },
              controller:  newpassController)),
      const Text(
        ' Preferably contains at least 8 characters.',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF938F99),
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: 180,
        // submit button
        child: ElevatedButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (!(_formKey.currentState!.validate())) {
              return;
            }

            var bytes1 = utf8.encode(oldpassController.text.trim());
            var sha5121 = sha256.convert(bytes1);
            var bytes2 = utf8.encode(newpassController.text.trim());
            var sha5122 = sha256.convert(bytes2);
            final oldpass = sha5121.toString();
            final newpass = sha5122.toString();
            //check if account is created
            if (MKhelper().mkchange("PassKeeper", oldpass,
                newpass)) {
              oldpassController.clear();
              newpassController.clear();
              Fluttertoast.showToast(
                  msg: 'Masterkey has been changed successfully.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            } else {
              Fluttertoast.showToast(
                  msg: 'Old password is incorrect',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }
          },
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(232, 222, 248, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Text(
            'Change Masterkey',
            style: TextStyle(
              color: Color(0xFF4A4458),
            ),
          ),
        ),
      ),
    ],),
        ),
    ),
        ),
    );
  }
}
