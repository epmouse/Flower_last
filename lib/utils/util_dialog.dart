import 'package:flower_last/utils/util_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogUtils {
  static Future<T> showFlowerDialog<T>({
    @required BuildContext context,
    bool canDismissible = true,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: canDismissible,
        builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .copyWith(textScaleFactor: 1),
            child: SafeArea(child: SpinKitWave(
              size: 30,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                );
              },
            )),
          );
        });
  }
}
