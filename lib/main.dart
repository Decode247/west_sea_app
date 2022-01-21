import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:west_sea_app/screens/home_page.dart';
import 'package:west_sea_app/screens/save_page.dart';

import 'data/savedb.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedbAdapter());
  await Hive.openBox<Savedb>('Savedb');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'West Sea App',
      home: const HomePage(),
      routes: {
        '/saveScreen': (context) => const SavePage(),
      },
    );
  }
}
