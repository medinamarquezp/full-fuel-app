import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fullfuel_app/src/app.dart';
import 'package:fullfuel_app/src/database/Hive/database.dart';

void main() async {
  await loadDotEnv();
  await Database.init();
  runApp(App());
}

Future loadDotEnv() async {
  await DotEnv().load('.env');
}
