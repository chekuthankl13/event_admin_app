import 'package:event_admin/core/config/config.dart';
import 'package:flutter/material.dart';

sW(context) => MediaQuery.of(context).size.width;
sH(context) => MediaQuery.of(context).size.height;

Widget spaceHeight(val) => SizedBox(height: double.parse(val.toString()));
spaceWidth(val) => SizedBox(width: double.parse(val.toString()));

errorToast(context, {msg}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

Widget empty() => SizedBox();

Widget itemEmpty(context, txt) => Column(
  spacing: 20,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // spaceHeight(sH(context) / 3),
    Center(child: Text(txt)),
  ],
);

Widget loading({clr = Config.violetClr, double size = 40.0}) =>
    Center(child: CircularProgressIndicator(color: clr, strokeWidth: 1));

Widget errorIc({size}) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  spacing: 10,
  children: [
    Image.asset("assets/images/error.png", height: size, fit: BoxFit.contain),
    Text(
      "Failed to load Image !!",
      style: TextStyle(color: Config.redAccentLigthClr),
    ),
  ],
);
Widget scafoldloading({clr = Config.violetClr, size = 40.0, txt}) => Scaffold(
  appBar: AppBar(title: Text(txt)),
  body: Center(child: CircularProgressIndicator(color: clr, strokeWidth: 1)),
);

scafolderror(String error, txt, {required onPressed}) {
  return Scaffold(
    appBar: AppBar(title: Text(txt)),
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset("assets/images/error.gif",
            //   height: 200,),
            Image.asset("assets/images/error.png", height: 200),
            ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(120, 40),
                foregroundColor: Colors.white,
                backgroundColor: Config.violetClr,
              ),
              label: Text("Retry"),
              icon: Icon(Icons.restore_outlined, color: Colors.white),
            ),
            Text(error, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}

error(String error, {required onPressed}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        // SvgPicture.asset("assets/images/error.gif", height: 200),
        Image.asset("assets/images/error.png", height: 200),
        ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: Size(120, 40),
            foregroundColor: Colors.white,
            backgroundColor: Config.violetClr,
          ),
          label: Text("Retry"),
          icon: Icon(Icons.restore_outlined, color: Colors.white),
        ),
        Text(error, textAlign: TextAlign.center),
      ],
    ),
  );
}

isTab(context) => sW(context) >= 700 && sW(context) <= 1200 ? true : false;

isDesktop(context) => sW(context) >= 1200 ? true : false;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
