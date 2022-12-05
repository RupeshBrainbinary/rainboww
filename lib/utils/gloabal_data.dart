import 'dart:typed_data';

import 'package:rainbow_new/model/user_model.dart';


class GlobalData {
  static UserModel user = UserModel();
  static String chatId = '';

  // static  AudioPlayer player = AudioPlayer();

  static late Uint8List audiobytes;
  static String audioasset = "assets/audio/red-indian-music.mp3";
}
