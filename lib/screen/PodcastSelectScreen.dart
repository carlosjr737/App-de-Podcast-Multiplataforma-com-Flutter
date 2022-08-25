import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:podcast_multiplataforma_dio/Models/PodcastModel.dart';
import 'package:podcast_multiplataforma_dio/app/util/custom_colors.dart';

class PodcastSelectScreen extends StatefulWidget {

  final PodcastModel podcastModel;
  @override
  State<PodcastSelectScreen> createState() => _PodcastSelectScreenState();

  PodcastSelectScreen({ required this.podcastModel});
}

class _PodcastSelectScreenState extends State<PodcastSelectScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });

      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    });
  }

  Future forward30Seconds() async {
    Duration newDuranton = Duration(seconds: 30);
    var result = position + newDuranton;
    var teste = await audioPlayer.getDuration();
    if (result.inMilliseconds > teste) {
      print('chega');
    } else {
      audioPlayer.seek(result);
    }
  }

  Future back30Seconds() async {
    Duration newDuranton = Duration(seconds: 30);
    var result = position - newDuranton;
    if (result.isNegative) {
    } else {
      audioPlayer.seek(result);
    }
  }

  Future setAudio() async {
    final player = AudioCache(prefix: 'assets/');
    // final url = await player.load('music/Tuyo.mp3');
    final url = await player.load(widget.podcastModel.pathMusic);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5],
                            colors: [Color(0xff898b97), Color(0xff3d3a4b)]),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5],
                            colors: [Color(0xff898b97), Color(0xff3d3a4b)]),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.build),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      offset: Offset(0,20),
                      blurRadius: 100,
                      color: CustomColor.pink700.withOpacity(0.7)
                    )
                  ]
                ),
                height: 220,
                width: 220,
                child: Image.asset(
                  widget.podcastModel.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.podcastModel.title,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    widget.podcastModel.description,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffeceff8),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      color: Color(0xffa1a3af),
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffeceff8),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      color: Color(0xffa1a3af),
                      onPressed: () {},
                      icon: Icon(Icons.download_rounded),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffeceff8),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      color: Color(0xffa1a3af),
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                    ),
                  ),
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text(
                position.toString().substring(2,7),
              ),
              Slider(
                activeColor: CustomColor.pink700,
                thumbColor: CustomColor.pink700,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);
                  await audioPlayer.resume();
                },
              ),
              Text((duration - position).toString().substring(2,7)),
            ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                height: 100,
                color: Color(0xffeceff8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        color: Color(0xff414858),
                        iconSize: 40,
                        onPressed: back30Seconds,
                        icon: Icon(Icons.replay_30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                offset: Offset(0,30),
                                blurRadius: 100,
                                color: CustomColor.pink700.withOpacity(0.7)
                            )
                          ]
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustomColor.pink700,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 50,
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer.resume();
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        color: Color(0xff414858),
                        iconSize: 40,
                        onPressed: forward30Seconds,
                        icon: Icon(Icons.forward_30),
                      ),
                    )
                  ],
                ),
              ),
            )          ],
        ),
      ),
    );
  }
}
