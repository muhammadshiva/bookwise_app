import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

void showCustomSnackbarError(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color(0xffED5757),
    duration: const Duration(seconds: 2),
  ).show(context);
}

void showCustomSnackbarSuccess(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color(0xff56B63C),
    duration: const Duration(seconds: 3),
  ).show(context);
}

// Future<XFile?> selectImage() async {
//   XFile? selectedImage = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//   );
//   return selectedImage;
// }
