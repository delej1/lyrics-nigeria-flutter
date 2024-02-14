import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_nigeria_flutter/cards/favourites_card.dart';
import 'package:lyrics_nigeria_flutter/views/auth/login_page.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> with AutomaticKeepAliveClientMixin {
  User? mAuth = FirebaseAuth.instance.currentUser;
  bool isLogged = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(mAuth != null){
      setState(() {
        isLogged = true;
      });
    }else{
      setState(() {
        isLogged = false;
      });
    }
    return isLogged?const SingleChildScrollView(physics: BouncingScrollPhysics(), child: FavouritesCard()):const LoginPage();
  }
}
