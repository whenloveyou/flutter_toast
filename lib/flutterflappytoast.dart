import 'dart:async';

import 'package:flutter/services.dart';

enum ToastGravity {
  BOTTOM,
  CENTER,
  TOP,
}

class Flutterflappytoast {
  //channel
  static const MethodChannel _channel =
      const MethodChannel('flutterflappytoast');

  //显示吐司
  static Future<String> showToast(String toast, ToastGravity gravity) async {
    int gravityInt = 0;
    if (gravity == ToastGravity.BOTTOM) {
      gravityInt = 0;
    }
    if (gravity == ToastGravity.CENTER) {
      gravityInt = 1;
    }
    if (gravity == ToastGravity.TOP) {
      gravityInt = 2;
    }
    //返回视频的地址
    final String flag = await _channel.invokeMethod(
        'showToast', {"toast": toast, "gravity": gravityInt.toString()});
    return flag;
  }
}
