// import 'package:camera/camera.dart';
// ignore_for_file: override_on_non_overriding_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../src/database/db.dart';
import 'package:window_manager/window_manager.dart';

// localstorage
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;
import '../../src/variables.g.dart';
import '../edit/filter.dart';
import 'dart:async';
import 'dart:io';

class HalamanAwal extends StatefulWidget {
  const HalamanAwal({super.key});

  // final CameraDescription camera;
  @override
  State<HalamanAwal> createState() => _HalamanAwalState();
}

class _HalamanAwalState extends State<HalamanAwal> {
  // ...
  // final CameraDescription camera;
  final LocalStorage storage = new LocalStorage('serial_key');

  var db = new Mysql();
  var pin = '';

  List<dynamic> serial_key = [];
  List<dynamic> key = [];

  List<dynamic> main_color = [];
  List<dynamic> background = [];

  bool isDialogSerialKey = true;

  var users;
  var serial_key_storage;

  late Timer _timer;
  int waktu_awal = 10;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  String headerImg = "";
  String bgImg = "";

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  _HalamanAwalState();

  @override
  void initState() {
    // TODO: implement initState
    // timerPeriodFunc();
    _saveStorage();
    // _clearStorage();

    // initFullScreen();

    getStorageSerial();
    getOrderSettings();
    // getUsers();
    getWarnaBg();

    super.initState();
  }

  void getStorageSerial() async {
    var ready = await storage.ready;

    print("status ready storage : $ready");
    if (ready == true) {
      setState(() {});

      serial_key_storage = await storage.getItem('serial_keys');

      print("serial_key_storage : $serial_key_storage");
      if (serial_key_storage == null) {
        getSerialKey();
      } else {
        // ...
        getSerialKey();
      }
    } else {
      // ...
    }
  }

  getSerialKey() async {
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/serial-key'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      serial_key.addAll(result);
      // print("serial_key : ${serial_key}");
      for (var element in serial_key) {
        key.add(element["serial_key"]);
      }
      print("element serial key : ${key}");
    } else {
      print(response.reasonPhrase);
    }
  }

  getWarnaBg() async {
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/main-color'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      main_color.addAll(result);
      // print("main_color : ${main_color}");
      for (var element in main_color) {
        // print("element : ${element["bg_warna_wave"]}");
        setState(() {
          bg_warna_main = element["bg_warna_wave"];
          warna1 = element["warna1"];
          warna2 = element["warna2"];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // ...
  getOrderSettings() async {
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/order-get'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      background.addAll(result);
      print("background : ${background}");
      for (var element in background) {
        print("background_image : ${element["background_image"]}");
        setState(() {
          headerImg = element["header_image"];
          bgImg = element["background_image"];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> timerPeriodFunc() async {
    // ...
    // new timer periodic
    var counter = 10;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // print(timer.tick);
      counter--;
      if (counter == 0) {
        print('Cancel timer');
        timer.cancel();
      }
    });
    // ...

    // timer not running ...
    // const oneSec = const Duration(seconds: 1);
    // _timer = new Timer.periodic(
    //   oneSec,
    //   await (Timer timer) {
    //     if (waktu_awal != 0) {
    //       setState(() {
    //         waktu_awal - 1;
    //       });
    //     } else {
    //       setState(() {
    //         timer.cancel();
    //       });
    //       initFullScreen();
    //     }
    //   },
    // );
  }

  void initFullScreen() async {
    print("init fullscreen");
    // init fullscreen ...

    // // hide / minimize app
    // await windowManager.ensureInitialized();

    // WindowOptions windowOptions = const WindowOptions(
    //   size: Size(0, 0),
    //   center: true,
    //   backgroundColor: Colors.transparent,
    //   skipTaskbar: false,
    //   titleBarStyle: TitleBarStyle.hidden,
    // );
    // windowManager.waitUntilReadyToShow(windowOptions, () async {
    //   await windowManager.hide();
    // });
  }

  void hideApp() async {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(0, 0),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.hide();
    });
  }

  Future<void> _dialogSerialKey(serialKey) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              textAlign: TextAlign.center,
              'Masukkan Serial Key'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    length: 10,
                    validator: (s) {
                      return s == serialKey.toString()
                          ? "Serial Key Benar / Bisa Dipakai"
                          : 'Serial Key Salah / Kadaluarsa';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (keys) {
                      print(keys);
                      for (var i = 0; i < serial_key.length; i++) {
                        if (keys == serialKey[i].toString()) {
                          print("serial key benar");
                          setState(() {
                            isDialogSerialKey = false;
                          });
                          _saveStorageSerialKey(keys);

                          Navigator.of(context).pop();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SettingsWidget(),
                          //   ),
                          // );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Kembali'),
          //     onPressed: () {
          //       // _dialogPin(pin);
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  // getUsers() async {
  //   final conn = await MySqlConnection.connect(
  //     ConnectionSettings(
  //       host: 'localhost',
  //       port: 3306,
  //       user: 'root',
  //       db: 'foto_selfi',
  //       password: 'rama4422',
  //       // host: "217.21.72.2",
  //       // port: 3306,
  //       // user: 'n1575196_foto_selfie_flutter',
  //       // db: 'n1575196_foto_selfie_flutter',
  //       // password: '%;Eq}m3Wjy{&',
  //     ),
  //   ).whenComplete(
  //     () {
  //       // ignore: avoid_print
  //       print('');
  //     },
  //   );
  //   // // Query again database using a parameterized query
  //   var results2 = await conn.query('SELECT * FROM `user_fotos`');

  //   for (var row in results2) {
  //     setState(() {
  //       users = row;
  //       // jumlahVoucher = count as int;
  //     });
  //   }
  // }

  _clearStorage() async {
    await storage.clear();
  }

  _saveStorage() async {
    await storage.setItem('title', "Title parameter dari localstorage");
  }

  _saveStorageSerialKey(key) async {
    print("save storage serial keys : $key");
    await storage.setItem('serial_keys', "$key");
  }

  final double barHeight = 10.0;

  // colors wave
  static const _backgroundColor = Color.fromARGB(255, 196, 75, 146);

  List<Color> _colors = [
    Color.fromARGB(255, 212, 111, 170),
    Color.fromARGB(255, 252, 175, 229),
  ];

  static const _durations = [
    10000,
    75000,
  ];

  static const _heightPercentages = [
    0.90,
    0.70,
  ];
  // end statements color waves

  Route _routeAnimate(halaman) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => halaman,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "${Variables.ipv4_local}/storage/order/background-image/$bgImg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------
            // header page view
            // ----------------
            Container(
              height: height * 0.12,
              width: width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.ipv4_local}/storage/order/header-image/$headerImg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // color: Color.fromARGB(255, 24, 116, 59),
                    child: Column(
                      children: [
                        Container(
                          height: width * 0.035,
                          width: width * 1,
                          color: bg_warna_main != ""
                              ? Color(int.parse(bg_warna_main))
                              : Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: bg_warna_main != ""
                                          ? Color(int.parse(bg_warna_main))
                                          : Colors.transparent,
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    //
                                    // _dialogBuilder(
                                    //     context,
                                    //     "Aplikasi",
                                    //     "Ingin Minimize Aplikasi Foto Selfie ?",
                                    //     1);
                                    _showMyDialog(
                                        "Aplikasi",
                                        "Ingin Minimize Aplikasi Foto Selfie ?",
                                        1);
                                    // timerPeriodFunc();
                                    // timer disini untuk show app kembali
                                  },
                                  child: Icon(
                                    size: 35.0,
                                    Icons.move_down,
                                    color: Colors.white,
                                    semanticLabel: "Minimize",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Container(
                                // margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.transparent,
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    //
                                    // _dialogBuilder(
                                    //     context,
                                    //     "Aplikasi",
                                    //     "Ingin Menutup Aplikasi Foto Selfie ?",
                                    //     2);
                                    _showMyDialog(
                                        "Aplikasi",
                                        "Ingin Menutup Aplikasi Foto Selfie ?",
                                        2);
                                  },
                                  child: Icon(
                                    size: 35.0,
                                    Icons.cancel,
                                    color: Colors.white,
                                    semanticLabel: "Close",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                            ],
                          ),
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(15.0),
                          //         child: InkWell(
                          //           onTap: () {
                          //             // _showMyDialog();
                          //           },
                          //           child: Center(
                          //             child: Icon(
                          //               Icons.minimize,
                          //               size: 55,
                          //               color: Color.fromARGB(255, 22, 22, 22),
                          //               semanticLabel: "Settings",
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(15.0),
                          //         child: InkWell(
                          //           onTap: () {
                          //             // _showMyDialog();
                          //           },
                          //           child: const Icon(
                          //             Icons.close,
                          //             size: 55,
                          //             color: Color.fromARGB(255, 22, 22, 22),
                          //             semanticLabel: "Settings",
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                        Container(
                          height: height * 0.035,
                          width: width * 1,
                          child: WaveWidget(
                            config: CustomConfig(
                              colors: [
                                warna1 != ""
                                    ? Color(int.parse(warna1))
                                    : Colors.transparent,
                                warna2 != ""
                                    ? Color(int.parse(warna2))
                                    : Colors.transparent
                              ],
                              durations: _durations,
                              heightPercentages: _heightPercentages,
                            ),
                            backgroundColor: pickerColor,
                            size: const Size(double.infinity, double.infinity),
                            waveAmplitude: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  Container(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            25,
                          ),
                        ),
                      ),
                      elevation: 1,
                      color: Color.fromARGB(218, 33, 33, 33),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            25,
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const OrderWidget(),
                          //   ),
                          // );

                          // Navigator.of(context)
                          //     .push(_routeAnimate(OrderWidget()));

                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: OrderWidget(),
                                inheritTheme: true,
                                ctx: context),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: width * 0.07,
                            bottom: width * 0.07,
                            left: width * 0.01,
                            right: width * 0.01,
                          ),
                          child: Text(
                            "   ORDER   ",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.034,
                  ),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                    ),
                    elevation: 1,
                    color: Color.fromARGB(218, 33, 33, 33),
                    child: InkWell(
                      onTap: () {
                        print("edit foto page");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         const LockScreenFotoEditWidget(
                        //             // camera: camera,
                        //             ),
                        //   ),
                        // );

                        Navigator.of(context)
                            .push(_routeAnimate(LockScreenFotoEditWidget()));
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LockScreenFotoEditWidget(),
                              inheritTheme: true,
                              ctx: context),
                        );
                        // _dialogChangeColor();
                      },
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: width * 0.035,
                          bottom: width * 0.035,
                          left: width * 0.05,
                          right: width * 0.05,
                        ),
                        child: Text(
                          "EDIT\nPHOTO",
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

  Future<void> _showMyDialog(title, deskripsi, stage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(deskripsi),
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
              onPressed: () async {
                if (stage == 1) {
                  // ...
                  await windowManager.ensureInitialized();
                  WindowOptions windowOptions = const WindowOptions(
                    size: Size(0, 0),
                    center: true,
                    backgroundColor: Colors.transparent,
                    skipTaskbar: false,
                    titleBarStyle: TitleBarStyle.hidden,
                  );
                  windowManager.waitUntilReadyToShow(windowOptions, () async {
                    await windowManager.hide();
                  });
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  exit(0);

                  // ...
                }
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, title, content, stage) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.transparent,
        child: Card(
          color: Colors.transparent,
          // color: Colors.lightBlue,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: AlertDialog(
              backgroundColor: const Color.fromARGB(255, 24, 116, 59),
              title: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 56,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
                      'Tidak'.toUpperCase(),
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
                      'Iya'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    stage == 2
                        ? exit(0)
                        : await windowManager.ensureInitialized();

                    WindowOptions windowOptions = const WindowOptions(
                      size: Size(0, 0),
                      center: true,
                      backgroundColor: Colors.transparent,
                      skipTaskbar: false,
                      titleBarStyle: TitleBarStyle.hidden,
                    );
                    windowManager.waitUntilReadyToShow(windowOptions, () async {
                      await windowManager.hide();
                    });
                    // Navigator.of(context).pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HalamanAwal(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 18,
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
