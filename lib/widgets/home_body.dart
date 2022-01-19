import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea_app/controllers/number_generator.dart';
import 'package:west_sea_app/data/boxes.dart';
import 'package:west_sea_app/data/savedb.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final number = Get.put(NumberGenerator());
  static bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GetX<NumberGenerator>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myButton(
                  label: 'Generate',
                  color: Colors.red,
                  onTabed: () {
                    controller.onInit();
                    _isPressed = true;
                  },
                ),
                myButton(
                  label: 'Save',
                  color: Colors.green,
                  onTabed: () {
                    if (_isPressed) {
                      final saveDb = Savedb();
                      saveDb.numbers = controller.numbers.toString();
                      saveDb.date = DateTime.now();
                      final box = Boxes.getSaveDb();
                      if (saveDb.isInBox) {
                        saveDb.delete();
                      } else {
                        box.add(saveDb);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Main Set'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ball(_isPressed ? number.numbers[1] : number.numbers[0]),
              ball(_isPressed ? number.numbers[2] : number.numbers[0]),
              ball(_isPressed ? number.numbers[3] : number.numbers[0]),
              ball(_isPressed ? number.numbers[4] : number.numbers[0]),
              ball(_isPressed ? number.numbers[5] : number.numbers[0]),
              ball(_isPressed ? number.numbers[6] : number.numbers[0]),
            ],
          ),
          const SizedBox(height: 15),
          const Text('Bonus Ball'),
          const SizedBox(height: 8),
          ball(_isPressed ? number.numbers[7] : number.numbers[0]),
        ],
      );
    });
  }
}

Widget myButton(
    {required String label,
    required Color color,
    required void Function() onTabed}) {
  return MaterialButton(child: Text(label), color: color, onPressed: onTabed);
}

Widget ball(String num) {
  return CircleAvatar(
    backgroundColor: Colors.blue[300],
    child: Text(
      num,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
