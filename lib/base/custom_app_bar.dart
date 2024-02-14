import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/auth/auth_service.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  User? mAuth = FirebaseAuth.instance.currentUser;
  bool isLogged = false;
  bool searchState = false;

  @override
  Widget build(BuildContext context) {
    if (mAuth != null) {
      setState(() {
        isLogged = true;
      });
    } else {
      setState(() {
        isLogged = false;
      });
    }
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: [
        IconButton(onPressed: (){
          showSearch(context: context, delegate: DataSearch());
        }, icon: const Icon(Icons.search)),
        Container(
          margin: EdgeInsets.only(right: Dimensions.width20),
          child: GestureDetector(
            onTap: () {
              if (mAuth != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: const Text(
                      'Do you want to sign out?',
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade800,
                        ),
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLogged = false;
                          });
                          AuthService().signOut();
                        },
                        //return true when click on "Yes"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade800,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              } else {}
            },
            child: !isLogged
                ? const CircleAvatar(
                    child: Icon(Icons.person),
                  )
                : Container(
                    margin: EdgeInsets.only(right: Dimensions.width20),
                    child: ProfilePicture(
                      name: mAuth!.displayName??"",
                      radius: Dimensions.radius20,
                      fontsize: Dimensions.font20,
                      random: true,
                      count: 1,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  DataSearch({
    String hintText = "Search",
  }) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
    searchFieldStyle: const TextStyle(
      color: Colors.black,
    ),
  );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Featured');
    List item = [];
    List emptyItem = [];
    final suggestionList = query.isEmpty?emptyItem:item;
    return StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            List search = [];
            data.forEach((index, data) => search.add({"key": index, ...data}));
            if(search.any((e) => e['song'].toLowerCase().startsWith(query)||e['artist'].startsWith(query))){
              var value = search.indexWhere((e) => e['song'].toLowerCase().startsWith(query)||e['artist'].startsWith(query));
              item.add(search[value]);
            }
            return Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  itemCount: suggestionList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        String song = suggestionList[index]['song'];
                        String artist = suggestionList[index]['artist'];
                        String cover = suggestionList[index]['cover'];
                        String beat = suggestionList[index]['beat'];
                        String lyrics = suggestionList[index]['lyrics'];
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
                                imageUrl: suggestionList[index]['cover'],
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: Dimensions.height10*5,
                                width: Dimensions.width10*5,
                              ),
                            ),
                             SizedBox(
                              width: Dimensions.width20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Dimensions.width20*20,
                                    child: Text(
                                      suggestionList[index]['song'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20*20,
                                    child: Text(
                                      suggestionList[index]['artist'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Featured');
    List item = [];
    List emptyItem = [];
    final suggestionList = query.isEmpty?emptyItem:item;
    return StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            List search = [];
            data.forEach((index, data) => search.add({"key": index, ...data}));
            if(search.any((e) => e['song'].toLowerCase().startsWith(query)||e['artist'].startsWith(query))){
              var value = search.indexWhere((e) => e['song'].toLowerCase().startsWith(query)||e['artist'].startsWith(query));
              item.add(search[value]);
            }
            return Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  itemCount: suggestionList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        String song = suggestionList[index]['song'];
                        String artist = suggestionList[index]['artist'];
                        String cover = suggestionList[index]['cover'];
                        String beat = suggestionList[index]['beat'];
                        String lyrics = suggestionList[index]['lyrics'];
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
                                imageUrl: suggestionList[index]['cover'],
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: Dimensions.height10*5,
                                width: Dimensions.width10*5,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Dimensions.width20*20,
                                    child: Text(
                                      suggestionList[index]['song'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20*20,
                                    child: Text(
                                      suggestionList[index]['artist'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
