import 'package:flutter/material.dart';
import 'package:lyrics_nigeria_flutter/base/discover_lyrics.dart';
import 'package:lyrics_nigeria_flutter/cards/genre_card.dart';
import 'package:lyrics_nigeria_flutter/cards/trending_card.dart';

class LyricsNigeriaMainPage extends StatefulWidget {
  const LyricsNigeriaMainPage({Key? key}) : super(key: key);

  @override
  State<LyricsNigeriaMainPage> createState() => _LyricsNigeriaMainPageState();
}

class _LyricsNigeriaMainPageState extends State<LyricsNigeriaMainPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: const [
          //Search Bar
          DiscoverLyrics(),
          //Trending Music
          TrendingCard(),
          //Featured Lyrics
          GenreCard(),
        ],
      ),
    );
  }
}
