import 'package:event_admin/core/config/config.dart';
import 'package:event_admin/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBtn {
  ElevatedButton normal({
    required size,
    required txt,
    required onPressed,
    color = Config.violetClr,
    fcolor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: size,
        foregroundColor: fcolor,
        backgroundColor: color,
      ),
      child: Text(txt, style: const TextStyle(fontSize: 17)),
    );
  }

  ElevatedButton loader({required size}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: size,
        foregroundColor: Colors.white,
        backgroundColor: Config.redAccentLigthClr,
      ),
      child: loading(clr: Config.whiteClr, size: 20),
    );
  }
}