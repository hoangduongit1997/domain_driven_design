import 'package:flutter/material.dart';
import 'package:domain_driven_design/MoLibUIComposer.dart';

import 'infrastructure/factories/db_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseFactory().createDatabase();
  MoLibUIComposer.configure(db);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Virtual Library',
      debugShowCheckedModeBanner: false,
      home: MoLibUIComposer.composeHomePage(),
    );
  }
}
