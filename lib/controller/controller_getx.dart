import 'package:get/get.dart';

class ControllerGetX extends GetxController {
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
}
