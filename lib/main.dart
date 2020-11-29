import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/app.dart';
import 'package:fullfuel_app/src/database/Hive/database.dart';

void main() {
  Database.init();
  runApp(App());
}
