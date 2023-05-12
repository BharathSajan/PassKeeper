import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:nomem/passwordGen.dart';
import 'package:compsec/dbhelper.dart';
import 'package:compsec/model/account.dart';
import 'package:flutter/services.dart';
import 'package:compsec/backup.dart';

class AccountDetailsPage extends StatefulWidget {
  final Account account;
  const AccountDetailsPage({Key? key, required this.account}) : super(key: key);


  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final userKeyController = TextEditingController();
  bool validateUserKey = false;
  bool _obscureText = true;
  late TextEditingController controller;

  @override
  void initState(){
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 250, 1),
      appBar: AppBar(
        title: const Text(
          "Account Details",
          // style: TextStyle(textAlign: TextAlign.center),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(59, 85, 171, 1.0),
        foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
        // shadowColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    title: 'Domain name:',
                    value: widget.account.domain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
            children: [
            Expanded(
              child: _buildCard(
                title: 'Username:',
                value: widget.account.username,
              ),
            ),
            ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    title: 'Password: ',
                    value: widget.account.password,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 112),
            const SizedBox(height: 80),
            //update and delete password
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        validateUserKey = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: ThemeData(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: const Color.fromRGBO(255, 255, 245, 1),
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text('Change Password'),
                              content: TextField(
                                // obscureText:_obscureText,
                                onChanged: (value){},
                                decoration:InputDecoration(hintText: "Enter New Password"),
                                controller:controller,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    if(controller.text == null|| controller.text.isEmpty)return;
                                    DBHelper().changePassword(
                                        widget.account.domain,
                                        widget.account.username,controller.text);
                                    setState(() {});
                                    controller.clear();
                                    Fluttertoast.showToast(
                                      msg: "The password has been changed successfully",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: ThemeData(
                                            dialogTheme: DialogTheme(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              backgroundColor: const Color.fromRGBO(255, 255, 245, 1),
                                            ),
                                          ),
                                          child: AlertDialog(
                                            title: const Text('Export recommended'),
                                            content: const Text(
                                              'An account\'s version has been updated. Do you want to export the accounts onto your system?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  var msg = '';
                                                  Navigator.of(context).pop();
                                                  if (await Export().export()) {
                                                    msg = 'Data file exported to Download folder successfully';
                                                  } else {
                                                    msg = "Data wasn't exported as Download folder couldn't be opened";
                                                  }
                                                  Fluttertoast.
                                                  showToast(
                                                    msg: msg,
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                },
                                                child: const Text('Yes'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Confirm'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    controller.clear();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Change Password',
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return Theme(
                            data: ThemeData(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: const Color.fromRGBO(255, 255, 245, 1),
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(
                                'Are you sure you want to delete the account?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(dialogContext).pop();
                                    Navigator.of(context).pop();
                                    DBHelper().deleteAccount(
                                        widget.account.domain,
                                        widget.account.username);
                                    Fluttertoast.showToast(
                                        msg:
                                        "The account has been deleted successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFDC362E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Delete Account',
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String value}) {
    return Card(
      elevation: 4,
      // shadowColor: Color.fromRGBO(255, 255, 255, 1),
      color: const Color.fromRGBO(232, 222, 248, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
