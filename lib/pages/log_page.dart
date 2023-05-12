import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:compsec/dbhelperlog.dart';
import 'package:compsec/model/log.model.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<logModel> logs = DBHelperLog().fetchAllLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Page',
            style: TextStyle(color: Colors.white),
      ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(59, 85, 171, 1.0),
        foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
      ),
      body:ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: logs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // color: const Color.fromRGBO(103, 80, 164, 0.05),
                margin: const EdgeInsets.all(8.0),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  tileColor: const Color.fromRGBO(232, 222, 248, 1),
                  title: Text(
                    'Domain: ${logs[index].domainTm}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date and Time: ${logs[index].dateTm}',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        'Username: ${logs[index].usernameTm}',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}



