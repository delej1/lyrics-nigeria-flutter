import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lyrics_nigeria_flutter/base/background_filter.dart';
import 'package:lyrics_nigeria_flutter/base/custom_loader.dart';
import 'package:lyrics_nigeria_flutter/base/player_buttons.dart';
import 'package:lyrics_nigeria_flutter/base/seek_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lyrics_nigeria_flutter/helpers/ad_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:get/get.dart';

class TrendingLyricsPage extends StatefulWidget {
  const TrendingLyricsPage({Key? key}) : super(key: key);

  @override
  State<TrendingLyricsPage> createState() => _TrendingLyricsPageState();
}

class _TrendingLyricsPageState extends State<TrendingLyricsPage> {

  List<String> trending = Get.arguments;
  AudioPlayer audioPlayer = AudioPlayer();

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children:[
          AudioSource.uri(Uri.parse(trending[3])),
        ])
    );

    InterstitialAd.load(
        adUnitId: InterstitialAdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            setState(() {
              _interstitialAd = ad;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        )
    );
    // _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
    //   // Called when the ad showed the full screen content.
    //     onAdShowedFullScreenContent: (ad) {},
    //     // Called when an impression occurs on the ad.
    //     onAdImpression: (ad) {},
    //     // Called when the ad failed to show full screen content.
    //     onAdFailedToShowFullScreenContent: (ad, err) {},
    //     // Called when the ad dismissed full screen content.
    //     onAdDismissedFullScreenContent: (ad) {
    //       ad.dispose();
    //     },
    //     // Called when a click is recorded for an ad.
    //     onAdClicked: (ad) {}
    // );
  }

  @override
  void dispose(){
    audioPlayer.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream,
          audioPlayer.durationStream, (Duration position, Duration? duration,) {
        return SeekBarData(position, duration ?? Duration.zero,);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: trending[2],
            placeholder: (context, url) => const CustomLoader(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          const BackgroundFilter(),
          _MusicPlayer(
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
            showAd: _interstitialAd?.show(),
          )
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
   _MusicPlayer({Key? key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer, required this.showAd,
  }): _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final Future<void>? showAd;

  final List<String> trending = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: SizedBox(
            height: MediaQuery.of(context).size.height*0.60,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                trending[4].replaceAll("\\n", "\n"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font26,
                ),
              ),
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(trending[0],
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
              SizedBox(height: Dimensions.height10,),
              Text(trending[1],
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                ),),
              SizedBox(height: Dimensions.height15*2,),
              StreamBuilder<SeekBarData>(
                  stream: _seekBarDataStream,
                  builder: (context, snapshot){
                    final positionData = snapshot.data;
                    return SeekBar(
                      position: positionData?.position ?? Duration.zero,
                      duration: positionData?.duration ?? Duration.zero,
                      onChanged: audioPlayer.seek,
                    );
                  }),
              PlayerButtons(audioPlayer: audioPlayer)
            ],
          ),
        ),
      ],
    );
  }
}

