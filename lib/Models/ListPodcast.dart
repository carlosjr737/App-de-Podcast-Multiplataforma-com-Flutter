
import '../Models/PodcastModel.dart';
import '../Widgets/CardPodcastWidget.dart';

class ListPodcast  {


   List<PodcastModel> listPodcast = [
     PodcastModel(
      title: 'Marilyn Monroe - BIO',
      description: 'Conheça a história de uma dos maiores símbolos sexuais do século 20.',
      img: 'assets/images/marilyn.jpg',
       pathMusic: 'music/marlyn.mp3'
    ),
     PodcastModel(
      title: 'Narcos',
      description: 'Top 1 mudial das sérias da Netiflix',
      img: 'assets/images/narcos.jpg',
       pathMusic: 'music/Tuyo.mp3'
    )
  ];
}