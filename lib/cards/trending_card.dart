import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/base/section_header.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class TrendingCard extends StatefulWidget {
  const TrendingCard({Key? key}) : super(key: key);
  @override
  State<TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {

  late DatabaseReference _dbRef;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('Hot');
    _dbRef.keepSynced(true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbRef.onValue,
        builder: (context, AsyncSnapshot snap){
          if(snap.hasData && !snap.hasError && snap.data.snapshot.value != null){
            Map data = snap.data.snapshot.value;
            List item = [];
            data.forEach((index, data) => item..add({"key": index, ...data}));
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height10, bottom: Dimensions.height20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: const SectionHeader(title: 'Trending Music', action: "View More",),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.27,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item.length,
                        primary: true,
                        cacheExtent: double.maxFinite,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index){
                          return InkWell(
                              onTap: (){
                                String song = item[index]['song'];
                                String artist = item[index]['artist'];
                                String cover = item[index]['cover'];
                                String beat = item[index]['beat'];
                                String lyrics = item[index]['lyrics'];
                                Get.toNamed('/trending-lyrics-page',
                                    arguments: [song, artist, cover, beat, lyrics]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: Dimensions.width10),
                                child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.45,
                                        height: MediaQuery.of(context).size.height*0.45,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                                          child: CachedNetworkImage(
                                            imageUrl: item[index]['cover'],
                                            //placeholder: (context, url) => const CustomLoader(),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.06,
                                        width: MediaQuery.of(context).size.width*0.37,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.20,
                                                  child: Text(
                                                    item[index]['song'],
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                        color: Colors.blueGrey,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.20,
                                                  child: Text(
                                                    item[index]['artist'],
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.play_circle, color: Colors.blueGrey,),
                                          ],
                                        ),
                                      ),
                                    ]
                                ),
                              )
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          }else{return Container();}
        });
        }
  }