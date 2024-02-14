import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyrics_nigeria_flutter/base/custom_app_bar.dart';
import 'package:lyrics_nigeria_flutter/views/home/favourites.dart';
import 'package:lyrics_nigeria_flutter/views/home/lyrics_nigeria_main_page.dart';
import 'package:lyrics_nigeria_flutter/views/home/play_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late int _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pages = [
      const LyricsNigeriaMainPage(),
      const Favourites(),
      const Play(),
    ];
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App', style: TextStyle(color: Colors.black),),
        content: const Text('Do you want to exit the App?', style: TextStyle(color: Colors.black),),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade800,),
            //return false when click on "NO"
            child:const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                Navigator.of(context).pop(false);
              }
            },
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade800,),
            child:const Text('Yes'),
          ),
        ],
      ),
    )??false; //if showDialog had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Platform.isAndroid?showExitPopup:null,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF11998e),
              Color(0xFF38ef7d).withOpacity(0.5),
              // Colors.blueGrey.shade800.withOpacity(0.8),
              // Colors.red.shade900.withOpacity(0.8),
              // Colors.green.shade900.withOpacity(0.8),
            ]
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(),
          body: PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
              });
            },
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blueGrey.shade800.withOpacity(0.6),
            unselectedItemColor: Theme.of(context).disabledColor,
            selectedItemColor: Colors.white,
            currentIndex: _selectedPageIndex,
            onTap: (selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
                _pageController.animateTo(selectedPageIndex.toDouble(), duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
              });
              _pageController.jumpToPage(selectedPageIndex);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.sports_esports),
                label: 'Play',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
