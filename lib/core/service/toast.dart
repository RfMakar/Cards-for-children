import 'package:fluttertoast/fluttertoast.dart';


abstract class ToastService {
  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0,
    );
  }
}