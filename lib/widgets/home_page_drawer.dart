import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:west_sea_app/data/ad_helper.dart';
import 'package:west_sea_app/screens/save_page.dart';

const int maxFailedAttemp = 3;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _url = [
    'https://www.youtube.com/c/WESTSEATV',
    'https://49s.co.uk/49s',
    'https://web.facebook.com/westseatv?_rdc=1&_rdr'
  ];

  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttemp = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttemp = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttemp += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttemp >= maxFailedAttemp) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

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
                  subtitle: 'draw, statics, hot ones and cold ones',
                  icon: const Icon(Icons.save, color: Colors.green),
                  onTabed: () {
                    _showInterstitialAd();
                    Get.to(() => const SavePage());
                  },
                ),
                myListTile(
                  title: 'VIDOES',
                  subtitle: 'draws, strategies, techniques, predictions',
                  icon: Container(
                    color: Colors.red,
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                  onTabed: () async {
                    _showInterstitialAd();
                    if (await canLaunch(_url[0])) {
                      await launch(
                        _url[0],
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    }
                  },
                ),
                myListTile(
                  title: 'WEBSITE',
                  subtitle: 'draw, statics, hot ones and cold ones',
                  icon: Icon(Icons.language, color: Colors.grey[350]),
                  onTabed: () async {
                    _showInterstitialAd();
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
                  subtitle: 'discussing, collaborating, techiques, sharing',
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  onTabed: () async {
                    _showInterstitialAd();
                    if (await canLaunch(_url[2])) {
                      await launch(
                        _url[2],
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
    required void Function()? onTabed}) {
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
