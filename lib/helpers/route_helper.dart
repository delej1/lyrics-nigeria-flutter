import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/views/home/genre_page.dart';
import 'package:lyrics_nigeria_flutter/views/loading/loading_screen.dart';
import 'package:lyrics_nigeria_flutter/views/lyrics/featured_lyrics_page.dart';
import 'package:lyrics_nigeria_flutter/views/home/home_page.dart';
import 'package:lyrics_nigeria_flutter/views/lyrics/trending_lyrics_page.dart';
import 'package:lyrics_nigeria_flutter/views/splash/splash_page.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String loadingPage = "/loading-page";
  static const String genrePage="/genre-page";
  static const String trendingLyricsPage="/trending-lyrics-page";
  static const String featuredLyricsPage="/featured-lyrics-page";



  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getLoadingPage()=>'$loadingPage';
  static String getGenrePage()=>'$genrePage';
  static String getTrendingLyricsPage()=>'$trendingLyricsPage';
  static String getFeaturedLyricsPage()=>'$featuredLyricsPage';


  static List<GetPage>routes=[

    GetPage(name: splashPage, page: ()=>const SplashScreen()),

    GetPage(name: initial, page: (){
      return const HomePage();
    }),

    GetPage(name: loadingPage, page: (){
      return const LoadingScreen();
    }),

    GetPage(name: genrePage, page: (){
      return const GenrePage();
    }, transition: Transition.fade),

    GetPage(name: trendingLyricsPage, page: (){
      return const TrendingLyricsPage();
    }, transition: Transition.fade),

    GetPage(name: featuredLyricsPage, page: (){
      return const FeaturedLyricsPage();
    }, transition: Transition.fade),
  ];
}