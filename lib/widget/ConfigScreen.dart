import 'package:flutter/cupertino.dart';
import 'package:realestateapp/widget/constant.dart';

enum ScreenType { SMALL, MEDIUM, LARGE, XLARGE }

class ConfigScreen {
  double screenWidth;
  double screenHeight;
  ScreenType screenType;

  ConfigScreen(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    _setScreen();
  }

  void _setScreen() {
    if (this.screenWidth >= 320 && this.screenWidth < 375)
      this.screenType = ScreenType.SMALL;
    else if (this.screenWidth >= 375 && this.screenWidth < 414)
      this.screenType = ScreenType.MEDIUM;
    else if (this.screenWidth >= 414 && this.screenWidth < 550)
      this.screenType = ScreenType.LARGE;
    else
      this.screenType = ScreenType.XLARGE;
  }
}

class WidgetSize {
  ConfigScreen configScreen;
  WidgetSize(ConfigScreen configScreen) {
    this.configScreen = configScreen;
    initValue();
  }
  void initValue() {
    if (configScreen.screenHeight >= 480 && configScreen.screenHeight < 588) {
      Constant.cardHeight = 0.2;
//      Constant.productImageHeight = 0.241;
    } else if (configScreen.screenHeight >= 588 &&
        configScreen.screenHeight < 736) {
      Constant.cardHeight = 0.17;
//      Constant.productImageHeight = 0.230;
    } else if (configScreen.screenHeight >= 736 &&
        configScreen.screenHeight < 812) {
      Constant.cardHeight = 0.199;
//      Constant.productImageHeight = 0.240;
    } else {
      Constant.cardHeight = 0.209;
//      Constant.productImageHeight = 0.250;
    }

    if (configScreen.screenType == ScreenType.SMALL) {
      Constant.fontTitleSize = 16;
      Constant.fontDescriptionSize = 12;
      Constant.fontMoreInfoSize = 16;
      Constant.verificaionTextSize = 23;
    } else if (configScreen.screenType == ScreenType.MEDIUM) {
      Constant.fontTitleSize = 18;
      Constant.fontDescriptionSize = 12;
      Constant.fontMoreInfoSize = 13;
      Constant.verificaionTextSize = 25;
    } else if (configScreen.screenType == ScreenType.LARGE) {
      Constant.fontTitleSize = 22;
      Constant.fontDescriptionSize = 14;
      Constant.fontMoreInfoSize = 16;
      Constant.verificaionTextSize = 27;
    } else if (configScreen.screenType == ScreenType.XLARGE) {
      Constant.fontTitleSize = 24;
      Constant.fontDescriptionSize = 16;
      Constant.fontMoreInfoSize = 18;
      Constant.verificaionTextSize = 29;
    }
  }
}

// }
