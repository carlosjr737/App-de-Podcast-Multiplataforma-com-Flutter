import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:podcast_multiplataforma_dio/Controllers/PlayController.dart';
import 'package:podcast_multiplataforma_dio/Models/PodcastModel.dart';
import 'package:provider/provider.dart';
import '../app/util/custom_colors.dart';
import '../screen/PodcastSelectScreen.dart';

class CardSelecionadoWidget extends StatefulWidget {
  final String img;
  final String title;
  final String description;
  final String pathMusic;

  CardSelecionadoWidget({
    required this.img,
    required this.title,
    required this.description,
    required this.pathMusic,
  });

  @override
  State<CardSelecionadoWidget> createState() => _CardSelecionadoWidgetState();
}

class _CardSelecionadoWidgetState extends State<CardSelecionadoWidget> {
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

  Future setAudio() async {
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load(widget.pathMusic);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controle = Provider.of<PlayController>(context);

    final PodcastModel podcastModel = PodcastModel(
        img: widget.img,
        title: widget.title,
        description: widget.description,
        pathMusic: widget.pathMusic);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PodcastSelectScreen(podcastModel: podcastModel)));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [CustomColor.gray700, CustomColor.gray200],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 20),
                color: CustomColor.gray700.withOpacity(0.4),
                blurRadius: 40,
              )
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(widget.img), fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              position.toString().substring(2, 7),
                              style: TextStyle(color: Color(0xffDEDBDB)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              child: Text(
                                '/',
                                style: TextStyle(
                                  color: Color(0xffDEDBDB),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              (position - duration).toString().substring(2, 7),
                              style: TextStyle(color: Color(0xffDEDBDB)),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: CustomColor.pink700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  controle.isplaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
