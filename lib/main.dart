import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:podcast_multiplataforma_dio/Controllers/PlayerMusicController.dart';
import 'package:podcast_multiplataforma_dio/screen/HomeListPodcastScreen.dart';
import 'package:provider/provider.dart';
import 'Controllers/PlayController.dart';
import 'Models/ListCategory.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(MultiProvider(
    providers: [
      Provider<PlayerMusicController>(create: (_) => PlayerMusicController()),
      Provider<PlayController>(create: (_) => PlayController()),
      Provider<ListCategory>(create: (_) => ListCategory()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyApp(),
    ),
  ));
}

