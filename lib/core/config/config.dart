import 'package:flutter/material.dart';

class Config {
  static const whiteClr = Colors.white;
  static Color greyClr = Colors.grey.shade400;

  static Color grey2Clr = Colors.grey.shade600;

  static const violetClr = Color.fromARGB(255, 0, 35, 95);

  static const redAccentLigthClr = Color.fromARGB(255, 250, 139, 139);

  static const __baseUrl = 'http://10.0.2.2:3030/api/';

  static const loginUrl = "${__baseUrl}admin/login";

  static const eventUrl = "${__baseUrl}event";
  
}
