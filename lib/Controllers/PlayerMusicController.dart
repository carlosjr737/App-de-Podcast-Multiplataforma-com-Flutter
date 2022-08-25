import '../Models/PodcastModel.dart';
import '../Widgets/CardSelectWidget.dart';

class PlayerMusicController {
  bool isPlay = false;

  CardSelecionadoWidget? cardSelecionadoWidget;

  void SelectMusic(PodcastModel podcastModel) {
    isPlay = !isPlay;
    cardSelecionadoWidget = CardSelecionadoWidget(
      img: podcastModel.img,
      title: podcastModel.title,
      description: podcastModel.description,
      pathMusic: podcastModel.pathMusic,
    );
  }
}
