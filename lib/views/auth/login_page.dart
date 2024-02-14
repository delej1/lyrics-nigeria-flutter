import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lyrics_nigeria_flutter/auth/auth_service.dart';
import 'package:lyrics_nigeria_flutter/helpers/ad_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: LoginAdHelper.bannerAdUnitId,
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10*5, bottom: Dimensions.height10*5),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sign in with:",
                    style: TextStyle(
                        fontSize: Dimensions.font26,
                    )),
                SizedBox(height: Dimensions.height20*5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          AuthService().signInWithGoogle();
                        },
                        child: Column(
                          children: [
                            Image(height:Dimensions.height30*5, width: Dimensions.width20*5, image: const AssetImage('assets/image/google_logo.png')),
                            const Text("Google"),
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          AuthService().signInWithApple();
                        },
                        child: Column(
                          children: [
                            Image(height:Dimensions.height30*5, width: Dimensions.width20*5, image: const AssetImage('assets/image/apple_logo.png')),
                            const Text("Apple"),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: Dimensions.height20*5,),
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
          ),
        ),
      ),
    );
  }
}
