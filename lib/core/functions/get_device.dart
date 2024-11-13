import 'dart:io' show Platform;

String getDevice()  {
  String os = Platform.operatingSystem;
  return os;
}
