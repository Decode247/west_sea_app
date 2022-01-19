import 'package:flutter/material.dart';
import 'package:west_sea_app/widgets/home_body.dart';
import 'package:west_sea_app/widgets/home_page_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UK49\'s Predictions'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: const HomePageBody(),
    );
  }
}
