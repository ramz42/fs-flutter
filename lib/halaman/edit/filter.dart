// ignore_for_file: duplicate_import, unused_import, unused_local_variable

import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fs_dart/halaman/edit/layout.dart';
import 'package:localstorage/localstorage.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import '../awal/halaman_awal.dart';
import '../../src/database/db.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:ui';

class FilterWidget extends StatefulWidget {
  FilterWidget({
    super.key,
    required this.nama,
    required this.title,
    required this.backgrounds,
  });
  final nama;
  final title;
  final backgrounds;

  @override
  State<FilterWidget> createState() => _FilterWidgetState(
        nama,
        title,
        backgrounds,
      );
}

class _FilterWidgetState extends State<FilterWidget> {
  _FilterWidgetState(
    this.nama,
    this.title,
    this.backgrounds,
  );

  final nama;
  final title;
  final backgrounds;
  // ...
  // final LocalStorage storage = new LocalStorage('parameters');
  final double barHeight = 10.0;

  // variables varriable
  var db = new Mysql();
  var nama_filter = "";
  var stores;

  // variables boolean
  bool isGreyscale = false;
  bool isClassicNegative = false;
  bool isFilterBeauty = false;
  bool isNormal = false;

  bool isVisibleFotoImage = false;

  // variables list dynamic
  List<dynamic> filters = [];
  List<dynamic> list = [];

  // variables string
  String deskripsi = "";
  String nama_user = "";
  String email_user = "";
  String ig = "";

  // variables integer
  int lengthDataImages = 0;
  int no_telp = 0;
  int harga = 0;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  // background image dan header variables
  List<dynamic> background = [];
  String headerImg = "";
  String bgImg = "";
  // ...

  // colors wave
  // static const _backgroundColor = bg_warna_main != "" ? HexColor(bg_warna_main) : Colors.transparent;
  static const _colors = [
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

  // .....
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController1 = ScreenshotController();
  ScreenshotController screenshotController2 = ScreenshotController();
  ScreenshotController screenshotController3 = ScreenshotController();
  ScreenshotController screenshotController4 = ScreenshotController();
  ScreenshotController screenshotController5 = ScreenshotController();
  ScreenshotController screenshotController6 = ScreenshotController();
  ScreenshotController screenshotController7 = ScreenshotController();
  ScreenshotController screenshotController8 = ScreenshotController();

  ScreenshotController screenshotController9 = ScreenshotController();
  ScreenshotController screenshotController10 = ScreenshotController();
  ScreenshotController screenshotController11 = ScreenshotController();
  ScreenshotController screenshotController12 = ScreenshotController();
  ScreenshotController screenshotController13 = ScreenshotController();
  ScreenshotController screenshotController14 = ScreenshotController();
  ScreenshotController screenshotController15 = ScreenshotController();
  ScreenshotController screenshotController16 = ScreenshotController();

  ScreenshotController screenshotController17 = ScreenshotController();
  ScreenshotController screenshotController18 = ScreenshotController();
  ScreenshotController screenshotController19 = ScreenshotController();
  ScreenshotController screenshotController20 = ScreenshotController();
  ScreenshotController screenshotController21 = ScreenshotController();
  ScreenshotController screenshotController22 = ScreenshotController();
  ScreenshotController screenshotController23 = ScreenshotController();
  ScreenshotController screenshotController24 = ScreenshotController();
  ScreenshotController screenshotController25 = ScreenshotController();
  // .....

  @override
  void initState() {
    // TODO: implement initState

    // init get all images from functions
    _getAllImages();

    // print(
    //     "title contains a pada filter page : ${title.toString().contains("Collage A")}");

    // init get filter from functions
    getFilter();
    getWarnaBg();
    getOrderSettings();

    super.initState();
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
      for (var element in background) {
        setState(() {
          headerImg = element["header_image"];
          bgImg = element["background_image"];
        });
      }
      print("object : $bgImg");
    } else {
      print(response.reasonPhrase);
    }
  }

  getWarnaBg() async {
    // print("get sesi data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `main_color`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              bg_warna_main = row[1];
              warna1 = row[2];
              warna2 = row[3];
            });
          } // Finally, close the connection
        }).then((value) {
          // ...
          print("bg main color : $bg_warna_main");
          print("bg main color : $warna1");
          print("bg main color : $warna2");
        });
        return value.close();
      },
    );
  }

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

  deleteFolder() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/delete-folder'));
    request.fields.addAll({
      'folder_name':
          'uploads/images/$nama-${DateTime.now().day}-${DateTime.now().hour}'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      // Paket A Menu
      if (title.toString().contains("Paket A")) {
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-1"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-2"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-3"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-4"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-5"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-6"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-1"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-2"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-3"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-4"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-5"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-6"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // Paket B Menu
      if (title.toString().contains("collage b") ||
          title.toString().contains("Collage B") ||
          title.toString().contains(" b") ||
          title.toString().contains(" B") ||
          title.toString().contains("Paket B")) {
        // =========================
        //  screenshot images normal
        // ========================
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // Paket C Menu
      if (title.toString().contains("collage c") ||
          title.toString().contains("Collage C") ||
          title.toString().contains(" c") ||
          title.toString().contains(" C") ||
          title.toString().contains("Paket C")) {
        // =========================
        //  screenshot images normal
        // ========================
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // Paket D Menu
      if (title.toString().contains("collage d") ||
          title.toString().contains("Collage D") ||
          title.toString().contains(" d") ||
          title.toString().contains(" D") ||
          title.toString().contains("Paket D")) {
        // =========================
        //  screenshot images normal
        // ========================
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
        // ...
        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // Paket E Menu
      if (title.toString().contains("collage e") ||
          title.toString().contains("Collage E") ||
          title.toString().contains(" e") ||
          title.toString().contains(" E") ||
          title.toString().contains("Paket E")) {
        // =========================
        //  screenshot images normal
        // ========================
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "p.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController17
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "q.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController18
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "r.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController19
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "s.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController20
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "t.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "p.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController17
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "q.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController18
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "r.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController19
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "s.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController20
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "t.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // Paket F Menu
      if (title.toString().contains("collage f") ||
          title.toString().contains("Collage F") ||
          title.toString().contains(" f") ||
          title.toString().contains(" F") ||
          title.toString().contains("Paket F")) {
        // =========================
        //  screenshot images normal
        // ========================
        final directory =
            (await getApplicationDocumentsDirectory()); //from path_provide package

        var fileName = "";
        var path = '$directory';

        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "p.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController17
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "q.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController18
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "r.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController19
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "s.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController20
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "t.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController21
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "u.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController22
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "v.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController23
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "w.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController24
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "x.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ...
        screenshotController25
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "y.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        // ========================
        // ====== edit path =======
        // ========================
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "a.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "b.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "c.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "d.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "e.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "f.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "g.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "h.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "i.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "j.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "k.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "l.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "m.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "n.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "o.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "p.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController17
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "q.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController18
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "r.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController19
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "s.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController20
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "t.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController21
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "u.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController22
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "v.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController23
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "w.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController24
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "x.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });

        screenshotController25
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "y.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // ...
      var counter = 4;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        counter--;
        if (counter == 0) {
          print('Cancel timer');
          timer.cancel();

          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: LayoutWidget(
                  nama: nama,
                  title: title,
                  nama_filter: nama_filter, // parameter dari filter

                  backgrounds: backgrounds,
                ),
                inheritTheme: true,
                ctx: context),
          );
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  // get filter functions
  getFilter() async {
    // print("get edit data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `filter`";
        value.query(sql).then((value) {
          for (var row in value) {
            filters.add(row);
          } // Finally, close the connection
        }).then((value) => print("get filter"));
        return value.close();
      },
    );
  }

  // save storage functions
  // _saveStorage(title, deskripsi, harga) async {
  //   await storage.setItem('title', title);
  //   await storage.setItem('deskripsi', deskripsi);
  //   await storage.setItem('harga', harga);
  // }

  // filter beauty functions
  void filterBeauty() async {
    setState(() {
      isFilterBeauty = !isFilterBeauty;
    });
  }

  // get data images functions from laravel api and folders
  Future<void> _getAllImages() async {
    List<dynamic> _list = [];
    // get all images
    print("get all images $nama-${DateTime.now().day}-${DateTime.now().hour}");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '${Variables.ipv4_local}/api/images-name-date',
      ),
    );
    request.fields.addAll(
      {
        'nama': "$nama-${DateTime.now().day}-${DateTime.now().hour}",
      },
    );

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      stores = jsonDecode(response.body);
      _list.addAll(jsonDecode(response.body));
      print("response length : ${stores.length}");
      print("response _list : ${_list}");
      setState(() {
        lengthDataImages = stores.length;
      });

      if (title.toString().contains("Collage A") ||
          title.toString().contains("Paket A")) {
        print("list a");
        for (var i = 0; i < 6; i++) {
          print("list a for loop");
          // ...
          print("object _list collage A $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
            // print(
            //     "list a is not empty now, dan isVisibleFotoImage == $isVisibleFotoImage");
          }
        }
      }
      if (title.toString().contains("Collage B") ||
          title.toString().contains("Paket B")) {
        for (var i = 0; i < 8; i++) {
          // ...
          print("object _list collage B $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Collage C") ||
          title.toString().contains("Paket C")) {
        for (var i = 0; i < 12; i++) {
          // ...
          print("object _list collage B $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Collage D") ||
          title.toString().contains("Paket D")) {
        for (var i = 0; i < 15; i++) {
          // ...
          print("object _list collage B $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Collage E") ||
          title.toString().contains("Paket E")) {
        for (var i = 0; i < 20; i++) {
          // ...
          print("object _list collage E $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Collage F") ||
          title.toString().contains("Paket F")) {
        for (var i = 0; i < 25; i++) {
          // ...
          print("object _list collage F $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Paket G")) {
        for (var i = 0; i < 1; i++) {
          // ...
          print("object _list collage g $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }

      if (title.toString().contains("Paket H")) {
        for (var i = 0; i < 1; i++) {
          // ...
          print("object _list collage h $i ${_list[i]}");
          list.add(_list[i]);

          if (list.isNotEmpty) {
            setState(() {
              isVisibleFotoImage = true;
            });
          }
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // ======================================================================
  // ============================ Main Widget =============================
  // ======================================================================
  @override
  // ignore: override_on_non_overriding_member
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: backgrounds != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.ipv4_local}/storage/order/background-image/$backgrounds"),
                  fit: BoxFit.fill,
                ),
              )
            : BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ----------------
            // header page view
            // ----------------
            // ignore: sized_box_for_whitespace
            Container(
              height: height * 0.12,
              width: width * 1,
              child: Column(
                children: [
                  Container(
                    height: width * 0.015,
                    width: width * 1,
                    color: warna1 != "" ? HexColor(warna1) : Colors.transparent,
                  ),
                  Container(
                    height: width * 0.035,
                    width: width * 1,
                    color: warna1 != "" ? HexColor(warna1) : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Layout",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Background",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sticker",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.025,
                    width: width * 1,
                    child: WaveWidget(
                      config: CustomConfig(
                        colors: [
                          warna1 != "" ? HexColor(warna1) : Colors.transparent,
                          warna1 != "" ? HexColor(warna1) : Colors.transparent
                        ],
                        durations: _durations,
                        heightPercentages: _heightPercentages,
                      ),
                      backgroundColor:
                          warna1 != "" ? HexColor(warna1) : Colors.transparent,
                      size: Size(double.infinity, double.infinity),
                      waveAmplitude: 0,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------------
            // end header page view
            // ---------------------

            // --------------------------
            // body page view filter page
            // --------------------------
            Container(
              width: width * 1,
              height: height * 0.88,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.65,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            width * 0.015,
                          ),
                          child: Container(
                            height: height * 0.69,
                            color: Colors.transparent,
                            // single child scroll view
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // ...
                                      // length images count dari jenis photobooth 8x / 16x
                                      // ...
                                      ListView.builder(
                                        itemCount: title
                                                    .toString()
                                                    .contains("Collage A") ||
                                                title
                                                    .toString()
                                                    .contains("Paket A")
                                            ? 2
                                            : title.toString().contains("Collage B") ||
                                                    title
                                                        .toString()
                                                        .contains("Paket B")
                                                ? 2
                                                : title.toString().contains("Collage C") ||
                                                        title
                                                            .toString()
                                                            .contains("Paket C")
                                                    ? 3
                                                    : title.toString().contains(
                                                                "Collage D") ||
                                                            title
                                                                .toString()
                                                                .contains(
                                                                    "Paket D")
                                                        ? 5
                                                        : title.toString().contains("Collage E") ||
                                                                title
                                                                    .toString()
                                                                    .contains(
                                                                        "Paket E")
                                                            ? 3
                                                            : title.toString().contains("Collage F") ||
                                                                    title
                                                                        .toString()
                                                                        .contains("Paket F")
                                                                ? 1
                                                                : title.toString().contains("Collage G") || title.toString().contains("Paket G")
                                                                    ? 1
                                                                    : 1,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, i) {
                                          // ...
                                          return Container(
                                            width: width * 1,
                                            height: title.toString().contains(
                                                        "Collage G") ||
                                                    title
                                                        .toString()
                                                        .contains("Paket G")
                                                ? width * 0.4
                                                : null,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  // width: width * 0.5,
                                                  height: height * 0.3,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    itemCount: title
                                                            .toString()
                                                            .contains("Paket A")
                                                        ? 3
                                                        : title.toString().contains(
                                                                    "Collage B") ||
                                                                title
                                                                    .toString()
                                                                    .contains(
                                                                        "Paket B")
                                                            ? 4
                                                            : title.toString().contains(
                                                                        "Collage C") ||
                                                                    title
                                                                        .toString()
                                                                        .contains(
                                                                            "Paket C")
                                                                ? 4
                                                                : title
                                                                        .toString()
                                                                        .contains(
                                                                            "Paket D")
                                                                    ? 3
                                                                    : title.toString().contains("Collage E") ||
                                                                            title.toString().contains(
                                                                                "Paket E")
                                                                        ? 4
                                                                        : title.toString().contains("Collage F") ||
                                                                                title.toString().contains("Paket F")
                                                                            ? 4
                                                                            : title.toString().contains("Collage G") || title.toString().contains("Paket G")
                                                                                ? 1
                                                                                : 1,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int j) {
                                                      // item builder ...
                                                      return list.isNotEmpty
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                8.0,
                                                              ),
                                                              child: Container(
                                                                width: width *
                                                                    0.13,
                                                                height: width *
                                                                    0.13,
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .all(width *
                                                                          0.0045),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      // ontap
                                                                      // ignore: avoid_print
                                                                      print(
                                                                        "object i dan j : $i dan $j",
                                                                      );
                                                                      print(
                                                                        "nama_filter : $nama_filter",
                                                                      );
                                                                    },
                                                                    child: title
                                                                            .toString()
                                                                            .contains(
                                                                                "Paket A")
                                                                        ? (i == 0 &&
                                                                                j == 0
                                                                            ? Screenshot(
                                                                                controller: screenshotController1,
                                                                                child: AnimatedOpacity(
                                                                                  opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                  duration: const Duration(seconds: 1),
                                                                                  child: Container(
                                                                                    width: width * 0.1,
                                                                                    height: height * 0.3,
                                                                                    child: ColorFiltered(
                                                                                      colorFilter: nama_filter == 'greyscale'
                                                                                          ? const ColorFilter.mode(
                                                                                              Color.fromARGB(255, 139, 139, 139),
                                                                                              BlendMode.saturation,
                                                                                            )
                                                                                          : nama_filter == 'classic negative'
                                                                                              ? const ColorFilter.mode(
                                                                                                  Color.fromARGB(229, 255, 247, 220),
                                                                                                  BlendMode.saturation,
                                                                                                )
                                                                                              : nama_filter == 'black white blur'
                                                                                                  ? const ColorFilter.mode(
                                                                                                      Color.fromARGB(229, 255, 247, 220),
                                                                                                      BlendMode.saturation,
                                                                                                    )
                                                                                                  : nama_filter == 'mute'
                                                                                                      ? const ColorFilter.mode(
                                                                                                          Color.fromARGB(228, 151, 151, 151),
                                                                                                          BlendMode.saturation,
                                                                                                        )
                                                                                                      : nama_filter == 'webcore'
                                                                                                          ? const ColorFilter.mode(
                                                                                                              Color.fromARGB(228, 112, 89, 130),
                                                                                                              BlendMode.saturation,
                                                                                                            )
                                                                                                          : const ColorFilter.mode(
                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                              BlendMode.saturation,
                                                                                                            ),
                                                                                      child: Container(
                                                                                        child: FadeInImage(
                                                                                          width: width * 0.08,
                                                                                          height: height * 0.15,
                                                                                          image: NetworkImage("${Variables.ipv4_local}/storage/${list[0].toString()}", scale: 1),
                                                                                          placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                          imageErrorBuilder: (context, error, stackTrace) {
                                                                                            return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                          },
                                                                                          fit: BoxFit.contain,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : i == 0 && j == 1
                                                                                ? Screenshot(
                                                                                    controller: screenshotController2,
                                                                                    child: AnimatedOpacity(
                                                                                      opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                      duration: const Duration(seconds: 1),
                                                                                      child: Container(
                                                                                        width: width * 0.1,
                                                                                        height: height * 0.3,
                                                                                        child: ColorFiltered(
                                                                                          colorFilter: nama_filter == 'greyscale'
                                                                                              ? const ColorFilter.mode(
                                                                                                  Color.fromARGB(255, 139, 139, 139),
                                                                                                  BlendMode.saturation,
                                                                                                )
                                                                                              : nama_filter == 'classic negative'
                                                                                                  ? const ColorFilter.mode(
                                                                                                      Color.fromARGB(229, 255, 247, 220),
                                                                                                      BlendMode.saturation,
                                                                                                    )
                                                                                                  : nama_filter == 'black white blur'
                                                                                                      ? const ColorFilter.mode(
                                                                                                          Color.fromARGB(229, 255, 247, 220),
                                                                                                          BlendMode.saturation,
                                                                                                        )
                                                                                                      : nama_filter == 'mute'
                                                                                                          ? const ColorFilter.mode(
                                                                                                              Color.fromARGB(228, 151, 151, 151),
                                                                                                              BlendMode.saturation,
                                                                                                            )
                                                                                                          : nama_filter == 'webcore'
                                                                                                              ? const ColorFilter.mode(
                                                                                                                  Color.fromARGB(228, 112, 89, 130),
                                                                                                                  BlendMode.saturation,
                                                                                                                )
                                                                                                              : const ColorFilter.mode(
                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                  BlendMode.saturation,
                                                                                                                ),
                                                                                          child: Container(
                                                                                            child: FadeInImage(
                                                                                              width: width * 0.08,
                                                                                              height: height * 0.15,
                                                                                              image: NetworkImage("${Variables.ipv4_local}/storage/${list[1].toString()}", scale: 1),
                                                                                              placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                              imageErrorBuilder: (context, error, stackTrace) {
                                                                                                return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                              },
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : i == 0 && j == 2
                                                                                    ? Screenshot(
                                                                                        controller: screenshotController3,
                                                                                        child: AnimatedOpacity(
                                                                                          opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                          duration: const Duration(seconds: 1),
                                                                                          child: Container(
                                                                                            width: width * 0.1,
                                                                                            height: height * 0.3,
                                                                                            child: ColorFiltered(
                                                                                              colorFilter: nama_filter == 'greyscale'
                                                                                                  ? const ColorFilter.mode(
                                                                                                      Color.fromARGB(255, 139, 139, 139),
                                                                                                      BlendMode.saturation,
                                                                                                    )
                                                                                                  : nama_filter == 'classic negative'
                                                                                                      ? const ColorFilter.mode(
                                                                                                          Color.fromARGB(229, 255, 247, 220),
                                                                                                          BlendMode.saturation,
                                                                                                        )
                                                                                                      : nama_filter == 'black white blur'
                                                                                                          ? const ColorFilter.mode(
                                                                                                              Color.fromARGB(229, 255, 247, 220),
                                                                                                              BlendMode.saturation,
                                                                                                            )
                                                                                                          : nama_filter == 'mute'
                                                                                                              ? const ColorFilter.mode(
                                                                                                                  Color.fromARGB(228, 151, 151, 151),
                                                                                                                  BlendMode.saturation,
                                                                                                                )
                                                                                                              : nama_filter == 'webcore'
                                                                                                                  ? const ColorFilter.mode(
                                                                                                                      Color.fromARGB(228, 112, 89, 130),
                                                                                                                      BlendMode.saturation,
                                                                                                                    )
                                                                                                                  : const ColorFilter.mode(
                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                      BlendMode.saturation,
                                                                                                                    ),
                                                                                              child: Container(
                                                                                                child: FadeInImage(
                                                                                                  width: width * 0.08,
                                                                                                  height: height * 0.15,
                                                                                                  image: NetworkImage("${Variables.ipv4_local}/storage/${list[2].toString()}", scale: 1),
                                                                                                  placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                  imageErrorBuilder: (context, error, stackTrace) {
                                                                                                    return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                  },
                                                                                                  fit: BoxFit.contain,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : i == 1 && j == 0
                                                                                        ? Screenshot(
                                                                                            controller: screenshotController4,
                                                                                            child: AnimatedOpacity(
                                                                                              opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                              duration: const Duration(seconds: 1),
                                                                                              child: Container(
                                                                                                width: width * 0.1,
                                                                                                height: height * 0.3,
                                                                                                child: ColorFiltered(
                                                                                                  colorFilter: nama_filter == 'greyscale'
                                                                                                      ? const ColorFilter.mode(
                                                                                                          Color.fromARGB(255, 139, 139, 139),
                                                                                                          BlendMode.saturation,
                                                                                                        )
                                                                                                      : nama_filter == 'classic negative'
                                                                                                          ? const ColorFilter.mode(
                                                                                                              Color.fromARGB(229, 255, 247, 220),
                                                                                                              BlendMode.saturation,
                                                                                                            )
                                                                                                          : nama_filter == 'black white blur'
                                                                                                              ? const ColorFilter.mode(
                                                                                                                  Color.fromARGB(229, 255, 247, 220),
                                                                                                                  BlendMode.saturation,
                                                                                                                )
                                                                                                              : nama_filter == 'mute'
                                                                                                                  ? const ColorFilter.mode(
                                                                                                                      Color.fromARGB(228, 151, 151, 151),
                                                                                                                      BlendMode.saturation,
                                                                                                                    )
                                                                                                                  : nama_filter == 'webcore'
                                                                                                                      ? const ColorFilter.mode(
                                                                                                                          Color.fromARGB(228, 112, 89, 130),
                                                                                                                          BlendMode.saturation,
                                                                                                                        )
                                                                                                                      : const ColorFilter.mode(
                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                          BlendMode.saturation,
                                                                                                                        ),
                                                                                                  child: Container(
                                                                                                    child: FadeInImage(
                                                                                                      width: width * 0.08,
                                                                                                      height: height * 0.15,
                                                                                                      image: NetworkImage("${Variables.ipv4_local}/storage/${list[3].toString()}", scale: 1),
                                                                                                      placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                                                                        return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                      },
                                                                                                      fit: BoxFit.contain,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : i == 1 && j == 1
                                                                                            ? Screenshot(
                                                                                                controller: screenshotController5,
                                                                                                child: AnimatedOpacity(
                                                                                                  opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                                  duration: const Duration(seconds: 1),
                                                                                                  child: Container(
                                                                                                    width: width * 0.1,
                                                                                                    height: height * 0.3,
                                                                                                    child: ColorFiltered(
                                                                                                      colorFilter: nama_filter == 'greyscale'
                                                                                                          ? const ColorFilter.mode(
                                                                                                              Color.fromARGB(255, 139, 139, 139),
                                                                                                              BlendMode.saturation,
                                                                                                            )
                                                                                                          : nama_filter == 'classic negative'
                                                                                                              ? const ColorFilter.mode(
                                                                                                                  Color.fromARGB(229, 255, 247, 220),
                                                                                                                  BlendMode.saturation,
                                                                                                                )
                                                                                                              : nama_filter == 'black white blur'
                                                                                                                  ? const ColorFilter.mode(
                                                                                                                      Color.fromARGB(229, 255, 247, 220),
                                                                                                                      BlendMode.saturation,
                                                                                                                    )
                                                                                                                  : nama_filter == 'mute'
                                                                                                                      ? const ColorFilter.mode(
                                                                                                                          Color.fromARGB(228, 151, 151, 151),
                                                                                                                          BlendMode.saturation,
                                                                                                                        )
                                                                                                                      : nama_filter == 'webcore'
                                                                                                                          ? const ColorFilter.mode(
                                                                                                                              Color.fromARGB(228, 112, 89, 130),
                                                                                                                              BlendMode.saturation,
                                                                                                                            )
                                                                                                                          : const ColorFilter.mode(
                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                              BlendMode.saturation,
                                                                                                                            ),
                                                                                                      child: Container(
                                                                                                        child: FadeInImage(
                                                                                                          width: width * 0.08,
                                                                                                          height: height * 0.15,
                                                                                                          image: NetworkImage("${Variables.ipv4_local}/storage/${list[4].toString()}", scale: 1),
                                                                                                          placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                          imageErrorBuilder: (context, error, stackTrace) {
                                                                                                            return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                          },
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : i == 1 && j == 2
                                                                                                ? Screenshot(
                                                                                                    controller: screenshotController6,
                                                                                                    child: AnimatedOpacity(
                                                                                                      opacity: isVisibleFotoImage == false ? 0 : 1,
                                                                                                      duration: const Duration(seconds: 1),
                                                                                                      child: Container(
                                                                                                        width: width * 0.1,
                                                                                                        height: height * 0.3,
                                                                                                        child: ColorFiltered(
                                                                                                          colorFilter: nama_filter == 'greyscale'
                                                                                                              ? const ColorFilter.mode(
                                                                                                                  Color.fromARGB(255, 139, 139, 139),
                                                                                                                  BlendMode.saturation,
                                                                                                                )
                                                                                                              : nama_filter == 'classic negative'
                                                                                                                  ? const ColorFilter.mode(
                                                                                                                      Color.fromARGB(229, 255, 247, 220),
                                                                                                                      BlendMode.saturation,
                                                                                                                    )
                                                                                                                  : nama_filter == 'black white blur'
                                                                                                                      ? const ColorFilter.mode(
                                                                                                                          Color.fromARGB(229, 255, 247, 220),
                                                                                                                          BlendMode.saturation,
                                                                                                                        )
                                                                                                                      : nama_filter == 'mute'
                                                                                                                          ? const ColorFilter.mode(
                                                                                                                              Color.fromARGB(228, 151, 151, 151),
                                                                                                                              BlendMode.saturation,
                                                                                                                            )
                                                                                                                          : nama_filter == 'webcore'
                                                                                                                              ? const ColorFilter.mode(
                                                                                                                                  Color.fromARGB(228, 112, 89, 130),
                                                                                                                                  BlendMode.saturation,
                                                                                                                                )
                                                                                                                              : const ColorFilter.mode(
                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                  BlendMode.saturation,
                                                                                                                                ),
                                                                                                          child: Container(
                                                                                                            child: FadeInImage(
                                                                                                              width: width * 0.08,
                                                                                                              height: height * 0.15,
                                                                                                              image: NetworkImage("${Variables.ipv4_local}/storage/${list[5].toString()}", scale: 1),
                                                                                                              placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                              imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                              },
                                                                                                              fit: BoxFit.contain,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container())
                                                                        : title.toString().contains("Paket B")
                                                                            ? (i == 0 && j == 0
                                                                                ? Screenshot(
                                                                                    controller: screenshotController1,
                                                                                    child: Container(
                                                                                      width: width * 0.1,
                                                                                      height: height * 0.3,
                                                                                      child: ColorFiltered(
                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                            ? const ColorFilter.mode(
                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                BlendMode.saturation,
                                                                                              )
                                                                                            : nama_filter == 'classic negative'
                                                                                                ? const ColorFilter.mode(
                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                    BlendMode.saturation,
                                                                                                  )
                                                                                                : nama_filter == 'black white blur'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'mute'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'webcore'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : const ColorFilter.mode(
                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                BlendMode.saturation,
                                                                                                              ),
                                                                                        child: Container(
                                                                                          child: FadeInImage(
                                                                                            width: width * 0.08,
                                                                                            height: height * 0.15,
                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[0].toString()}", scale: 1),
                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                            },
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : i == 0 && j == 1
                                                                                    ? Screenshot(
                                                                                        controller: screenshotController2,
                                                                                        child: Container(
                                                                                          width: width * 0.1,
                                                                                          height: height * 0.3,
                                                                                          child: ColorFiltered(
                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                ? const ColorFilter.mode(
                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                    BlendMode.saturation,
                                                                                                  )
                                                                                                : nama_filter == 'classic negative'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'black white blur'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'mute'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'webcore'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : const ColorFilter.mode(
                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                    BlendMode.saturation,
                                                                                                                  ),
                                                                                            child: Container(
                                                                                              child: FadeInImage(
                                                                                                width: width * 0.08,
                                                                                                height: height * 0.15,
                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[1].toString()}", scale: 1),
                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                },
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : i == 0 && j == 2
                                                                                        ? Screenshot(
                                                                                            controller: screenshotController3,
                                                                                            child: Container(
                                                                                              width: width * 0.1,
                                                                                              height: height * 0.3,
                                                                                              child: ColorFiltered(
                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'classic negative'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'black white blur'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'mute'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'webcore'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : const ColorFilter.mode(
                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                        BlendMode.saturation,
                                                                                                                      ),
                                                                                                child: Container(
                                                                                                  child: FadeInImage(
                                                                                                    width: width * 0.08,
                                                                                                    height: height * 0.15,
                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[2].toString()}", scale: 1),
                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                    },
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : i == 0 && j == 3
                                                                                            ? Screenshot(
                                                                                                controller: screenshotController4,
                                                                                                child: Container(
                                                                                                  width: width * 0.1,
                                                                                                  height: height * 0.3,
                                                                                                  child: ColorFiltered(
                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'classic negative'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'black white blur'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'mute'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'webcore'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : const ColorFilter.mode(
                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                            BlendMode.saturation,
                                                                                                                          ),
                                                                                                    child: Container(
                                                                                                      child: FadeInImage(
                                                                                                        width: width * 0.08,
                                                                                                        height: height * 0.15,
                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[3].toString()}", scale: 1),
                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                        },
                                                                                                        fit: BoxFit.contain,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : i == 1 && j == 0
                                                                                                ? Screenshot(
                                                                                                    controller: screenshotController5,
                                                                                                    child: Container(
                                                                                                      width: width * 0.1,
                                                                                                      height: height * 0.3,
                                                                                                      child: ColorFiltered(
                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'classic negative'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'black white blur'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'mute'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'webcore'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : const ColorFilter.mode(
                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                BlendMode.saturation,
                                                                                                                              ),
                                                                                                        child: Container(
                                                                                                          child: FadeInImage(
                                                                                                            width: width * 0.08,
                                                                                                            height: height * 0.15,
                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[4].toString()}", scale: 1),
                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                            },
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : i == 1 && j == 1
                                                                                                    ? Screenshot(
                                                                                                        controller: screenshotController6,
                                                                                                        child: Container(
                                                                                                          width: width * 0.1,
                                                                                                          height: height * 0.3,
                                                                                                          child: ColorFiltered(
                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'classic negative'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'mute'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  ),
                                                                                                            child: Container(
                                                                                                              child: FadeInImage(
                                                                                                                width: width * 0.08,
                                                                                                                height: height * 0.15,
                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[5].toString()}", scale: 1),
                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                },
                                                                                                                fit: BoxFit.contain,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : i == 1 && j == 2
                                                                                                        ? Screenshot(
                                                                                                            controller: screenshotController7,
                                                                                                            child: Container(
                                                                                                              width: width * 0.1,
                                                                                                              height: height * 0.3,
                                                                                                              child: ColorFiltered(
                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'mute'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      ),
                                                                                                                child: Container(
                                                                                                                  child: FadeInImage(
                                                                                                                    width: width * 0.08,
                                                                                                                    height: height * 0.15,
                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[6].toString()}", scale: 1),
                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                    },
                                                                                                                    fit: BoxFit.contain,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : i == 1 && j == 3
                                                                                                            ? Screenshot(
                                                                                                                controller: screenshotController8,
                                                                                                                child: Container(
                                                                                                                  width: width * 0.1,
                                                                                                                  height: height * 0.3,
                                                                                                                  child: ColorFiltered(
                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'mute'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          ),
                                                                                                                    child: Container(
                                                                                                                      child: FadeInImage(
                                                                                                                        width: width * 0.08,
                                                                                                                        height: height * 0.15,
                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[7].toString()}", scale: 1),
                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                        },
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              )
                                                                                                            : Container())
                                                                            : title.toString().contains("Paket C")
                                                                                ? (i == 0 && j == 0
                                                                                    ? Screenshot(
                                                                                        controller: screenshotController1,
                                                                                        child: Container(
                                                                                          width: width * 0.1,
                                                                                          height: height * 0.3,
                                                                                          child: ColorFiltered(
                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                ? const ColorFilter.mode(
                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                    BlendMode.saturation,
                                                                                                  )
                                                                                                : nama_filter == 'classic negative'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'black white blur'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'mute'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'webcore'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : const ColorFilter.mode(
                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                    BlendMode.saturation,
                                                                                                                  ),
                                                                                            child: Container(
                                                                                              child: FadeInImage(
                                                                                                width: width * 0.08,
                                                                                                height: height * 0.15,
                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[0].toString()}", scale: 1),
                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                },
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : i == 0 && j == 1
                                                                                        ? Screenshot(
                                                                                            controller: screenshotController2,
                                                                                            child: Container(
                                                                                              width: width * 0.1,
                                                                                              height: height * 0.3,
                                                                                              child: ColorFiltered(
                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'classic negative'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'black white blur'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'mute'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'webcore'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : const ColorFilter.mode(
                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                        BlendMode.saturation,
                                                                                                                      ),
                                                                                                child: Container(
                                                                                                  child: FadeInImage(
                                                                                                    width: width * 0.08,
                                                                                                    height: height * 0.15,
                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[1].toString()}", scale: 1),
                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                    },
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : i == 0 && j == 2
                                                                                            ? Screenshot(
                                                                                                controller: screenshotController3,
                                                                                                child: Container(
                                                                                                  width: width * 0.1,
                                                                                                  height: height * 0.3,
                                                                                                  child: ColorFiltered(
                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'classic negative'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'black white blur'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'mute'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'webcore'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : const ColorFilter.mode(
                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                            BlendMode.saturation,
                                                                                                                          ),
                                                                                                    child: Container(
                                                                                                      child: FadeInImage(
                                                                                                        width: width * 0.08,
                                                                                                        height: height * 0.15,
                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[2].toString()}", scale: 1),
                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                        },
                                                                                                        fit: BoxFit.contain,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : i == 0 && j == 3
                                                                                                ? Screenshot(
                                                                                                    controller: screenshotController4,
                                                                                                    child: Container(
                                                                                                      width: width * 0.1,
                                                                                                      height: height * 0.3,
                                                                                                      child: ColorFiltered(
                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'classic negative'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'black white blur'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'mute'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'webcore'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : const ColorFilter.mode(
                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                BlendMode.saturation,
                                                                                                                              ),
                                                                                                        child: Container(
                                                                                                          child: FadeInImage(
                                                                                                            width: width * 0.08,
                                                                                                            height: height * 0.15,
                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[3].toString()}", scale: 1),
                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                            },
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : i == 1 && j == 0
                                                                                                    ? Screenshot(
                                                                                                        controller: screenshotController5,
                                                                                                        child: Container(
                                                                                                          width: width * 0.1,
                                                                                                          height: height * 0.3,
                                                                                                          child: ColorFiltered(
                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'classic negative'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'mute'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  ),
                                                                                                            child: Container(
                                                                                                              child: FadeInImage(
                                                                                                                width: width * 0.08,
                                                                                                                height: height * 0.15,
                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[4].toString()}", scale: 1),
                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                },
                                                                                                                fit: BoxFit.contain,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : i == 1 && j == 1
                                                                                                        ? Screenshot(
                                                                                                            controller: screenshotController6,
                                                                                                            child: Container(
                                                                                                              width: width * 0.1,
                                                                                                              height: height * 0.3,
                                                                                                              child: ColorFiltered(
                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'mute'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      ),
                                                                                                                child: Container(
                                                                                                                  child: FadeInImage(
                                                                                                                    width: width * 0.08,
                                                                                                                    height: height * 0.15,
                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[5].toString()}", scale: 1),
                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                    },
                                                                                                                    fit: BoxFit.contain,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : i == 1 && j == 2
                                                                                                            ? Screenshot(
                                                                                                                controller: screenshotController7,
                                                                                                                child: Container(
                                                                                                                  width: width * 0.1,
                                                                                                                  height: height * 0.3,
                                                                                                                  child: ColorFiltered(
                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'mute'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          ),
                                                                                                                    child: Container(
                                                                                                                      child: FadeInImage(
                                                                                                                        width: width * 0.08,
                                                                                                                        height: height * 0.15,
                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[6].toString()}", scale: 1),
                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                        },
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              )
                                                                                                            : i == 1 && j == 3
                                                                                                                ? Screenshot(
                                                                                                                    controller: screenshotController8,
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.1,
                                                                                                                      height: height * 0.3,
                                                                                                                      child: ColorFiltered(
                                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'classic negative'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'black white blur'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'mute'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'webcore'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              ),
                                                                                                                        child: Container(
                                                                                                                          child: FadeInImage(
                                                                                                                            width: width * 0.08,
                                                                                                                            height: height * 0.15,
                                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[7].toString()}", scale: 1),
                                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                            },
                                                                                                                            fit: BoxFit.contain,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : i == 2 && j == 0
                                                                                                                    ? Screenshot(
                                                                                                                        controller: screenshotController9,
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.1,
                                                                                                                          height: height * 0.3,
                                                                                                                          child: ColorFiltered(
                                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'classic negative'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'mute'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  ),
                                                                                                                            child: Container(
                                                                                                                              child: FadeInImage(
                                                                                                                                width: width * 0.08,
                                                                                                                                height: height * 0.15,
                                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[8].toString()}", scale: 1),
                                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                },
                                                                                                                                fit: BoxFit.contain,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    : i == 2 && j == 1
                                                                                                                        ? Screenshot(
                                                                                                                            controller: screenshotController10,
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.1,
                                                                                                                              height: height * 0.3,
                                                                                                                              child: ColorFiltered(
                                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'mute'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      ),
                                                                                                                                child: Container(
                                                                                                                                  child: FadeInImage(
                                                                                                                                    width: width * 0.08,
                                                                                                                                    height: height * 0.15,
                                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[9].toString()}", scale: 1),
                                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                    },
                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : i == 2 && j == 2
                                                                                                                            ? Screenshot(
                                                                                                                                controller: screenshotController11,
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.1,
                                                                                                                                  height: height * 0.3,
                                                                                                                                  child: ColorFiltered(
                                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'mute'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          ),
                                                                                                                                    child: Container(
                                                                                                                                      child: FadeInImage(
                                                                                                                                        width: width * 0.08,
                                                                                                                                        height: height * 0.15,
                                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[10].toString()}", scale: 1),
                                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                        },
                                                                                                                                        fit: BoxFit.contain,
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : i == 2 && j == 3
                                                                                                                                ? Screenshot(
                                                                                                                                    controller: screenshotController12,
                                                                                                                                    child: Container(
                                                                                                                                      width: width * 0.1,
                                                                                                                                      height: height * 0.3,
                                                                                                                                      child: ColorFiltered(
                                                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'classic negative'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'black white blur'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'mute'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : nama_filter == 'webcore'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              ),
                                                                                                                                        child: Container(
                                                                                                                                          child: FadeInImage(
                                                                                                                                            width: width * 0.08,
                                                                                                                                            height: height * 0.15,
                                                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[11].toString()}", scale: 1),
                                                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                            },
                                                                                                                                            fit: BoxFit.contain,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : Container())
                                                                                : title.toString().contains("Paket D")
                                                                                    ? (i == 0 && j == 0
                                                                                        ? Screenshot(
                                                                                            controller: screenshotController1,
                                                                                            child: Container(
                                                                                              width: width * 0.1,
                                                                                              height: height * 0.3,
                                                                                              child: ColorFiltered(
                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                    ? const ColorFilter.mode(
                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                        BlendMode.saturation,
                                                                                                      )
                                                                                                    : nama_filter == 'classic negative'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'black white blur'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'mute'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'webcore'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : const ColorFilter.mode(
                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                        BlendMode.saturation,
                                                                                                                      ),
                                                                                                child: Container(
                                                                                                  child: FadeInImage(
                                                                                                    width: width * 0.08,
                                                                                                    height: height * 0.15,
                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[0].toString()}", scale: 1),
                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                    },
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : i == 0 && j == 1
                                                                                            ? Screenshot(
                                                                                                controller: screenshotController2,
                                                                                                child: Container(
                                                                                                  width: width * 0.1,
                                                                                                  height: height * 0.3,
                                                                                                  child: ColorFiltered(
                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'classic negative'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'black white blur'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'mute'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'webcore'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : const ColorFilter.mode(
                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                            BlendMode.saturation,
                                                                                                                          ),
                                                                                                    child: Container(
                                                                                                      child: FadeInImage(
                                                                                                        width: width * 0.08,
                                                                                                        height: height * 0.15,
                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[1].toString()}", scale: 1),
                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                        },
                                                                                                        fit: BoxFit.contain,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : i == 0 && j == 2
                                                                                                ? Screenshot(
                                                                                                    controller: screenshotController3,
                                                                                                    child: Container(
                                                                                                      width: width * 0.1,
                                                                                                      height: height * 0.3,
                                                                                                      child: ColorFiltered(
                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'classic negative'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'black white blur'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'mute'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'webcore'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : const ColorFilter.mode(
                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                BlendMode.saturation,
                                                                                                                              ),
                                                                                                        child: Container(
                                                                                                          child: FadeInImage(
                                                                                                            width: width * 0.08,
                                                                                                            height: height * 0.15,
                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[2].toString()}", scale: 1),
                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                            },
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : i == 1 && j == 0
                                                                                                    ? Screenshot(
                                                                                                        controller: screenshotController4,
                                                                                                        child: Container(
                                                                                                          width: width * 0.1,
                                                                                                          height: height * 0.3,
                                                                                                          child: ColorFiltered(
                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'classic negative'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'mute'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  ),
                                                                                                            child: Container(
                                                                                                              child: FadeInImage(
                                                                                                                width: width * 0.08,
                                                                                                                height: height * 0.15,
                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[3].toString()}", scale: 1),
                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                },
                                                                                                                fit: BoxFit.contain,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : i == 1 && j == 1
                                                                                                        ? Screenshot(
                                                                                                            controller: screenshotController5,
                                                                                                            child: Container(
                                                                                                              width: width * 0.1,
                                                                                                              height: height * 0.3,
                                                                                                              child: ColorFiltered(
                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'mute'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      ),
                                                                                                                child: Container(
                                                                                                                  child: FadeInImage(
                                                                                                                    width: width * 0.08,
                                                                                                                    height: height * 0.15,
                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[4].toString()}", scale: 1),
                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                    },
                                                                                                                    fit: BoxFit.contain,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : i == 1 && j == 2
                                                                                                            ? Screenshot(
                                                                                                                controller: screenshotController6,
                                                                                                                child: Container(
                                                                                                                  width: width * 0.1,
                                                                                                                  height: height * 0.3,
                                                                                                                  child: ColorFiltered(
                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'mute'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          ),
                                                                                                                    child: Container(
                                                                                                                      child: FadeInImage(
                                                                                                                        width: width * 0.08,
                                                                                                                        height: height * 0.15,
                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[5].toString()}", scale: 1),
                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                        },
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              )
                                                                                                            : i == 2 && j == 0
                                                                                                                ? Screenshot(
                                                                                                                    controller: screenshotController7,
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.1,
                                                                                                                      height: height * 0.3,
                                                                                                                      child: ColorFiltered(
                                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                                BlendMode.saturation,
                                                                                                                              )
                                                                                                                            : nama_filter == 'classic negative'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'black white blur'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'mute'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'webcore'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              ),
                                                                                                                        child: Container(
                                                                                                                          child: FadeInImage(
                                                                                                                            width: width * 0.08,
                                                                                                                            height: height * 0.15,
                                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[6].toString()}", scale: 1),
                                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                            },
                                                                                                                            fit: BoxFit.contain,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : i == 2 && j == 1
                                                                                                                    ? Screenshot(
                                                                                                                        controller: screenshotController8,
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.1,
                                                                                                                          height: height * 0.3,
                                                                                                                          child: ColorFiltered(
                                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                                    BlendMode.saturation,
                                                                                                                                  )
                                                                                                                                : nama_filter == 'classic negative'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'mute'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  ),
                                                                                                                            child: Container(
                                                                                                                              child: FadeInImage(
                                                                                                                                width: width * 0.08,
                                                                                                                                height: height * 0.15,
                                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[7].toString()}", scale: 1),
                                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                },
                                                                                                                                fit: BoxFit.contain,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    : i == 2 && j == 2
                                                                                                                        ? Screenshot(
                                                                                                                            controller: screenshotController9,
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.1,
                                                                                                                              height: height * 0.3,
                                                                                                                              child: ColorFiltered(
                                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                                        BlendMode.saturation,
                                                                                                                                      )
                                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'mute'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      ),
                                                                                                                                child: Container(
                                                                                                                                  child: FadeInImage(
                                                                                                                                    width: width * 0.08,
                                                                                                                                    height: height * 0.15,
                                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[8].toString()}", scale: 1),
                                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                    },
                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : i == 3 && j == 0
                                                                                                                            ? Screenshot(
                                                                                                                                controller: screenshotController10,
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.1,
                                                                                                                                  height: height * 0.3,
                                                                                                                                  child: ColorFiltered(
                                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                                            BlendMode.saturation,
                                                                                                                                          )
                                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'mute'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          ),
                                                                                                                                    child: Container(
                                                                                                                                      child: FadeInImage(
                                                                                                                                        width: width * 0.08,
                                                                                                                                        height: height * 0.15,
                                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[9].toString()}", scale: 1),
                                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                        },
                                                                                                                                        fit: BoxFit.contain,
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : i == 3 && j == 1
                                                                                                                                ? Screenshot(
                                                                                                                                    controller: screenshotController11,
                                                                                                                                    child: Container(
                                                                                                                                      width: width * 0.1,
                                                                                                                                      height: height * 0.3,
                                                                                                                                      child: ColorFiltered(
                                                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                BlendMode.saturation,
                                                                                                                                              )
                                                                                                                                            : nama_filter == 'classic negative'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'black white blur'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'mute'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : nama_filter == 'webcore'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              ),
                                                                                                                                        child: Container(
                                                                                                                                          child: FadeInImage(
                                                                                                                                            width: width * 0.08,
                                                                                                                                            height: height * 0.15,
                                                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[10].toString()}", scale: 1),
                                                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                            },
                                                                                                                                            fit: BoxFit.contain,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : i == 3 && j == 2
                                                                                                                                    ? Screenshot(
                                                                                                                                        controller: screenshotController12,
                                                                                                                                        child: Container(
                                                                                                                                          width: width * 0.1,
                                                                                                                                          height: height * 0.3,
                                                                                                                                          child: ColorFiltered(
                                                                                                                                            colorFilter: nama_filter == 'greyscale'
                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                    Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                  )
                                                                                                                                                : nama_filter == 'classic negative'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'black white blur'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : nama_filter == 'mute'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : nama_filter == 'webcore'
                                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                                    Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                                  )
                                                                                                                                                                : const ColorFilter.mode(
                                                                                                                                                                    Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                                  ),
                                                                                                                                            child: Container(
                                                                                                                                              child: FadeInImage(
                                                                                                                                                width: width * 0.08,
                                                                                                                                                height: height * 0.15,
                                                                                                                                                image: NetworkImage("${Variables.ipv4_local}/storage/${list[11].toString()}", scale: 1),
                                                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                                },
                                                                                                                                                fit: BoxFit.contain,
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      )
                                                                                                                                    : i == 4 && j == 0
                                                                                                                                        ? Screenshot(
                                                                                                                                            controller: screenshotController13,
                                                                                                                                            child: Container(
                                                                                                                                              width: width * 0.1,
                                                                                                                                              height: height * 0.3,
                                                                                                                                              child: ColorFiltered(
                                                                                                                                                colorFilter: nama_filter == 'greyscale'
                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                        Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                      )
                                                                                                                                                    : nama_filter == 'classic negative'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : nama_filter == 'black white blur'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : nama_filter == 'mute'
                                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                                    Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                                  )
                                                                                                                                                                : nama_filter == 'webcore'
                                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                                        Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                                      )
                                                                                                                                                                    : const ColorFilter.mode(
                                                                                                                                                                        Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                                      ),
                                                                                                                                                child: Container(
                                                                                                                                                  child: FadeInImage(
                                                                                                                                                    width: width * 0.08,
                                                                                                                                                    height: height * 0.15,
                                                                                                                                                    image: NetworkImage("${Variables.ipv4_local}/storage/${list[12].toString()}", scale: 1),
                                                                                                                                                    placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                                      return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                                    },
                                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                          )
                                                                                                                                        : i == 4 && j == 1
                                                                                                                                            ? Screenshot(
                                                                                                                                                controller: screenshotController14,
                                                                                                                                                child: Container(
                                                                                                                                                  width: width * 0.1,
                                                                                                                                                  height: height * 0.3,
                                                                                                                                                  child: ColorFiltered(
                                                                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                          )
                                                                                                                                                        : nama_filter == 'classic negative'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : nama_filter == 'black white blur'
                                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                                  )
                                                                                                                                                                : nama_filter == 'mute'
                                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                                      )
                                                                                                                                                                    : nama_filter == 'webcore'
                                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                                          )
                                                                                                                                                                        : const ColorFilter.mode(
                                                                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                                          ),
                                                                                                                                                    child: Container(
                                                                                                                                                      child: FadeInImage(
                                                                                                                                                        width: width * 0.08,
                                                                                                                                                        height: height * 0.15,
                                                                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[13].toString()}", scale: 1),
                                                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                                        },
                                                                                                                                                        fit: BoxFit.contain,
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              )
                                                                                                                                            : i == 4 && j == 2
                                                                                                                                                ? Screenshot(
                                                                                                                                                    controller: screenshotController15,
                                                                                                                                                    child: Container(
                                                                                                                                                      width: width * 0.1,
                                                                                                                                                      height: height * 0.3,
                                                                                                                                                      child: ColorFiltered(
                                                                                                                                                        colorFilter: nama_filter == 'greyscale'
                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                Color.fromARGB(255, 139, 139, 139),
                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                              )
                                                                                                                                                            : nama_filter == 'classic negative'
                                                                                                                                                                ? const ColorFilter.mode(
                                                                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                                    BlendMode.saturation,
                                                                                                                                                                  )
                                                                                                                                                                : nama_filter == 'black white blur'
                                                                                                                                                                    ? const ColorFilter.mode(
                                                                                                                                                                        Color.fromARGB(229, 255, 247, 220),
                                                                                                                                                                        BlendMode.saturation,
                                                                                                                                                                      )
                                                                                                                                                                    : nama_filter == 'mute'
                                                                                                                                                                        ? const ColorFilter.mode(
                                                                                                                                                                            Color.fromARGB(228, 151, 151, 151),
                                                                                                                                                                            BlendMode.saturation,
                                                                                                                                                                          )
                                                                                                                                                                        : nama_filter == 'webcore'
                                                                                                                                                                            ? const ColorFilter.mode(
                                                                                                                                                                                Color.fromARGB(228, 112, 89, 130),
                                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                                              )
                                                                                                                                                                            : const ColorFilter.mode(
                                                                                                                                                                                Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                BlendMode.saturation,
                                                                                                                                                                              ),
                                                                                                                                                        child: Container(
                                                                                                                                                          child: FadeInImage(
                                                                                                                                                            width: width * 0.08,
                                                                                                                                                            height: height * 0.15,
                                                                                                                                                            image: NetworkImage("${Variables.ipv4_local}/storage/${list[14].toString()}", scale: 1),
                                                                                                                                                            placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                                                              return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                                                                            },
                                                                                                                                                            fit: BoxFit.contain,
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  )
                                                                                                                                                : Container())
                                                                                    : title.toString().contains("Paket G") || title.toString().contains("Paket H")
                                                                                        ? (i == 0 && j == 0
                                                                                            ? Screenshot(
                                                                                                controller: screenshotController1,
                                                                                                child: Container(
                                                                                                  width: width * 0.1,
                                                                                                  height: height * 0.3,
                                                                                                  child: ColorFiltered(
                                                                                                    colorFilter: nama_filter == 'greyscale'
                                                                                                        ? const ColorFilter.mode(
                                                                                                            Color.fromARGB(255, 139, 139, 139),
                                                                                                            BlendMode.saturation,
                                                                                                          )
                                                                                                        : nama_filter == 'classic negative'
                                                                                                            ? const ColorFilter.mode(
                                                                                                                Color.fromARGB(229, 255, 247, 220),
                                                                                                                BlendMode.saturation,
                                                                                                              )
                                                                                                            : nama_filter == 'black white blur'
                                                                                                                ? const ColorFilter.mode(
                                                                                                                    Color.fromARGB(229, 255, 247, 220),
                                                                                                                    BlendMode.saturation,
                                                                                                                  )
                                                                                                                : nama_filter == 'mute'
                                                                                                                    ? const ColorFilter.mode(
                                                                                                                        Color.fromARGB(228, 151, 151, 151),
                                                                                                                        BlendMode.saturation,
                                                                                                                      )
                                                                                                                    : nama_filter == 'webcore'
                                                                                                                        ? const ColorFilter.mode(
                                                                                                                            Color.fromARGB(228, 112, 89, 130),
                                                                                                                            BlendMode.saturation,
                                                                                                                          )
                                                                                                                        : const ColorFilter.mode(
                                                                                                                            Color.fromARGB(0, 255, 255, 255),
                                                                                                                            BlendMode.saturation,
                                                                                                                          ),
                                                                                                    child: Container(
                                                                                                      child: FadeInImage(
                                                                                                        width: width * 0.08,
                                                                                                        height: height * 0.15,
                                                                                                        image: NetworkImage("${Variables.ipv4_local}/storage/${list[0].toString()}", scale: 1),
                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.contain);
                                                                                                        },
                                                                                                        fit: BoxFit.contain,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : Container())
                                                                                        : Container(),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.015),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                                backgroundColor: Colors.black.withOpacity(0.7),
                              ),
                              onPressed: () {
                                // do onpressed... last
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: HalamanAwal(
                                        backgrounds: bgImg,
                                        header: headerImg,
                                      ),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: SizedBox(
                                width: width * 0.15,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.arrow_circle_left_outlined,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Kembali".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width * 0.010,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.35,
                    color: bg_warna_main != ""
                        ? HexColor(bg_warna_main)
                        : Colors.transparent,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * 0.012,
                            bottom: width * 0.012,
                          ),
                          child: Text(
                            "Pilih Filter",
                            style: TextStyle(
                              fontSize: width * 0.018,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // menu filter beauty
                        Padding(
                          padding: EdgeInsets.all(
                            width * 0.015,
                          ),
                          child: Container(
                            height: height * 0.55,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: width * 0.015,
                                runSpacing: width * 0.015,
                                children: [
                                  // ....
                                  for (var filter in filters)
                                    if (filter['status'] == 'aktif')
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            nama_filter = filter['nama'];
                                          });
                                          print("nama filter : $nama_filter");
                                        },
                                        child: Container(
                                          height: height * 0.23,
                                          width: height * 0.23,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [],
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.0045),
                                            child: Column(
                                              children: [
                                                ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.transparent,
                                                    BlendMode.saturation,
                                                  ),
                                                  child: Container(
                                                    width: width * 0.15,
                                                    height: height * 0.15,
                                                    child: FadeInImage(
                                                      width: width * 0.15,
                                                      height: height * 0.15,
                                                      image: NetworkImage(
                                                          "${Variables.ipv4_local}/storage/uploads/rama/man.jpg",
                                                          scale: 1),
                                                      placeholder: AssetImage(
                                                          "assets/props/shapes/16_shapes_v1.png"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/props/shapes/16_shapes_v1.png',
                                                            fit:
                                                                BoxFit.contain);
                                                      },
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                Text(
                                                  filter["nama"],
                                                  style: TextStyle(
                                                    fontSize: width * 0.008,
                                                    color: const Color.fromARGB(
                                                        255, 102, 102, 102),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // ............
                        OutlinedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            backgroundColor: Colors.black.withOpacity(0.7),
                          ),
                          onPressed: () {
                            // do onpressed...

                            deleteFolder();
                          },
                          child: SizedBox(
                            // color: Colors.transparent,
                            width: width * 0.25,
                            // height: height * 0.012,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Stack(
                                children: <Widget>[
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.menu_open_outlined,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Selanjutnya".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: width * 0.010,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LockScreenFotoEditWidget extends StatefulWidget {
  LockScreenFotoEditWidget({super.key, required this.background});

  final background;
  @override
  State<LockScreenFotoEditWidget> createState() =>
      _LockScreenFotoEditWidgetState(this.background);
}

class _LockScreenFotoEditWidgetState extends State<LockScreenFotoEditWidget> {
  _LockScreenFotoEditWidgetState(this.background);
  final background;
  final double barHeight = 10.0;

  // colors wave
  // static const _backgroundColor = bg_warna_main != "" ? HexColor(bg_warna_main) : Colors.transparent;

  static const _colors = [
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

  var edit;
  var nama;
  var title;

  // ignore: unused_field
  late Timer _timer;
  var counter = 600;
  var voucher = "";
  var db = new Mysql();

  bool isNavigate = true;
  bool isVisibleTapCard = true;
  bool isVisibleTapDialog = false;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  List<dynamic> backgrounds = [];

  String headerImg = "";
  String bgImg = "";

  final LocalStorage storage = new LocalStorage('serial_key');

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      isNavigate = true;
    });

    getWarnaBg();
    getOrderSettings();
    getStorage();

    super.initState();
  }

  void getStorage() async {
    var ready = await storage.ready;
    if (ready == true) {
      setState(() {});
      bgImg = await storage.getItem('background_images');
    }
  }

  getOrderSettings() async {
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/order-get'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      backgrounds.addAll(result);
      for (var element in background) {
        setState(() {
          headerImg = element["header_image"];
          bgImg = element["background_image"];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getWarnaBg() async {
    db.getConnection().then(
      (value) {
        String sql = "select * from `main_color`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              bg_warna_main = row[1];
              warna1 = row[2];
              warna2 = row[3];
            });
          } // Finally, close the connection
        }).then((value) {
          // ...
        });
        return value.close();
      },
    );
  }

  _updateVoucher(nama, voucher) async {
    db.getConnection().then(
      (value) {
        String sql =
            "UPDATE `user_fotos` SET status_voucher = 'belum' WHERE `nama` = '$nama' AND `status_voucher`= 'belum' AND `voucher`= '$voucher';";
        value.query(sql).then((value) {
          print(
              "berhasil update user $nama, voucher : $voucher status sudah, value : $value");
          getUser(voucher);
        });
        return value.close();
      },
    );
  }

  getUser(voucher) async {
    db.getConnection().then(
      (value) {
        String sql = "SELECT * FROM `user_fotos` WHERE `voucher` = '$voucher';";
        value.query(sql).then((value) {
          for (var row in value) {
            // if() {
            // }
            print(row);
            setState(() {
              title = row[4];
            });
            print("object title : $title");

            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: FilterWidget(
                  nama: row[1],
                  title: row[4],
                  backgrounds: background,
                ),
                inheritTheme: true,
                ctx: context,
              ),
            );
          }
        });
        return value.close();
      },
    );
  }

  Future<void> _dialogBuilderVoucher(BuildContext context, width) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(seconds: 1),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.transparent,
            child: Card(
              color: Colors.transparent,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    backgroundColor: bg_warna_main != ""
                        ? HexColor(bg_warna_main)
                        : Colors.transparent,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 50),
                      child: Text(
                        "Masukkan Kode",
                        style: const TextStyle(
                          fontSize: 56,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    actions: <Widget>[
                      // input voucher
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: width * 0.0, left: width * 0.0),
                          child: SizedBox(
                            width: width * 0.25,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'Masukkan Kode',
                                  hintStyle: TextStyle(
                                    color: bg_warna_main != ""
                                        ? HexColor(bg_warna_main)
                                        : Colors.transparent,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 5,
                                    bottom: 5,
                                    top: 5,
                                    right: 5,
                                  ),
                                  focusColor: bg_warna_main != ""
                                      ? HexColor(bg_warna_main)
                                      : Colors.transparent,
                                  fillColor: bg_warna_main != ""
                                      ? HexColor(bg_warna_main)
                                      : Colors.transparent,
                                  label: Text(
                                    "Kode",
                                    style: TextStyle(
                                      color: bg_warna_main != ""
                                          ? HexColor(bg_warna_main)
                                          : Colors.transparent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: bg_warna_main != ""
                                      ? HexColor(bg_warna_main)
                                      : Colors.transparent,
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    voucher = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // end input voucher ...
                      SizedBox(
                        height: width * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: bg_warna_main != ""
                                      ? HexColor(bg_warna_main)
                                      : Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                isVisibleTapCard = !isVisibleTapCard;
                              });
                            },
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          OutlinedButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Input',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: bg_warna_main != ""
                                      ? HexColor(bg_warna_main)
                                      : Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              // ...
                              _updateVoucher(nama, voucher);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // dialog
  Future<void> _showMyDialogVoucher(voucher) async {
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
                      return s == voucher.toString()
                          ? null
                          : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (voucher) {
                      print(voucher);
                      if (voucher == voucher.toString()) {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: FilterWidget(
                                nama: nama,
                                title: title,
                                backgrounds: background,
                              ),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "${Variables.ipv4_local}/storage/order/background-image/$background"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.12,
              width: width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: width * 0.008,
                  ),
                  Container(
                    height: width * 0.035,
                    width: width * 1,
                    color: warna1 != "" ? HexColor(warna1) : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.008,
                        ),
                        Container(
                          // margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              // ...
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: HalamanAwal(
                                    backgrounds: backgrounds,
                                    header: null,
                                  ),
                                  inheritTheme: true,
                                  ctx: context,
                                ),
                              );
                            },
                            child: FaIcon(
                              FontAwesomeIcons.caretLeft,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.008,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                    width: width * 1,
                    child: Container(
                      height: height * 0.025,
                      width: width * 1,
                      child: WaveWidget(
                        config: CustomConfig(
                          colors: [
                            bg_warna_main != ""
                                ? HexColor(bg_warna_main)
                                : Colors.transparent,
                            bg_warna_main != ""
                                ? HexColor(bg_warna_main)
                                : Colors.transparent,
                          ],
                          durations: _durations,
                          heightPercentages: _heightPercentages,
                        ),
                        backgroundColor: bg_warna_main != ""
                            ? HexColor(bg_warna_main)
                            : Colors.transparent,
                        size: const Size(double.infinity, double.infinity),
                        waveAmplitude: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: width * 0.08,
            ),
            AnimatedOpacity(
              opacity: isVisibleTapCard == true ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                // color: Color.fromARGB(255, 255, 123, 145),
                height: height * 0.55,

                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(
                          width: 20, color: Color.fromARGB(255, 255, 255, 255)),
                      color: bg_warna_main != ""
                          ? HexColor(bg_warna_main)
                          : Colors.transparent,
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                      onTap: () {
                        print("scan qr code tap");
                        // _dialogBuilder(context);
                        _dialogBuilderVoucher(context, width);
                        setState(() {
                          isVisibleTapCard = !isVisibleTapCard;
                          isVisibleTapDialog = !isVisibleTapDialog;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: width * 0.02,
                          bottom: width * 0.02,
                          left: width * 0.2,
                          right: width * 0.2,
                        ),
                        child: Text(
                          "Input Kode - Edit Photo",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
