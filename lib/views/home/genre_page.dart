import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/cards/featured_card.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {

  List<String> genre = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,),
        body: SingleChildScrollView(physics: const BouncingScrollPhysics(),
            child: FeaturedCard(genre: genre[0], genreTitle: genre[1])),
      ),
    );
  }
}
