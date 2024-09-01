import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_3/db.dart';
import 'package:mcs_bab_3/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initCatatanDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Catatan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}