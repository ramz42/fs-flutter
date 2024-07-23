// ignore_for_file: duplicate_import, unused_import, unused_local_variable

import 'package:page_transition/page_transition.dart';
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
  FilterWidget(
      {super.key,
      required this.nama,
      required this.title,
      required this.backgrounds});
  final nama;
  final title;
  final backgrounds;

  @override
  State<FilterWidget> createState() =>
      _FilterWidgetState(nama, title, backgrounds);
}

class _FilterWidgetState extends State<FilterWidget> {
  _FilterWidgetState(this.nama, this.title, this.backgrounds);

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
  // static const _backgroundColor = bg_warna_main != "" ? Color(int.parse(bg_warna_main)) : Colors.transparent;

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

  //Create an instance of ScreenshotController
  // ...
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

  @override
  void initState() {
    // TODO: implement initState

    // init get all images from functions
    _getAllImages();

    print(
        "title contains a pada filter page : ${title.toString().contains("Collage A")}");
    // init get filter from functions
    getFilter();
    getWarnaBg();
    getOrderSettings();

    // test print logger nama dan tittle user
    print("nama initstate filterwidget : $nama");
    print("title pada initstate filterwidget : $title");

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
      // print("background : ${background}");
      for (var element in background) {
        // print("background_image : ${element["background_image"]}");
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

      // filter beauty methods
      if (title.toString().contains("collage a") ||
          title.toString().contains("Collage A") ||
          title.toString().contains(" a") ||
          title.toString().contains(" A") ||
          title.toString().contains("Paket A")) {
        print("tipe a");
        screenCaptureImages(0, 0);
        screenCaptureImages(0, 1);
        screenCaptureImages(0, 2);
        screenCaptureImages(0, 3);

        screenCaptureImages(1, 0);
        screenCaptureImages(1, 1);
        screenCaptureImages(1, 2);
        screenCaptureImages(1, 3);
      }
      if (title.toString().contains("collage b") ||
          title.toString().contains("Collage B") ||
          title.toString().contains(" b") ||
          title.toString().contains(" B") ||
          title.toString().contains("Paket B")) {
        print("tipe b");
        screenCaptureImages(0, 0);
        screenCaptureImages(0, 1);
        screenCaptureImages(0, 2);
        screenCaptureImages(0, 3);

        screenCaptureImages(1, 0);
        screenCaptureImages(1, 1);
        screenCaptureImages(1, 2);
        screenCaptureImages(1, 3);

        screenCaptureImages(2, 0);
        screenCaptureImages(2, 1);
        screenCaptureImages(2, 2);
        screenCaptureImages(2, 3);

        screenCaptureImages(3, 0);
        screenCaptureImages(3, 1);
        screenCaptureImages(3, 2);
        screenCaptureImages(3, 3);

        screenCaptureImagesEdit(0, 0);
        screenCaptureImagesEdit(0, 1);
        screenCaptureImagesEdit(0, 2);
        screenCaptureImagesEdit(0, 3);
        screenCaptureImagesEdit(1, 0);
        screenCaptureImagesEdit(1, 1);
        screenCaptureImagesEdit(1, 2);
        screenCaptureImagesEdit(1, 3);
        screenCaptureImagesEdit(2, 0);
        screenCaptureImagesEdit(2, 1);
        screenCaptureImagesEdit(2, 2);
        screenCaptureImagesEdit(2, 3);
        screenCaptureImagesEdit(3, 0);
        screenCaptureImagesEdit(3, 1);
        screenCaptureImagesEdit(3, 2);
        screenCaptureImagesEdit(3, 3);
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

  screenCaptureImages(i, j) async {
    final directory =
        (await getApplicationDocumentsDirectory()); //from path_provide package

    var fileName = "\\${DateTime.now().day}-1";
    var path = '$directory';

    if (title.toString().contains("Collage A") ||
        title.toString().contains("collage a") ||
        title.toString().contains("Strip A") ||
        title.toString().contains("strip a") ||
        title.toString().contains("Paket A")) {
      //
      if ((i == 0 && j == 0)) {
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
      }
      if ((i == 0 && j == 1)) {
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
      }

      if ((i == 0 && j == 2)) {
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
      }

      if ((i == 0 && j == 3)) {
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
      }

      if ((i == 1 && j == 0)) {
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
      }

      if ((i == 1 && j == 1)) {
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
      }

      if ((i == 1 && j == 2)) {
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-7"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 3)) {
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-8"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // ...
      // save on edit folder
      // ...
      if ((i == 0 && j == 0)) {
        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-1"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }
      if ((i == 0 && j == 1)) {
        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-2"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 2)) {
        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-3"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 3)) {
        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-4"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 0)) {
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-5"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 1)) {
        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-6"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 2)) {
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-7"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 3)) {
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-8"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }
    } else {
      // baris pertama
      if ((i == 0 && j == 0)) {
        // ...
        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-a"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 1)) {
        // ...
        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-b"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 2)) {
        // ...
        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-c"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 3)) {
        // ...
        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-d"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 2
      if ((i == 1 && j == 0)) {
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-e"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 1)) {
        // ...
        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-f"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 2)) {
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-g"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 3)) {
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-h"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 3
      if ((i == 2 && j == 0)) {
        // ...
        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-i"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 1)) {
        // ...
        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-j"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 2)) {
        // ...
        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-k"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 3)) {
        // ...
        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-l"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 3
      if ((i == 3 && j == 0)) {
        // ...
        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-m"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 1)) {
        // ...
        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-n"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 2)) {
        // ...
        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-o"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 3)) {
        // ...
        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-p"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }
    }
  }

  screenCaptureImagesEdit(i, j) async {
    final directory =
        (await getApplicationDocumentsDirectory()); //from path_provide package

    var fileName = "\\${DateTime.now().day}-1";
    var path = '$directory';

    if (title.toString().contains("Collage A") ||
        title.toString().contains("collage a") ||
        title.toString().contains("Strip A") ||
        title.toString().contains("strip a") ||
        title.toString().contains("Paket A")) {
      //
      if ((i == 0 && j == 0)) {
        // ...
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
      }
      if ((i == 0 && j == 1)) {
        // ...
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
      }

      if ((i == 0 && j == 2)) {
        // ...
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
      }

      if ((i == 0 && j == 3)) {
        // ...
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
      }

      if ((i == 1 && j == 0)) {
        // ...
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
      }

      if ((i == 1 && j == 1)) {
        // ...
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

      if ((i == 1 && j == 2)) {
        // ...
        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-7"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 3)) {
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-8"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }
    } else {
      // baris pertama
      if ((i == 0 && j == 0)) {
        // ...

        screenshotController1
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-a"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 1)) {
        // ...

        screenshotController2
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-b"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 2)) {
        // ...

        screenshotController3
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-c"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 0 && j == 3)) {
        // ...

        screenshotController4
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-d"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 2
      if ((i == 1 && j == 0)) {
        // ...
        screenshotController5
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-e"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 1)) {
        // ...

        screenshotController6
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-f"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 2)) {
        // ...

        screenshotController7
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-g"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 1 && j == 3)) {
        // ...
        screenshotController8
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-h"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 3
      if ((i == 2 && j == 0)) {
        // ...

        screenshotController9
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-i"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 1)) {
        // ...

        screenshotController10
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-j"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 2)) {
        // ...

        screenshotController11
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-k"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 2 && j == 3)) {
        // ...

        screenshotController12
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-l"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      // baris ke 3
      if ((i == 3 && j == 0)) {
        // ...

        screenshotController13
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-m"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 1)) {
        // ...

        screenshotController14
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-n"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 2)) {
        // ...

        screenshotController15
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-o"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }

      if ((i == 3 && j == 3)) {
        // ...

        screenshotController16
            .captureAndSave(
          '${directory.path}/${Variables.folder_img_path_edit}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
          fileName: "${"\\${DateTime.now().day}-p"}.png",
        )
            .then((capturedImage) async {
          print("object : $capturedImage");
        }).catchError((onError) {
          print(onError);
        });
      }
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
        for (var i = 0; i < 8; i++) {
          print("list a for loop");
          // ...
          print("object _list collage A $i ${_list[i]}");
          list.add(_list[i]);
        }
      }
      if (title.toString().contains("Collage B") ||
          title.toString().contains("Paket B")) {
        // list.addAll(_list[i]);
        for (var i = 0; i < 16; i++) {
          // ...
          print("object _list collage B $i ${_list[i]}");
          list.add(_list[i]);
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "${Variables.ipv4_local}/storage/order/background-image/$backgrounds"),
            fit: BoxFit.cover,
          ),
        ),
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
                    color: bg_warna_main != ""
                        ? Color(int.parse(bg_warna_main))
                        : Colors.transparent,
                  ),
                  Container(
                    height: width * 0.035,
                    width: width * 1,
                    color: bg_warna_main != ""
                        ? Color(int.parse(bg_warna_main))
                        : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: width * 0.022,
                            color: const Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Icon(
                        //   Icons.arrow_right,
                        //   size: 25,
                        //   color: Colors.white,
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Text(
                        //   "Review",
                        //   style: TextStyle(
                        //     fontSize: width * 0.022,
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.025,
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
                      backgroundColor: bg_warna_main != ""
                          ? Color(int.parse(bg_warna_main))
                          : Colors.transparent,
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
              //       decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: NetworkImage(
              //         "${Variables.ipv4_local}/storage/order/background-image/$bgImg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
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
                                            : 4,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, i) {
                                          // ...
                                          return SizedBox(
                                            // width: width * 1,
                                            height: height * 0.3,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(8),
                                              itemCount: 4,
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
                                                          width: width * 0.14,
                                                          height: 100,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    width *
                                                                        0.0045),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                // ontap
                                                                // ignore: avoid_print
                                                                print(
                                                                  "object i dan j : $i dan $j",
                                                                );
                                                                print(
                                                                  "nama_filter : $nama_filter",
                                                                );
                                                              },
                                                              child: i == 0 &&
                                                                      j == 0
                                                                  ? Screenshot(
                                                                      controller:
                                                                          screenshotController1,
                                                                      child:
                                                                          Container(
                                                                        width: width *
                                                                            0.12,
                                                                        height: height *
                                                                            0.3,
                                                                        child:
                                                                            ColorFiltered(
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
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: NetworkImage(
                                                                                  "${Variables.ipv4_local}/storage/${list[0].toString()}",
                                                                                ),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : i == 0 &&
                                                                          j == 1
                                                                      ? Screenshot(
                                                                          controller:
                                                                              screenshotController2,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                width * 0.12,
                                                                            height:
                                                                                height * 0.3,
                                                                            child:
                                                                                ColorFiltered(
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
                                                                                decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      "${Variables.ipv4_local}/storage/${list[1].toString()}",
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : i == 0 &&
                                                                              j == 2
                                                                          ? Screenshot(
                                                                              controller: screenshotController3,
                                                                              child: Container(
                                                                                width: width * 0.12,
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
                                                                                    decoration: BoxDecoration(
                                                                                      image: DecorationImage(
                                                                                        image: NetworkImage(
                                                                                          "${Variables.ipv4_local}/storage/${list[2].toString()}",
                                                                                        ),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : i == 0 && j == 3
                                                                              ? Screenshot(
                                                                                  controller: screenshotController4,
                                                                                  child: Container(
                                                                                    width: width * 0.12,
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
                                                                                        decoration: BoxDecoration(
                                                                                          image: DecorationImage(
                                                                                            image: NetworkImage(
                                                                                              "${Variables.ipv4_local}/storage/${list[3].toString()}",
                                                                                            ),
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : i == 1 && j == 0
                                                                                  ? Screenshot(
                                                                                      controller: screenshotController5,
                                                                                      child: Container(
                                                                                        width: width * 0.12,
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
                                                                                            decoration: BoxDecoration(
                                                                                              image: DecorationImage(
                                                                                                image: NetworkImage(
                                                                                                  "${Variables.ipv4_local}/storage/${list[4].toString()}",
                                                                                                ),
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : i == 1 && j == 1
                                                                                      ? Screenshot(
                                                                                          controller: screenshotController6,
                                                                                          child: Container(
                                                                                            width: width * 0.12,
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
                                                                                                decoration: BoxDecoration(
                                                                                                  image: DecorationImage(
                                                                                                    image: NetworkImage(
                                                                                                      "${Variables.ipv4_local}/storage/${list[5].toString()}",
                                                                                                    ),
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : i == 1 && j == 2
                                                                                          ? Screenshot(
                                                                                              controller: screenshotController7,
                                                                                              child: Container(
                                                                                                width: width * 0.12,
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
                                                                                                    decoration: BoxDecoration(
                                                                                                      image: DecorationImage(
                                                                                                        image: NetworkImage(
                                                                                                          "${Variables.ipv4_local}/storage/${list[6].toString()}",
                                                                                                        ),
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : i == 1 && j == 3
                                                                                              ? Screenshot(
                                                                                                  controller: screenshotController8,
                                                                                                  child: Container(
                                                                                                    width: width * 0.12,
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
                                                                                                        decoration: BoxDecoration(
                                                                                                          image: DecorationImage(
                                                                                                            image: NetworkImage(
                                                                                                              "${Variables.ipv4_local}/storage/${list[7].toString()}",
                                                                                                            ),
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              : i == 2 && j == 0 && list[8] != null
                                                                                                  ? Screenshot(
                                                                                                      controller: screenshotController9,
                                                                                                      child: Container(
                                                                                                        width: width * 0.12,
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
                                                                                                            decoration: BoxDecoration(
                                                                                                              image: DecorationImage(
                                                                                                                image: NetworkImage(
                                                                                                                  "${Variables.ipv4_local}/storage/${list[8].toString()}",
                                                                                                                ),
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : i == 2 && j == 1 && list[9] != null
                                                                                                      ? Screenshot(
                                                                                                          controller: screenshotController10,
                                                                                                          child: Container(
                                                                                                            width: width * 0.12,
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
                                                                                                                decoration: BoxDecoration(
                                                                                                                  image: DecorationImage(
                                                                                                                    image: NetworkImage(
                                                                                                                      "${Variables.ipv4_local}/storage/${list[9].toString()}",
                                                                                                                    ),
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                      : i == 2 && j == 2 && list[10] != null
                                                                                                          ? Screenshot(
                                                                                                              controller: screenshotController11,
                                                                                                              child: Container(
                                                                                                                width: width * 0.12,
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
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      image: DecorationImage(
                                                                                                                        image: NetworkImage(
                                                                                                                          "${Variables.ipv4_local}/storage/${list[10].toString()}",
                                                                                                                        ),
                                                                                                                        fit: BoxFit.cover,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            )
                                                                                                          : i == 2 && j == 3 && list[11] != null
                                                                                                              ? Screenshot(
                                                                                                                  controller: screenshotController12,
                                                                                                                  child: Container(
                                                                                                                    width: width * 0.12,
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
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          image: DecorationImage(
                                                                                                                            image: NetworkImage(
                                                                                                                              "${Variables.ipv4_local}/storage/${list[11].toString()}",
                                                                                                                            ),
                                                                                                                            fit: BoxFit.cover,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                )
                                                                                                              : i == 3 && j == 0 && list[12] != null
                                                                                                                  ? Screenshot(
                                                                                                                      controller: screenshotController13,
                                                                                                                      child: Container(
                                                                                                                        width: width * 0.12,
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
                                                                                                                            decoration: BoxDecoration(
                                                                                                                              image: DecorationImage(
                                                                                                                                image: NetworkImage(
                                                                                                                                  "${Variables.ipv4_local}/storage/${list[12].toString()}",
                                                                                                                                ),
                                                                                                                                fit: BoxFit.cover,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  : i == 3 && j == 1 && list[13] != null
                                                                                                                      ? Screenshot(
                                                                                                                          controller: screenshotController14,
                                                                                                                          child: Container(
                                                                                                                            width: width * 0.12,
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
                                                                                                                                decoration: BoxDecoration(
                                                                                                                                  image: DecorationImage(
                                                                                                                                    image: NetworkImage(
                                                                                                                                      "${Variables.ipv4_local}/storage/${list[13].toString()}",
                                                                                                                                    ),
                                                                                                                                    fit: BoxFit.cover,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      : i == 3 && j == 2 && list[14] != null
                                                                                                                          ? Screenshot(
                                                                                                                              controller: screenshotController15,
                                                                                                                              child: Container(
                                                                                                                                width: width * 0.12,
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
                                                                                                                                    decoration: BoxDecoration(
                                                                                                                                      image: DecorationImage(
                                                                                                                                        image: NetworkImage(
                                                                                                                                          "${Variables.ipv4_local}/storage/${list[14].toString()}",
                                                                                                                                        ),
                                                                                                                                        fit: BoxFit.cover,
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          : list[15] != null
                                                                                                                              ? Screenshot(
                                                                                                                                  controller: screenshotController16,
                                                                                                                                  child: Container(
                                                                                                                                    width: width * 0.12,
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
                                                                                                                                        decoration: BoxDecoration(
                                                                                                                                          image: DecorationImage(
                                                                                                                                            image: NetworkImage(
                                                                                                                                              "${Variables.ipv4_local}/storage/${list[15].toString()}",
                                                                                                                                            ),
                                                                                                                                            fit: BoxFit.cover,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              : Container(),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              },
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
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              onPressed: () {
                                // do onpressed... last
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: HalamanAwal(
                                        backgrounds: backgrounds,
                                      ),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: SizedBox(
                                // color: Colors.transparent,
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
                                          color:
                                              Color.fromARGB(255, 96, 96, 96),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Kembali".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width * 0.010,
                                              color: const Color.fromARGB(
                                                  255, 96, 96, 96),
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
                        ? Color(int.parse(bg_warna_main))
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
                        OutlinedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            // do onpressed...

                            // filter beauty methods
                            filterBeauty();
                          },
                          child: SizedBox(
                            // color: Colors.transparent,
                            width: width * 0.25,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                "Filter Beauty : $isFilterBeauty",
                                style: TextStyle(
                                  fontSize: width * 0.010,
                                  color: const Color.fromARGB(255, 96, 96, 96),
                                ),
                                textAlign: TextAlign.center,
                              ),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: width * 0.01,
                                runSpacing: width * 0.01,
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
                                                    width: width * 0.08,
                                                    height: height * 0.18,
                                                    decoration:
                                                        const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          "assets/images/man.jpg",
                                                        ),
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                          BlendMode.modulate,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    child: ClipRect(
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 0,
                                                                sigmaY: 0),
                                                        child: Container(
                                                          color: const Color
                                                                  .fromARGB(94,
                                                                  255, 255, 255)
                                                              .withOpacity(0.1),
                                                        ),
                                                      ),
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
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
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
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Selanjutnya".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: width * 0.010,
                                          color: const Color.fromARGB(
                                              255, 96, 96, 96),
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
  // static const _backgroundColor = bg_warna_main != "" ? Color(int.parse(bg_warna_main)) : Colors.transparent;

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
    // timerPeriodFunc(); // timer periodic functions\

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

    print("status ready storage : $ready");
    if (ready == true) {
      setState(() {});

      bgImg = await storage.getItem('background_images');

      // print("background_storage : $bgImg");
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
      // print("background : ${backgrounds}");
      for (var element in background) {
        // print("background_image : ${element["background_image"]}");
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
          // print("bg main color : $bg_warna_main");
          // print("bg main color : $warna1");
          // print("bg main color : $warna2");
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

  Future<void> timerPeriodFunc() async {
    // ...
    // new timer periodic
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // ignore: avoid_print
      print('timer : ${timer.tick}');
      counter--;
      if (counter == 0) {
        print('Cancel timer');
        timer.cancel();
      } else {
        // ...
        getEditData();
      }
    });
  }

  // get data edit foto lock - open page
  getEditData() async {
    // print("get edit data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `edit_photo`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              edit = row;
            });
            if (edit[1] == "buka") {
              isNavigate == true
                  ? {
                      setState(() {
                        counter = 0;
                        nama = edit[2];
                        title = edit[3];
                        isNavigate = false;
                      }),
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: FilterWidget(
                              nama: nama,
                              title: title,
                              backgrounds: bgImg,
                            ),
                            inheritTheme: true,
                            ctx: context),
                      ),
                    }
                  : null;
            }
          }
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
          getUser(nama);
        });
        return value.close();
      },
    );
  }

  getUser(nama) async {
    db.getConnection().then(
      (value) {
        String sql = "SELECT * FROM `user_fotos` WHERE `nama` = '$nama';";
        value.query(sql).then((value) {
          for (var row in value) {
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
                    title: title,
                    backgrounds: background,
                  ),
                  inheritTheme: true,
                  ctx: context),
            );
          }
          print(" value : $value");
        });
        return value.close();
      },
    );
  }

  Future<void> _dialogBuilderVoucher(BuildContext context, width) {
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: AlertDialog(
                  backgroundColor: Color.fromARGB(218, 33, 33, 33),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 50),
                    child: Text(
                      "Voucher Input",
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
                      "Masukkan Nama dan Voucher",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  actions: <Widget>[
                    // input nama
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
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                hintText: 'Masukkan Nama',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                  right: 5,
                                ),
                                focusColor: Colors.black,
                                fillColor: Colors.black,
                                label: Text(
                                  "Nama",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 53, 53, 53),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                print("object value : $value");
                                setState(() {
                                  nama = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // end input nama ...

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
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                hintText: 'Masukkan Voucher',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                  right: 5,
                                ),
                                focusColor: Colors.black,
                                fillColor: Colors.black,
                                label: Text(
                                  "Voucher",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 53, 53, 53),
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
                        SizedBox(
                          width: 25,
                        ),
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
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.12,
              width: width * 1,
              child: Column(
                children: [
                  Container(
                    height: width * 0.035,
                    width: width * 1,
                    color: bg_warna_main != ""
                        ? Color(int.parse(bg_warna_main))
                        : Colors.transparent,
                  ),
                  SizedBox(
                    height: height * 0.035,
                    width: width * 1,
                    child: bg_warna_main != ""
                        ? WaveWidget(
                            config: CustomConfig(
                              colors: [
                                Color(int.parse(warna1)),
                                Color(int.parse(warna2))
                              ],
                              durations: _durations,
                              heightPercentages: _heightPercentages,
                            ),
                            backgroundColor: bg_warna_main != ""
                                ? Color(int.parse(bg_warna_main))
                                : Colors.transparent,
                            size: const Size(double.infinity, double.infinity),
                            waveAmplitude: 0,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: width * 0.08,
            ),
            SizedBox(
              // color: Color.fromARGB(255, 255, 123, 145),
              height: height * 0.55,
              child: Center(
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        45,
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
                      print("scan qr code tap");
                      // _dialogBuilder(context);
                      _dialogBuilderVoucher(context, width);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: width * 0.06,
                        bottom: width * 0.06,
                        left: width * 0.05,
                        right: width * 0.05,
                      ),
                      child: Text(
                        "Scan Qr Anda \n\nAtau Tap Untuk Memasukkan Voucher",
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
          ],
        ),
      ),
    );
  }
}
