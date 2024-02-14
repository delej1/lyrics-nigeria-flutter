import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lyrics_nigeria_flutter/helpers/ad_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class DiscoverLyrics extends StatefulWidget {
  const DiscoverLyrics({Key? key}) : super(key: key);

  @override
  State<DiscoverLyrics> createState() => _DiscoverLyricsState();
}

class _DiscoverLyricsState extends State<DiscoverLyrics> {

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: DiscoverAdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome',
            style: Theme.of(context).textTheme.bodyLarge,),
          SizedBox(height: Dimensions.height10,),
          Text('Enjoy your favourite Nigerian lyrics',
            style: Theme.of(context).textTheme.headline6!,),
          SizedBox(height: Dimensions.height15,),
          //ADS
          if (_bannerAd != null)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}
