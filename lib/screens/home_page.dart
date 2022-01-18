import 'package:flutter/material.dart';
import 'package:west_sea_app/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UK49\'s Predictions'),
        centerTitle: true,
      ),
      body: HomePageBody(),
    );
  }
}
