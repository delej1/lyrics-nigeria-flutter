import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lyrics_nigeria_flutter/base/custom_loader.dart';
import 'package:lyrics_nigeria_flutter/base/section_header.dart';
import 'package:lyrics_nigeria_flutter/helpers/ad_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';


class FavouritesCard extends StatefulWidget {
  const FavouritesCard({Key? key}) : super(key: key);

  @override
  State<FavouritesCard> createState() => _FavouritesCardState();
}

late DatabaseReference _dbRef;

class _FavouritesCardState extends State<FavouritesCard> {

  User? mAuth = FirebaseAuth.instance.currentUser;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('Favourites').child(mAuth!.uid);
    _dbRef.keepSynced(true);

    BannerAd(
      adUnitId: FavouritesAdHelper.bannerAdUnitId,
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
    return StreamBuilder(
      stream: _dbRef.onValue,
      builder: (context, AsyncSnapshot snap){
        if(snap.hasData && !snap.hasError && snap.data.snapshot.value != null){
          Map data = snap.data.snapshot.value;
          List item = [];
          data.forEach((index, data) => item.add({"key": index, ...data}));
          return Column(
            children: [
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(Dimensions.width20),
                child: Column(
                  children: [
                    const SectionHeader(title: "Favourites"),
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(top: Dimensions.height20),
                        physics: const BouncingScrollPhysics(),
                        itemCount: item.length,
                        cacheExtent: double.maxFinite,
                        itemBuilder:((context, index){
                          return InkWell(
                            onTap: (){
                              String song = item[index]['song'];
                              String artist = item[index]['artist'];
                              String cover = item[index]['cover'];
                              String beat = item[index]['beat'];
                              String lyrics = item[index]['lyrics'];
                              Get.toNamed('/featured-lyrics-page',
                                  arguments: [song, artist, cover, beat, lyrics]);
                            },
                            child: Container(
                              height: Dimensions.height15*5,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade800.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                                    child: CachedNetworkImage(
                                      imageUrl: item[index]['cover'],
                                      placeholder: (context, url) => const CustomLoader(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      height: Dimensions.height10*5,
                                      width: Dimensions.width10*5,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width20,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Dimensions.width20*20,
                                          child: Text(
                                            item[index]['song'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width20*20,
                                          child: Text(
                                            item[index]['artist'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    var key = item[index]['key'];
                                    _dbRef.child(key).remove();
                                  },
                                    icon: Icon(Icons.favorite, size: Dimensions.iconSize16*2, color: Colors.red,),),
                                ],
                              ),
                            ),
                          );
                        })),
                  ],
                ),
              ),
            ],
          );
        }else{return Center(child: Text("No Favourites Added", style: TextStyle(fontSize: Dimensions.font20),));}
      },
    );
  }
}
