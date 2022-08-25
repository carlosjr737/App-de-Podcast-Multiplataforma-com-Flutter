import 'package:flutter/material.dart';
import 'package:podcast_multiplataforma_dio/Models/ListCategory.dart';
import 'package:provider/provider.dart';
import '../Controllers/PlayerMusicController.dart';
import '../Models/ListPodcast.dart';
import '../Models/PodcastModel.dart';
import '../Widgets/CardPodcastWidget.dart';
import '../Widgets/CardSelectWidget.dart';
import '../Widgets/CategoryWidget.dart';
import '../app/util/custom_colors.dart';

PlayerMusicController playerMusicController = PlayerMusicController();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isPlay = false;

class _MyAppState extends State<MyApp> {
  CardSelecionadoWidget? cardSelecionadoWidget;

  void play(PodcastModel podcastModel) {
    setState(() {
      playerMusicController.isPlay = !playerMusicController.isPlay;
      cardSelecionadoWidget = new CardSelecionadoWidget(
          img: podcastModel.img,
          title: podcastModel.title,
          description: podcastModel.description,
        pathMusic: podcastModel.pathMusic);

    });
  }

  @override
  Widget build(BuildContext context) {
    final ListCategory _listCategory = Provider.of<ListCategory>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: 50, child: Image.asset("assets/images/logo.png")),
            Row(
              children: [
                Text(
                  "Dio",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Cast",
                  style: TextStyle(
                      color: CustomColor.pink700,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 68.0,bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'PodCast Recente',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18.0, left: 8, right: 8),
                      child: Container(
                        height: height - appBar.preferredSize.height,
                        child: ListView.builder(
                          itemCount: ListPodcast().listPodcast.length,
                          itemBuilder: (contex, indice) {
                            ListPodcast listPodcast = ListPodcast();
                            var podcast = listPodcast.listPodcast[indice];
                            return CardPodCast(
                              podcastModel: podcast,
                              click: () {
                                play(podcast);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _listCategory.listTags.length,
                          itemBuilder: (context, index) {
                            var category = _listCategory.listTags[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, right: 3),
                              child: CategoryWidget(text: category.text),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            playerMusicController.isPlay
                ? Positioned(
                    bottom: 1,
                    width: width,
                    child: Container(height: 100, child: cardSelecionadoWidget),
                  )
                : Container(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: CustomColor.pink700,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Pesquisar", icon: Icon(Icons.search_rounded)),
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.grid_view)),
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.account_circle_outlined)),
          ],
        ),
      ),
    );
  }
}
