import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lyrics_nigeria_flutter/base/custom_loader.dart';
import 'package:lyrics_nigeria_flutter/helpers/ad_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> with AutomaticKeepAliveClientMixin {

  late DatabaseReference _dbRef;
  BannerAd? _bannerAd;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('play');
    _dbRef.keepSynced(true);
    BannerAd(
      adUnitId: PlayAdHelper.bannerAdUnitId,
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
    super.build(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.height30*10,
            child: StreamBuilder(
              stream: _dbRef.onValue,
              builder: (context, AsyncSnapshot snap){
                if(snap.hasData && !snap.hasError && snap.data.snapshot.value != null){
                  Map data = snap.data.snapshot.value;
                  List item = [];
                  data.forEach((index, data) => item.add({"key": index, ...data}));
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item.length,
                    primary: false,
                    cacheExtent: double.maxFinite,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider.builder(
                              itemCount: item.length,
                              itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      child: CachedNetworkImage(
                                        imageUrl: item[index]['image'],
                                        placeholder: (context, url) => const CustomLoader(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                              options: CarouselOptions(
                                height: Dimensions.height30*10,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                padEnds: false,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }else{return Container();}
              },
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.width10),
              child: Image.asset("assets/image/brand_logo.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.width10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: ()async{
                    String url = "https://play581.atmegame.com/";
                    Uri uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }else{throw 'Could not launch $uri';}
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radius20*50),
                        child: Image.asset("assets/image/game_icon.png", height: Dimensions.height30*5, width: Dimensions.width30*5, fit: BoxFit.fill,)
                      ),
                      BlinkText(
                        'Play Game',
                        style: TextStyle(fontSize: Dimensions.font20, color: Colors.redAccent,),
                        endColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    String url = "https://play581.atmequiz.com/";
                    Uri uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }else{throw 'Could not launch $uri';}
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radius20*5),
                          child: Image.asset("assets/image/quiz_icon.png", height: Dimensions.height30*5, width: Dimensions.width30*5, fit: BoxFit.fill,)
                      ),
                      BlinkText(
                        'Play Quiz',
                        style: TextStyle(fontSize: Dimensions.font20, color: Colors.redAccent),
                        endColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
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
