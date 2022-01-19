import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea_app/screens/save_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final _url = [
    'https://www.youtube.com/c/WESTSEATV',
    'https://49s.co.uk/49s',
    'https://web.facebook.com/westseatv?_rdc=1&_rdr'
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue,
      elevation: 0,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 30, left: 15, right: 15),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'WEST SEA APP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.red[400]),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myListTile(
                  title: 'Saved Numbers',
                  subtitle: 'Your Favourite numbers',
                  icon: const Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                  onTabed: () {
                    Get.to(() => const SavePage());
                  },
                ),
                myListTile(
                  title: 'VIDOES',
                  subtitle: 'Predictions, Strategies, draw',
                  icon: Container(
                      color: Colors.red[900],
                      child: const Icon(Icons.play_arrow, color: Colors.white)),
                  onTabed: () async {
                    if (await canLaunch(_url[0])) {
                      await launch(
                        _url[0],
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    } else {
                      debugPrint('Failed');
                    }
                  },
                ),
                myListTile(
                  title: 'WEBSITE',
                  subtitle: 'draw, statics, hot ones and cold ones',
                  icon: Icon(Icons.language, color: Colors.grey[350]),
                  onTabed: () async {
                    if (await canLaunch(_url[1])) {
                      await launch(
                        _url[1],
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    }
                  },
                ),
                myListTile(
                  title: 'FACEBOOK',
                  subtitle: 'Sharing, Discussing, Collaborating, Doomer!!',
                  icon:
                      const Icon(Icons.facebook, size: 36, color: Colors.blue),
                  onTabed: () async {
                    if (await canLaunch(_url[2])) {
                      await launch(
                        _url[1],
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Widget myListTile(
    {required String title,
    required String subtitle,
    Widget? icon,
    required void Function() onTabed}) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 11, color: Colors.white),
    ),
    leading: icon,
    onTap: onTabed,
    tileColor: const Color.fromARGB(240, 7, 15, 54),
  );
}
