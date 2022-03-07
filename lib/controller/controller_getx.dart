import 'package:get/get.dart';

class ControllerGetX extends GetxController {
  //channel text form file state
  bool textFieldEmptySend = true;
  bool textFieldEmptyUpload = true;
  emptyTextFieldForSendButton(bool isEmpty) {
    textFieldEmptySend = isEmpty;
    update();
  }

  emptyTextFieldForUploadButton(bool isEmpty) {
    textFieldEmptyUpload = isEmpty;
    update();
  }

  //channel announcement tile
}
