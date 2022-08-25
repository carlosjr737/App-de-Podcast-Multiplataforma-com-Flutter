import 'package:flutter/material.dart';
import 'package:podcast_multiplataforma_dio/Controllers/PlayerMusicController.dart';
import 'package:podcast_multiplataforma_dio/Models/PodcastModel.dart';
import 'package:podcast_multiplataforma_dio/app/util/custom_colors.dart';
import 'package:provider/provider.dart';


class CardPodCast extends StatefulWidget {
  final PodcastModel podcastModel;
  final Function click;

  const CardPodCast({
    Key? key,
    required this.podcastModel,
    required this.click,

  }) : super(key: key);

  @override
  State<CardPodCast> createState() => _CardPodCastState();
}
PlayerMusicController controllerSelectCard = PlayerMusicController();
bool isPlaying = true;

class _CardPodCastState extends State<CardPodCast> {
  @override
  Widget build(BuildContext context) {
    final _recuperaPlayerMusic = Provider.of<PlayerMusicController>(context);

    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(widget.podcastModel.img),
                      fit: BoxFit.cover)),
            ),
            Container(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.podcastModel.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: width/2,
                    child: Text(
                      widget.podcastModel.description,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color:
                isPlaying ? CustomColor.pink700 : CustomColor.blue200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                  onTap: () {
                    _recuperaPlayerMusic.SelectMusic(widget.podcastModel);
                    widget.click();
                  },
                  child: Icon(isPlaying ? Icons.play_arrow : Icons.pause)),
            ),
          ],
        ),
      ),
    );
  }
}
