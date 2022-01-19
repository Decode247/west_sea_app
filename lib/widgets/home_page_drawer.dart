import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
                Link(
                  uri: Uri.parse('/saveScreen'),
                  builder: (context, followLink) {
                    return myListTile(
                      title: 'Saved Numbers',
                      subtitle: 'draw, statics, hot ones and cold ones',
                      icon: const Icon(Icons.save, color: Colors.green),
                      onTabed: followLink,
                    );
                  },
                ),
                Link(
                  target: LinkTarget.self,
                  uri: Uri.parse(_url[0]),
                  builder: (context, followLink) {
                    return myListTile(
                      title: 'VIDOES',
                      subtitle: 'draws, strategies, techniques, predictions',
                      icon: Container(
                        color: Colors.red,
                        child:
                            const Icon(Icons.play_arrow, color: Colors.white),
                      ),
                      onTabed: followLink,
                    );
                  },
                ),
                Link(
                  uri: Uri.parse(_url[1]),
                  builder: (context, followLink) {
                    return myListTile(
                      title: 'WEBSITE',
                      subtitle: 'draw, statics, hot ones and cold ones',
                      icon: Icon(Icons.language, color: Colors.grey[350]),
                      onTabed: followLink,
                    );
                  },
                ),
                Link(
                  uri: Uri.parse(_url[2]),
                  builder: (context, followLink) {
                    return myListTile(
                      title: 'FACEBOOK',
                      subtitle: 'discussing, collaborating, techiques, sharing',
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onTabed: followLink,
                    );
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
    required Future<void> Function()? onTabed}) {
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
