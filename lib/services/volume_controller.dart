

import 'dart:async';

import 'package:volume_controller/volume_controller.dart';

class VolumeControl {
  static final VolumeController controller = VolumeController.instance;

static Future<void> setVolume(double volume) async{
  await controller.setVolume(volume);
}
  
  
}