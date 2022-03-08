import 'package:get/get.dart';

class ControllerGetX extends GetxController {
  //channel text form file state
  bool textFieldEmptySend = true;
  bool textFieldEmptyUpload = true;
  bool filesEmpty = true;
  emptyTextFieldForSendButton(bool isEmpty) {
    textFieldEmptySend = isEmpty;
    update();
  }

  emptyTextFieldForUploadButton(bool isEmpty) {
    textFieldEmptyUpload = isEmpty;
    update();
  }

  emptyFilesForSendButton(bool isEmpty) {
    filesEmpty = isEmpty;
    update();
  }

  bool fileIconButtonEnable = true;
  reEnableSelectFileIconButton(bool iconButtonEnable) {
    fileIconButtonEnable = iconButtonEnable;
  }

  bool imageIconButtonEnable = true;
  reEnableSelectImageIconButton(bool iconButtonEnable) {
    imageIconButtonEnable = iconButtonEnable;
  }
}
