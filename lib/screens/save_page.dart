import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:west_sea_app/data/ad_helper.dart';
import 'package:west_sea_app/data/boxes.dart';
import 'package:west_sea_app/data/savedb.dart';
import 'package:intl/intl.dart';

const int maxFailedAttemp = 3;

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _inLineAdIndex = 2;
  late BannerAd _inLineBannerAd;
  bool _isIlineBannerAdLoaded = false;
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttemp = 0;

  int _getListViewItemIndex(int index) {
    if (index >= _inLineAdIndex && _isIlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }

  void _creatInlineBannerAd() {
    _inLineBannerAd = BannerAd(
      adUnitId: AdHelper.onListBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isIlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inLineBannerAd.load();
  }

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
    _creatInlineBannerAd();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _inLineBannerAd.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            _showInterstitialAd();
            Get.back();
          },
        ),
        elevation: 0,
        title: const Text('Saved Numbers'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Savedb>>(
        valueListenable: Boxes.getSaveDb().listenable(),
        builder: (context, box, _) {
          final saved = box.values.toList().cast<Savedb>();

          return showSaved(saved);
        },
      ),
    );
  }

  Widget showSaved(List<Savedb> saves) {
    if (saves.isEmpty) {
      return const Center(
        child: Text(
          'No Saved Numbers yet!!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        child: ListView.separated(
          reverse: true,
          itemCount: saves.length +
              (_isIlineBannerAdLoaded && saves.length > 1 ? 1 : 0),
          itemBuilder: (context, index) {
            if (_isIlineBannerAdLoaded && index == 2) {
              return Container(
                padding: const EdgeInsets.only(bottom: 10),
                width: _inLineBannerAd.size.width.toDouble(),
                height: _inLineBannerAd.size.height.toDouble(),
                child: AdWidget(
                  ad: _inLineBannerAd,
                ),
              );
            } else {
              return buildSaved(context, saves[_getListViewItemIndex(index)]);
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
        ),
      );
    }
  }

  Widget buildSaved(BuildContext context, Savedb savedb) {
    final date = DateFormat.yMMMEd().format(savedb.date);
    final numbers = savedb.numbers;

    return ListTile(
      tileColor: Colors.green,
      title: Text(numbers),
      subtitle: Text(date),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => deleteSaved(savedb),
        color: Colors.white,
      ),
    );
  }

  void deleteSaved(Savedb savedb) {
    savedb.delete();
  }
}
