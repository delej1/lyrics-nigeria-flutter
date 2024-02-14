import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

//dynamic height for padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  static double height160 = screenHeight / 5.28;

//dynamic width for padding and margin
  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.76;
  static double width350 = screenHeight / 2.41;
  static double width500 = screenHeight / 1.69;

//dynamic font size
  static double font10 = screenHeight / 84.4;
  static double font12 = screenHeight / 70.33;
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

//dynamic border radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

//dynamic icon size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize15 = screenHeight / 56.27;
  static double iconSize16 = screenHeight / 52.75;

//list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

//popular product size
  static double popularProductImgSize = screenHeight / 2.41;

//dynamic bottom height
  static double bottomHeightBar = screenHeight / 7.03;

  //splash screen dimensions
  static double splashImg = screenHeight / 3.38;
}
