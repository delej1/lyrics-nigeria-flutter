import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lyrics_nigeria_flutter/base/custom_loader.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder:(context, snapshot){
              if(snapshot.hasData){
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;

                if(processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering){
                  return Container(
                    width: Dimensions.width10*5,
                    height: Dimensions.height10*5,
                    margin: EdgeInsets.all(Dimensions.width10),
                    child: const CustomLoader(),);
                }else if (!audioPlayer.playing){
                  return IconButton(
                      onPressed: audioPlayer.play,
                      iconSize: Dimensions.iconSize15*5,
                      icon: const Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      )
                  );
                }else if(processingState != ProcessingState.completed){
                  return IconButton(
                      onPressed: audioPlayer.pause,
                      iconSize: Dimensions.iconSize15*5,
                      icon: const Icon(
                        Icons.pause_circle,
                        color: Colors.white,
                      )
                  );
                }else{
                  return IconButton(
                      onPressed: () => audioPlayer.seek(
                          Duration.zero,
                          index: audioPlayer.effectiveIndices!.first),
                      iconSize: Dimensions.iconSize15*5,
                      icon: const Icon(
                        Icons.replay_circle_filled_outlined,
                        color: Colors.white,
                      )
                  );
                }
              }else{
                return Container(
                    width: Dimensions.width20,
                    height: Dimensions.height20,
                    margin: EdgeInsets.all(Dimensions.width10),
                    child: const CustomLoader());
              }
            }),
      ],
    );
  }
}
