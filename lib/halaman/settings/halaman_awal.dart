// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:fs_dart/halaman/awal/halaman_awal.dart';
import 'dart:convert';
import 'package:fs_dart/halaman/settings/settings.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

// localstorage
import 'package:localstorage/localstorage.dart';
import 'package:fs_dart/src/variables.g.dart';
// import 'package:provider/provider.dart';

import '../../src/database/db.dart';
import '../edit/filter.dart';

// import 'package:analytics/analytics.dart';

class HalamanAwalSettings extends StatefulWidget {
  const HalamanAwalSettings({super.key});

  // final CameraDescription camera;
  @override
  State<HalamanAwalSettings> createState() => _HalamanAwalSettingsState();
}

class _HalamanAwalSettingsState extends State<HalamanAwalSettings> {
  // ...
  // final CameraDescription camera;
  final LocalStorage storage = new LocalStorage('parameters');

  var db = new Mysql();
  var pin = '';
  var bg_image = "";
  // var serial_key = '';

  //
  var judul;
  var deskripsi;

  List<dynamic> serial_key = [];

  _HalamanAwalSettingsState();

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();

    getSerialKey();
    getSettings();
    super.initState();
  }

  Route _routeAnimate(halaman) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => halaman,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.bounceIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  getSerialKey() async {
    // print("get sesi data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `serial_key`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {});
            serial_key.add(row);
          } // Finally, close the connection
        }).then((value) {
          print("object serial key : $serial_key");
          print("serial key length : ${serial_key.length}");
        });
        return value.close();
      },
    );
  }

  getSettings() async {
    // print("get sesi data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `settings`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              judul = row[1];
              deskripsi = row[2];
              pin = row[3];
              bg_image = row[6];
            });
          } // Finally, close the connection
        }).then((value) => print("object pin : $pin"));
        return value.close();
      },
    );
  }

  _clearStorage() async {
    await storage.clear();
  }

  _saveStorage() async {
    await storage.setItem('title', "Title parameter dari localstorage");
  }

  final double barHeight = 10.0;

  // colors wave

  // end statements color waves
  // end statements color waves

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    // final state = context.watch<PhotoboothBloc>().state;
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.12,
              width: width * 1,
              color: Color.fromARGB(255, 116, 24, 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 1,
                    width: width * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Variables.ipv4_local}/storage/background-image/main/$bg_image"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: width * 0.001),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            judul.toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: width * 0.0275,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            deskripsi.toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: width * 0.01,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        _showMyDialog("settings");
                      },
                      child: const Icon(
                        Icons.settings,
                        size: 55,
                        color: Color.fromARGB(255, 48, 48, 48),
                        semanticLabel: "Settings",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        _showMyDialog("order");
                      },
                      child: const Icon(
                        Icons.home,
                        size: 55,
                        color: Color.fromARGB(255, 48, 48, 48),
                        semanticLabel: "Order",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: height * 0.055,
            ),
            Container(
              // color: Color.fromARGB(255, 255, 123, 145),
              height: width * 0.36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                    ),
                    elevation: 1,
                    color: Color.fromARGB(255, 161, 13, 62),
                    child: InkWell(
                      onTap: () {
                        print("edit foto page");
                      },
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: width * 0.13,
                          bottom: width * 0.13,
                          left: width * 0.05,
                          right: width * 0.05,
                        ),
                        child: Text(
                          "Halaman Settings",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(type == "settings" ? 'Menu Settings' : "Menu Order"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(type == "settings"
                    ? 'Apakah Anda Ingin Ke Menu Settings ?'
                    : "Apakah Anda Ingin Ke Menu Order ?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                // _showMyDialogPin(pin);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Iya'),
              onPressed: () {
                type == "settings"
                    ? _showMyDialogPin(pin)
                    : Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: HalamanAwal(),
                            inheritTheme: true,
                            ctx: context),
                      );
                ;
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogPin(pins) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Masukkan Pin'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == pins.toString() ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      print(pin);
                      if (pin == pins.toString()) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         SettingsWidget(),
                        //   ),
                        // );
                        // Navigator.of(context)
                        //     .push(_routeAnimate(SettingsWidget()));

                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SettingsWidget(),
                              inheritTheme: true,
                              ctx: context),
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Kembali'),
              onPressed: () {
                // _dialogPin(pin);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogPin(pins) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: 100,
            height: 40,
            color: Colors.transparent,
            child: Card(
              color: Colors.transparent,
              // color: Colors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 40,
                  child: AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 24, 116, 59),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 0),
                      child: Text(
                        "Masukkan Pin".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 56,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Pinput(
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        validator: (s) {
                          return s == pins.toString()
                              ? null
                              : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) {
                          print(pin);
                          if (pin == pins.toString()) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         _routeAnimate(SettingsWidget()),
                            //   ),
                            // );
                            // Navigator.of(context)
                            //     .push(_routeAnimate(SettingsWidget()));

                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SettingsWidget(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                    actions: <Widget>[
                      // MainAxisAlignment.spaceAround,
                      OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Kembali'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const Spacer(),
                      OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Lanjut'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         _routeAnimate(HalamanAwalSettings()),
                          //   ),
                          // );
                          // Navigator.of(context)
                          //     .push(_routeAnimate(HalamanAwalSettings()));

                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: HalamanAwalSettings(),
                                inheritTheme: true,
                                ctx: context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  ),
);