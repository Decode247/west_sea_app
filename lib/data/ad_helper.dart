import 'dart:io';

class AdHelper {
  static String get bottomBannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7019809493231784/6550476221";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7019809493231784/9511681485";
    } else {
      throw UnsupportedError('UnsupportedError');
    }
  }

  static String get onListBannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7019809493231784/6085579973";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7019809493231784/1498950785";
    } else {
      throw UnsupportedError('UnsupportedError');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7019809493231784/8007028126";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7019809493231784/1307379095";
    } else {
      throw UnsupportedError('UnsupportedError');
    }
  }
}
