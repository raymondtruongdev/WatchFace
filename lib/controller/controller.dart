import 'package:get/state_manager.dart';

class GlobalController extends GetxController {
  final RxDouble _watchSize = 0.0.obs;

  RxDouble getWatchSize() => _watchSize;

  @override
  void onInit() {
    _watchSize.value = 1080.0;

    super.onInit();
  }

  void updateWatchSize(double widthScreenDevice) {
    // If widthScreenDevice <       0   : _watchSize = 0;
    // If widthScreenDevice > maxScreen : _watchSize = maxScreen;
    // If 0 <= widthScreenDevice <= maxScreen : _watchSize = widthScreenDevice;
    double maxScreen = 1080.0; // 384.0;
    _watchSize.value = widthScreenDevice.clamp(0, maxScreen);
  }
}
