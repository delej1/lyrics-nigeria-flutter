import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class GenreCard extends StatefulWidget {
  const GenreCard({Key? key}) : super(key: key);

  @override
  State<GenreCard> createState() => _GenreCardState();
}

class _GenreCardState extends State<GenreCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.width20),
      child: Column(
        children: [
          Center(child: Text("GENRES", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20),)),
          Padding(
            padding: EdgeInsets.all(Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/genre-page',
                          arguments: ["afro pop", "AFRO POP"]);
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.37,
                            height: MediaQuery.of(context).size.height*0.20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              child:Image.asset("assets/image/afropop_img.jpeg", fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.25,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
                              child: Center(
                                child: Text(
                                  "AFRO POP",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/genre-page',
                          arguments: ["R&B", "R&B"]);
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.37,
                            height: MediaQuery.of(context).size.height*0.20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              child:Image.asset("assets/image/rnb_img.jpeg", fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.25,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
                              child: Center(
                                child: Text(
                                  "R&B",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/genre-page',
                          arguments: ["hip hop", "HIP HOP"]);
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.37,
                            height: MediaQuery.of(context).size.height*0.20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              child:Image.asset("assets/image/hiphop_img.png", fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.25,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
                              child: Center(
                                child: Text(
                                  "HIP HOP",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/genre-page',
                          arguments: ["gospel", "GOSPEL"]);
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.37,
                            height: MediaQuery.of(context).size.height*0.20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              child:Image.asset("assets/image/gospel_img.jpeg", fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.25,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
                              child: Center(
                                child: Text(
                                  "GOSPEL",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
