//?phone padding
import 'dart:math';

const double kPagePaddingHorizontal = 6.0;
const double kPagePaddingVertial = 5.0;

//?constant bool
const bool kTrue = true;
const bool kFalse = false;

dynamic listImageAssets = [
  "assets/avatars/1.png",
  "assets/avatars/2.png",
  "assets/avatars/3.png",
  "assets/avatars/4.png",
  "assets/avatars/5.png",
  "assets/avatars/6.png",
  "assets/avatars/7.png",
  "assets/avatars/8.png",
];

Random random = Random();
String randomAvatarImageAsset() {
  int r = random.nextInt(8);
  return listImageAssets[r].toString();
}

//?default profile image
const String kDefaultProfile =
    'https://raw.githubusercontent.com/MarbertMataverde/WeConnect/873f000f105de08013bd1aae43a01f72c66816ad/assets/avatars/default_avatar.png';

//post image placeholder
const String kPostImagePlaceholder = 'assets/gifs/image_loading.gif';
