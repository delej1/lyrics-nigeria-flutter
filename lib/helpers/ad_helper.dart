import 'dart:io';

class DiscoverAdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/9964819072';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/5110054004';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
class FeaturedAdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/6119290445';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/3713211851';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
class FavouritesAdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/7432372111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/1170808997';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
class PlayAdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/2086329056';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/3521640160';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
class LoginAdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/9432931062';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/7544645651';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

class InterstitialAdHelper {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5242580240582734/1035486396';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5242580240582734/7526224195';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}