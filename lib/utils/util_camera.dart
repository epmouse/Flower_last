import 'package:camera/camera.dart';

class CameraUtils {
  static List<CameraDescription> _cameras;

 static init() async {
    _cameras = await availableCameras();
  }

  static List<CameraDescription> get cameras => _cameras;


}