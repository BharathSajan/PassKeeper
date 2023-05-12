import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:compsec/backup.dart';
class Home extends StatelessWidget {
  // const Home({super.key});
  @override
  Widget build(BuildContext context) {
    // precacheImage(const AssetImage('assets/PassKeeper.png'),context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
        // const SizedBox(height: 20),
    Image.asset('assets/images/PassKeeper.png', scale: 2.25),
    // const SizedBox(height: 10),
    const Text('A Simple and Secure\nPassword Management Application',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)
    ),
    const SizedBox(height: 30),
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(onPressed: () {//store password
                    Navigator.of(context).pushNamed('/store');
                  },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(59, 85, 171, 1.0)),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        elevation: MaterialStateProperty.all(12),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 12
                        ),
                          child: Row(
                            children: const[
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Store new password',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                      ),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(onPressed: () {//view passwords
                    Navigator.of(context).pushNamed('/lockscreen');
                  },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(59, 85, 171, 1.0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12
                      ),
                      child: Row(
                        children: const[
                          Icon(Icons.visibility_outlined, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Saved passwords',
                            style: TextStyle(color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      var msg = await Import().import();
                      if(msg != 'Cancelled') {
                        Fluttertoast.showToast(
                          msg: msg,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(59, 85, 171, 1.0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.file_upload,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Import accounts',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      var msg = '';
                      if (await Export().export()) {
                        msg = 'Data file exported to Download folder successfully';
                      } else {
                        msg = "Data wasn't exported as couldn't open Download folder";
                      }
                      Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(59, 85, 171, 1.0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.file_download,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Export accounts',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(onPressed: () {//database log
                    Navigator.of(context).pushNamed('/log');
                  },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(59, 85, 171, 1.0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12
                      ),
                      child: Row(
                        children: const[
                          Icon(Icons.book, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Database log',
                            style: TextStyle(color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(onPressed: () {//database log
                    Navigator.of(context).pushNamed('/changemk');
                  },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(59, 85, 171, 1.0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12
                      ),
                      child: Row(
                        children: const[
                          Icon(Icons.book, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Change Masterkey',
                            style: TextStyle(color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ),
                  ],
            ),
          ),

          ],
        ),
      ),
      ),
    );
  }
}
