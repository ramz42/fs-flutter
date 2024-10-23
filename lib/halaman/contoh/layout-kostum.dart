// ignore_for_file: unused_import

import 'package:fs_dart/halaman/edit/background.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fs_dart/halaman/edit/filter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fs_dart/src/database/db.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'dart:convert';
import 'dart:async';

import '../awal/halaman_awal.dart';

class LayoutNewWidget extends StatefulWidget {
  LayoutNewWidget({
    super.key,
    required this.nama,
    required this.title,
    required this.nama_filter,
    required this.backgrounds,
  });

  final nama;
  final title;
  final nama_filter;
  final backgrounds;

  @override
  State<LayoutNewWidget> createState() => _LayoutNewWidgetState(
      this.nama, this.title, this.nama_filter, this.backgrounds);
}

class _LayoutNewWidgetState extends State<LayoutNewWidget> {
  _LayoutNewWidgetState(
      this.nama, this.title, this.nama_filter, this.backgrounds);

  final backgrounds;

  late PhotoViewControllerBase? controller;
  late PhotoViewScaleStateController? scaleStateController;

  double _currentSliderValuePutarGambar = 0;
  double _currentSliderValueSkalaGambar = 1;

  static const double minScale = 0.75;
  static const double defScale = 0.6;
  static const double maxScale = 1.55;

  int calls = 0;

  // ...
  double x = 0;
  double y = 0;
  double zoom = 0;

  double size_image = 0.13;

  List<dynamic> listUploads = [];
  List<dynamic> list = [];

  List<dynamic> listA = [];
  List<dynamic> listB = [];
  List<dynamic> listC = [];
  List<dynamic> listD = [];
  List<dynamic> listE = [];
  List<dynamic> listF = [];
  List<dynamic> listG = [];
  List<dynamic> listH = [];

  List dragItem = [];
  List dragItemB = [];
  List dragItemC = [];
  List dragItemD = [];

  List dragItemB1 = [];
  List dragItemB2 = [];

  List dragItemD1 = [];
  List dragItemD2 = [];

  List acceptedData1 = [];
  List acceptedData2 = [];
  List acceptedData3 = [];
  List acceptedData4 = [];
  List acceptedData5 = [];
  List acceptedData6 = [];
  List acceptedData7 = [];
  List acceptedData8 = [];
  List acceptedData9 = [];

  List acceptedData1_1 = [];
  List acceptedData1_2 = [];
  List acceptedData1_3 = [];
  List acceptedData1_4 = [];
  List acceptedData1_5 = [];
  List acceptedData1_6 = [];
  List acceptedData1_7 = [];
  List acceptedData1_8 = [];
  List acceptedData1_9 = [];

  final nama_filter;
  final nama;
  final title;

  var dragItems;
  var stores;

  List acceptedData = [];

  List dataCard1 = [];
  List dataCard2 = [];

  String deskripsi = "";
  String nama_user = "";
  String email_user = "";
  String ig = "";
  String index = "";

  // background image dan header variables
  List<dynamic> background = [];
  List<dynamic> layouts = [];
  String headerImg = "";
  String bgImg = "";
  // ...

  int lengthDataImages = 0;
  int no_telp = 0;
  int harga = 0;

  bool isadded = false;
  bool isFilterBeauty = false;
  bool isOnWillAccept = false;
  bool isAccept = false;

  bool isLayout1 = false;
  bool isLayout2 = false;
  bool isLayout3 = false;
  bool isLayout4 = false;
  bool isLayout5 = false;
  bool isLayout6 = false;

  bool isChoose1 = false;
  bool isChoose2 = false;
  bool isKanvasEmpty = true;

  var choose_layoutB1 = "";
  var choose_layoutB2 = "";

  var choose1 = ""; // Set Parameter choose1
  var choose2 = "";

  var db = new Mysql();

  var foto_details = "";
  var foto_details_oncomplete = "";

  int jumlah_drag_complete = 0;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  var image_name = "";

  // colors...
  final double barHeight = 10.0;

  // colors wave
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
  ScreenshotController screenshotController = ScreenshotController();

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

  final LocalStorage storage = new LocalStorage('serial_key');

  @override
  void initState() {
    // === test print logger ===
    // ===
    _clearStorage();
    _getDataImages();
    getLayout();

    getWarnaBg();
    getOrderSettings();
    getStorage();

    controller = PhotoViewController(initialScale: defScale)
      ..outputStateStream.listen(onController);

    scaleStateController = PhotoViewScaleStateController()
      ..outputScaleStateStream.listen(onScaleState);

    super.initState();
  }

  // get layout
  getLayout() async {
    var request = http.Request(
        'GET', Uri.parse('${Variables.ipv4_local}/api/layout-kostum'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      layouts.addAll(result);
      for (var element in layouts) {
        if (element['status'] == 'Aktif') {
          print("object : ${element['nama']}");
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // ignore: unused_element
  _saveCard1PilihKanvasWithImage(layout) async {
    // ...
    await storage.setItem('dataCard1', dataCard1);
  }

  // ignore: unused_element
  _saveCard2PilihKanvasWithImage(layout) async {
    // ...
    await storage.setItem('dataCard2', dataCard2);
  }

  // ignore: unused_element
  _getLayoutWithStorage() async {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        choose1 = storage.getItem('choose1') ?? "";
        choose2 = storage.getItem('choose2') ?? "";
      });
    });
    print("object get storage choose1 & choose2 : $choose1, $choose2");
  }

  // ignore: unused_element
  _saveLayoutWithStorageB1() async {
    if (isLayout1 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout1";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");

      await storage.setItem('choose1', 'layout1');
    }
    if (isLayout2 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout2";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");

      await storage.setItem('choose1', 'layout2');
    }
    if (isLayout3 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout3";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");
      await storage.setItem('choose1', 'layout3');
    }
    if (isLayout4 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout4";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");
      await storage.setItem('choose1', 'layout4');
    }
    if (isLayout5 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout5";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");
      await storage.setItem('choose1', 'layout5');
    }
    if (isLayout6 == true) {
      // ...
      setState(() {
        choose_layoutB1 = "layout6";
      });
      print("object data layout yang dipilih b1 : $choose_layoutB1");
      await storage.setItem('choose1', 'layout6');
    }
  }

  _saveLayoutWithStorageB2() async {
    if (isLayout1 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout1";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");

      await storage.setItem('choose2', 'layout1');
    }
    if (isLayout2 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout2";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");

      await storage.setItem('choose2', 'layout2');
    }
    if (isLayout3 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout3";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");
      await storage.setItem('choose2', 'layout3');
    }
    if (isLayout4 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout4";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");
      await storage.setItem('choose2', 'layout4');
    }
    if (isLayout5 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout5";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");
      await storage.setItem('choose2', 'layout5');
    }
    if (isLayout6 == true) {
      // ...
      setState(() {
        choose_layoutB2 = "layout6";
      });
      print("object data layout yang dipilih b2 : $choose_layoutB2");
      await storage.setItem('choose2', 'layout6');
    }
  }

  void filterBeauty() async {
    setState(() {
      isFilterBeauty = !isFilterBeauty;
    });
  }

  Future<void> _getDataImages() async {
    list.clear();
    // print("get list : $list");
    // print("get all images layout");
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
      setState(() {});
      list.addAll(jsonDecode(response.body));
      stores = jsonDecode(response.body);
      print("response. length : ${stores.length}");
      setState(() {
        lengthDataImages = stores.length;
      });

      // Paket A
      if (title.toString().contains("Paket A") ||
          title.toString().contains("Collage A")) {
        // ...
        for (var i = 0; i < 6; i++) {
          print("object get data images layout page tipe a $i ${list[i]}");
          listA.add(list[i]);
        }
        print("object list a : $listA");
      }

      // Paket B
      if (title.toString().contains("Paket B") ||
          title.toString().contains("Collage B")) {
        // ...
        for (var i = 0; i < 8; i++) {
          print("object get data images layout page tipe a $i ${list[i]}");
          listB.add(list[i]);
        }
        print("object list b : $listB");
      }

      // Paket C
      if (title.toString().contains("Paket C")) {
        // ...
        for (var i = 0; i < 12; i++) {
          print("object get data images layout page tipe C $i ${list[i]}");
          listC.add(list[i]);
        }
        print("object list c : $listC");
      }

      // Paket D
      if (title.toString().contains("Paket D")) {
        // ...
        for (var i = 0; i < 15; i++) {
          print("object get data images layout page tipe D $i ${list[i]}");
          listD.add(list[i]);
        }
        print("object list d : $listD");
      }

      // Paket E
      if (title.toString().contains("Paket E")) {
        // ...
        for (var i = 0; i < 15; i++) {
          print("object get data images layout page tipe E $i ${list[i]}");
          listE.add(list[i]);
        }
        print("object list d : $listB");
      }

      // Paket F
      if (title.toString().contains("Paket F")) {
        // ...
        for (var i = 0; i < 15; i++) {
          print("object get data images layout page tipe F $i ${list[i]}");
          listF.add(list[i]);
        }
        print("object list d : $listB");
      }

      if (title.toString().contains("Paket G") ||
          title.toString().contains("Paket H")) {
        // ...
        for (var i = 0; i < 1; i++) {
          print("object get data images layout page tipe a $i ${list[i]}");
          listG.add(list[i]);
          listH.add(list[i]);
        }
        print("object list G / H : $listH");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void saveEditImage() async {
    String path =
        "C:/Users/rama/Documents/git/fs/fs-server/public/storage/uploads/images/$nama-${DateTime.now().day}-${DateTime.now().hour}/$image_name";

    print("path : $path");

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/upload-image-edit'));
    request.fields.addAll({
      'nama': "$nama-${DateTime.now().day}-${DateTime.now().hour}",
      'nama_image': "$image_name",
      'rotate_value': "${_currentSliderValuePutarGambar.round() * -1}",
      'resize_value1': "${(_currentSliderValueSkalaGambar * 252)}",
      'resize_value2': "${(_currentSliderValueSkalaGambar * 275)}"
    });
    request.files.add(await http.MultipartFile.fromPath('image', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        // ...
        foto_details = "";
        _currentSliderValuePutarGambar = 0;
        _currentSliderValueSkalaGambar = 1;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void getStorage() async {
    var ready = await storage.ready;

    print("status ready storage : $ready");
    if (ready == true) {
      setState(() {});

      bgImg = await storage.getItem('background_images');

      print("background_storage : $bgImg");
    }
  }

  // ... order settings functions
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

  screenCaptureImages(i, j) async {
    final directory =
        (await getApplicationDocumentsDirectory()); //from path_provide package

    if ((i == 0 && j == 0)) {
      // ...
      screenshotController1
          .captureAndSave(
        '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
        fileName: "${"\\${DateTime.now().day}-1"}.png",
      )
          .then((capturedImage) async {
        print("object : $capturedImage");
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error 01 : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
      });
    }

    if ((i == 1 && j == 2)) {
      print("capture 12");
      // ...
      screenshotController7
          .captureAndSave(
        '${directory.path}/${Variables.folder_img_path}/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
        fileName: "${"\\${DateTime.now().day}-7"}.png",
      )
          .then((capturedImage) async {
        print("object : $capturedImage");
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
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
        setState(() {
          foto_details = "";
        });
      }).catchError((onError) {
        print("on error : $onError");
      });
    }
  }

  void onController(PhotoViewControllerValue value) {
    setState(() {
      calls += 1;
    });
  }

  void onScaleState(PhotoViewScaleState scaleState) {
    print(scaleState);
  }

  @override
  void dispose() {
    controller?.dispose();
    scaleStateController?.dispose();
    super.dispose();
  }

  // clear storage ...
  _clearStorage() async {
    await storage.clear();
    print("object clear storage");
  }

  @override
  // ignore: override_on_non_overriding_member
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        // decoration: backgrounds != null
        //     ? BoxDecoration(
        //         image: DecorationImage(
        //           image: NetworkImage(
        //               "${Variables.ipv4_local}/storage/order/background-image/$backgrounds"),
        //           fit: BoxFit.cover,
        //         ),
        //       )
        //     : BoxDecoration(),
        child: Stack(
          children: [
            // main view body
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ----------------
                // Header Page View
                // ----------------
                Container(
                  height: height * 0.12,
                  width: width * 1,
                  child: Column(
                    children: [
                      Container(
                        height: width * 0.015,
                        width: width * 1,
                        color: warna1 != ""
                            ? HexColor(warna1)
                            : Colors.transparent,
                      ),
                      Container(
                        height: width * 0.035,
                        width: width * 1,
                        color: warna1 != ""
                            ? HexColor(warna1)
                            : Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: width * 0.022,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
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
                              "Background",
                              style: TextStyle(
                                fontSize: width * 0.022,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
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
                              "Sticker",
                              style: TextStyle(
                                fontSize: width * 0.022,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
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
                              warna1 != ""
                                  ? HexColor(warna1)
                                  : Colors.transparent,
                              warna2 != ""
                                  ? HexColor(warna1)
                                  : Colors.transparent
                            ],
                            durations: _durations,
                            heightPercentages: _heightPercentages,
                          ),
                          backgroundColor: warna1 != ""
                              ? HexColor(warna1)
                              : Colors.transparent,
                          size: Size(double.infinity, double.infinity),
                          waveAmplitude: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                // ---------------------
                // End Header Page View
                // ---------------------

                // --------------------------
                // Body Page View Filter Page
                // --------------------------
                Container(
                  width: width * 1,
                  height: height * 0.88,
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.25,
                        color: bg_warna_main != ""
                            ? HexColor(bg_warna_main)
                            : Colors.transparent,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: width * 0.025,
                                bottom: width * 0.0,
                              ),
                              child: Text(
                                "Pilih Foto",
                                style: TextStyle(
                                  fontSize: width * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // =====================================================
                            // =====================================================
                            // Start - Menu Pilih Foto / Draggable Card Image / Foto
                            // =====================================================
                            // =====================================================
                            Padding(
                              padding: EdgeInsets.all(
                                width * 0.015,
                              ),
                              child: Container(
                                height: height * 0.55,
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(scrollbars: false),
                                    child: SingleChildScrollView(
                                      // ...
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.2,
                                            height: height * 0.6,
                                            child: ListView.builder(
                                              itemCount: 2,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, int i) {
                                                // ...
                                                return list.isNotEmpty
                                                    ? Container(
                                                        width: width * 0.1,
                                                        height: height * 0.4,
                                                        child: Center(
                                                          child:
                                                              ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: true,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            itemCount: title
                                                                        .toString()
                                                                        .contains(
                                                                            "Paket A") ||
                                                                    title
                                                                        .toString()
                                                                        .contains(
                                                                            "Collage A")
                                                                ? 3
                                                                : title.toString().contains(
                                                                            "Paket B") ||
                                                                        title
                                                                            .toString()
                                                                            .contains(
                                                                                "Collage B")
                                                                    ? 4
                                                                    : title.toString().contains("Paket C") ||
                                                                            title.toString().contains(
                                                                                "Collage C")
                                                                        ? 6
                                                                        : title.toString().contains("Paket D") ||
                                                                                title.toString().contains("Collage D")
                                                                            ? 8
                                                                            : title.toString().contains("Paket E") || title.toString().contains("Collage E")
                                                                                ? 10
                                                                                : title.toString().contains("Paket F") || title.toString().contains("Collage F")
                                                                                    ? 10
                                                                                    : title.toString().contains("Paket G") || title.toString().contains("Paket H")
                                                                                        ? 1
                                                                                        : 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int j) {
                                                              // item builder ...
                                                              return Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:

                                                                      // ====================
                                                                      // Draggable Contains A
                                                                      // ====================
                                                                      title.toString().contains(" A") ||
                                                                              title.toString().contains("Collage A") ||
                                                                              title.toString().contains("Paket A")
                                                                          ? Draggable<String>(
                                                                              data: "$i$j",

                                                                              // onDragComplete untuk disappear / etc item ketika complete
                                                                              onDragCompleted: () async {
                                                                                // code...
                                                                                dragItem.add(
                                                                                  "$i$j",
                                                                                );

                                                                                if (i == 0) {
                                                                                  setState(() {
                                                                                    image_name = listA[j].replaceAll('uploads/images/$nama-${DateTime.now().day}-${DateTime.now().hour}/', '');
                                                                                  });

                                                                                  print("image name : ${listA[j]}");
                                                                                } else {
                                                                                  setState(() {
                                                                                    image_name = listA[j + 3].replaceAll('uploads/images/$nama-${DateTime.now().day}-${DateTime.now().hour}/', '');
                                                                                  });

                                                                                  print("image name : ${listA[j + 3]}");
                                                                                }

                                                                                setState(() {
                                                                                  foto_details_oncomplete = "$i$j";
                                                                                  jumlah_drag_complete = jumlah_drag_complete + 1;
                                                                                });

                                                                                print("foto_details_oncomplete : $foto_details_oncomplete");

                                                                                final directory = (await getApplicationDocumentsDirectory()); //from path_provide package

                                                                                setState(() {});
                                                                                // ...
                                                                                screenshotController
                                                                                    .captureAndSave(
                                                                                  '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', // set path where screenshot will be saved
                                                                                  fileName: foto_details_oncomplete == "00"
                                                                                      ? "${"\\${DateTime.now().day}-1"}.png"
                                                                                      : foto_details_oncomplete == "01"
                                                                                          ? "${"\\${DateTime.now().day}-2"}.png"
                                                                                          : foto_details_oncomplete == "02"
                                                                                              ? "${"\\${DateTime.now().day}-3"}.png"
                                                                                              : foto_details_oncomplete == "10"
                                                                                                  ? "${"\\${DateTime.now().day}-4"}.png"
                                                                                                  : foto_details_oncomplete == "11"
                                                                                                      ? "${"\\${DateTime.now().day}-5"}.png"
                                                                                                      : foto_details_oncomplete == "12"
                                                                                                          ? "${"\\${DateTime.now().day}-6"}.png"
                                                                                                          : null,
                                                                                )
                                                                                    .then((capturedImage) async {
                                                                                  print("object : $capturedImage");
                                                                                  setState(() {
                                                                                    foto_details_oncomplete = "";
                                                                                  });
                                                                                }).catchError((onError) {
                                                                                  print("on error 01 : $onError");
                                                                                });

                                                                                if (jumlah_drag_complete == 6) {
                                                                                  // ...
                                                                                  if (!dragItem.contains("00")) {
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-1"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 00 : $onError");
                                                                                    });
                                                                                  }
                                                                                  if (!dragItem.contains("01")) {
                                                                                    // ...
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-2"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 01 : $onError");
                                                                                    });
                                                                                  }
                                                                                  if (!dragItem.contains("02")) {
                                                                                    // ...
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-3"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 02 : $onError");
                                                                                    });
                                                                                  }
                                                                                  if (!dragItem.contains("10")) {
                                                                                    // ...
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-4"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 03 : $onError");
                                                                                    });
                                                                                  }
                                                                                  if (!dragItem.contains("11")) {
                                                                                    // ...
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-5"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 10 : $onError");
                                                                                    });
                                                                                  }
                                                                                  if (!dragItem.contains("12")) {
                                                                                    // ...
                                                                                    // ...
                                                                                    screenshotController
                                                                                        .captureAndSave(
                                                                                      '${directory.path}/${Variables.folder_img_path}/edit/$nama-${DateTime.now().day}-${DateTime.now().hour}/', //set path where screenshot will be saved
                                                                                      fileName: "${"\\${DateTime.now().day}-6"}.png",
                                                                                    )
                                                                                        .then((capturedImage) async {
                                                                                      print("object : $capturedImage");
                                                                                      setState(() {
                                                                                        foto_details_oncomplete = "";
                                                                                      });
                                                                                    }).catchError((onError) {
                                                                                      print("on error 11 : $onError");
                                                                                    });
                                                                                  }
                                                                                }

                                                                                print("dragItem onComplete $dragItem");
                                                                              },

                                                                              onDragStarted: () {
                                                                                // ...

                                                                                setState(() {
                                                                                  foto_details = "$i$j";
                                                                                });

                                                                                print(
                                                                                  "drag foto_details $foto_details",
                                                                                );

                                                                                if (i == 0) {
                                                                                  print("image name : ${listA[j]}");

                                                                                  setState(() {
                                                                                    image_name = listA[j];
                                                                                  });
                                                                                } else {
                                                                                  print("image name : ${listA[j + 3]}");

                                                                                  setState(() {
                                                                                    image_name = listA[j + 3];
                                                                                  });
                                                                                }
                                                                              },

                                                                              childWhenDragging: Container(
                                                                                width: width * 0.08,
                                                                                height: width * 0.09,
                                                                              ),

                                                                              feedback: (i == 0 && j == 0 && dragItem.isNotEmpty && dragItem.contains("00"))
                                                                                  ? Container(
                                                                                      width: width * 0.08,
                                                                                      height: width * 0.09,
                                                                                    )
                                                                                  :

                                                                                  // card 2
                                                                                  (i == 0 && j == 1 && dragItem.isNotEmpty && dragItem.contains("01"))
                                                                                      ? Container(
                                                                                          width: width * 0.08,
                                                                                          height: width * 0.09,
                                                                                        )
                                                                                      :

                                                                                      // card 3
                                                                                      (i == 0 && j == 2 && dragItem.isNotEmpty && dragItem.contains("02"))
                                                                                          ? Container(
                                                                                              width: width * 0.08,
                                                                                              height: width * 0.09,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            )
                                                                                          :

                                                                                          // card 6
                                                                                          (i == 1 && j == 0 && dragItem.isNotEmpty && dragItem.contains("10"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 7
                                                                                              (i == 1 && j == 1 && dragItem.isNotEmpty && dragItem.contains("11"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 8
                                                                                                  (i == 1 && j == 2 && dragItem.isNotEmpty && dragItem.contains("12"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      : Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.all(width * 0.0),
                                                                                                            child: Container(
                                                                                                              width: width * 0.12,
                                                                                                              height: height * 0.3,
                                                                                                              child: FadeInImage(
                                                                                                                width: width * 0.085,
                                                                                                                height: height * 0.18,
                                                                                                                image: NetworkImage(
                                                                                                                  i == 0
                                                                                                                      ? "${Variables.ipv4_local}/storage/${listA[j].toString()}"
                                                                                                                      : i == 1
                                                                                                                          ? "${Variables.ipv4_local}/storage/${listA[j + 3].toString()}"
                                                                                                                          : "${Variables.ipv4_local}/storage/${listA[j].toString()}",
                                                                                                                  scale: 1,
                                                                                                                ),
                                                                                                                placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                  return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.cover);
                                                                                                                },
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),

                                                                              child: // card 1
                                                                                  (i == 0 && j == 0 && dragItem.isNotEmpty && dragItem.contains("00"))
                                                                                      ? Container(
                                                                                          width: width * 0.08,
                                                                                          height: width * 0.09,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                        )
                                                                                      :

                                                                                      // card 2
                                                                                      (i == 0 && j == 1 && dragItem.isNotEmpty && dragItem.contains("01"))
                                                                                          ? Container(
                                                                                              width: width * 0.08,
                                                                                              height: width * 0.09,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            )
                                                                                          :

                                                                                          // card 3
                                                                                          (i == 0 && j == 2 && dragItem.isNotEmpty && dragItem.contains("02"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 6
                                                                                              (i == 1 && j == 0 && dragItem.isNotEmpty && dragItem.contains("10"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 7
                                                                                                  (i == 1 && j == 1 && dragItem.isNotEmpty && dragItem.contains("11"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 8
                                                                                                      (i == 1 && j == 2 && dragItem.isNotEmpty && dragItem.contains("12"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          : Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              child: Padding(
                                                                                                                padding: EdgeInsets.all(width * 0.0),
                                                                                                                child: ColorFiltered(
                                                                                                                  colorFilter: nama_filter == 'greyscale'
                                                                                                                      ? ColorFilter.mode(
                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                          BlendMode.saturation,
                                                                                                                        )
                                                                                                                      : nama_filter == 'classic negative'
                                                                                                                          ? ColorFilter.mode(
                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                              BlendMode.saturation,
                                                                                                                            )
                                                                                                                          : nama_filter == 'black white blur'
                                                                                                                              ? ColorFilter.mode(
                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                  BlendMode.saturation,
                                                                                                                                )
                                                                                                                              : nama_filter == 'mute'
                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                      BlendMode.saturation,
                                                                                                                                    )
                                                                                                                                  : nama_filter == 'webcore'
                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                          BlendMode.saturation,
                                                                                                                                        )
                                                                                                                                      : ColorFilter.mode(
                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                          BlendMode.saturation,
                                                                                                                                        ),
                                                                                                                  child: Screenshot(
                                                                                                                    controller: (i == 0 && j == 0)
                                                                                                                        ? screenshotController1
                                                                                                                        : (i == 0 && j == 1)
                                                                                                                            ? screenshotController2
                                                                                                                            : (i == 0 && j == 2)
                                                                                                                                ? screenshotController3
                                                                                                                                : (i == 1 && j == 0)
                                                                                                                                    ? screenshotController4
                                                                                                                                    : (i == 1 && j == 1)
                                                                                                                                        ? screenshotController5
                                                                                                                                        : screenshotController6,
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.12,
                                                                                                                      height: height * 0.3,
                                                                                                                      // color:  (i==0 && j ==0) ? Colors.grey : Colors.yellow,
                                                                                                                      child: FadeInImage(
                                                                                                                        width: width * 0.085,
                                                                                                                        height: height * 0.18,
                                                                                                                        image: NetworkImage(
                                                                                                                          i == 0 ? "${Variables.ipv4_local}/storage/${listA[j].toString()}" : "${Variables.ipv4_local}/storage/${listA[j + 3].toString()}",
                                                                                                                          scale: 1,
                                                                                                                        ),
                                                                                                                        placeholder: AssetImage("assets/props/shapes/16_shapes_v1.png"),
                                                                                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                                                                                          return Image.asset('assets/props/shapes/16_shapes_v1.png', fit: BoxFit.cover);
                                                                                                                        },
                                                                                                                        fit: BoxFit.cover,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                            )
                                                                          :

                                                                          // ====================
                                                                          // Draggable Contains B
                                                                          // ====================
                                                                          title.toString().contains("Paket B")
                                                                              ? Draggable<String>(
                                                                                  data: "$i$j",

                                                                                  // onDragComplete untuk disappear/etc item ketika complete
                                                                                  onDragCompleted: () async {
                                                                                    // code...

                                                                                    // get image name start

                                                                                    // get image name end

                                                                                    setState(() {
                                                                                      foto_details_oncomplete = "$i$j";
                                                                                      jumlah_drag_complete = jumlah_drag_complete + 1;
                                                                                    });

                                                                                    dragItemB.add(
                                                                                      "$i$j",
                                                                                    );

                                                                                    // screen capture functions ===

                                                                                    setState(() {});

                                                                                    // end statenment screen capture functions ===

                                                                                    print(
                                                                                      "dragItemB onComplete $dragItemB",
                                                                                    );
                                                                                  },

                                                                                  onDragStarted: () {
                                                                                    // ...
                                                                                    print(
                                                                                      "drag start $i $j",
                                                                                    );

                                                                                    setState(() {
                                                                                      foto_details = "$i$j";
                                                                                    });

                                                                                    print(
                                                                                      "drag foto_details $foto_details",
                                                                                    );
                                                                                  },

                                                                                  childWhenDragging: Container(
                                                                                    width: width * 0.08,
                                                                                    height: width * 0.09,
                                                                                  ),

                                                                                  feedback: (i == 0 && j == 0 && dragItemB.isNotEmpty && dragItemB.contains("00"))
                                                                                      ? Container(
                                                                                          width: width * 0.08,
                                                                                          height: width * 0.09,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                        )
                                                                                      :

                                                                                      // card 2
                                                                                      (i == 0 && j == 1 && dragItemB.isNotEmpty && dragItemB.contains("01"))
                                                                                          ? Container(
                                                                                              width: width * 0.08,
                                                                                              height: width * 0.09,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            )
                                                                                          :

                                                                                          // card 3
                                                                                          (i == 0 && j == 2 && dragItemB.isNotEmpty && dragItemB.contains("02"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 4
                                                                                              (i == 0 && j == 3 && dragItemB.isNotEmpty && dragItemB.contains("03"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  : (i == 1 && j == 0 && dragItemB.isNotEmpty && dragItemB.contains("10"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      : (i == 1 && j == 1 && dragItemB.isNotEmpty && dragItemB.contains("11"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          : (i == 1 && j == 2 && dragItemB.isNotEmpty && dragItemB.contains("12"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              : (i == 1 && j == 3 && dragItemB.isNotEmpty && dragItemB.contains("13"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  : Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                        color: Colors.white,
                                                                                                                        boxShadow: [],
                                                                                                                      ),
                                                                                                                      child: Padding(
                                                                                                                        padding: EdgeInsets.all(width * 0.0),
                                                                                                                        child: ColorFiltered(
                                                                                                                          colorFilter: nama_filter == 'greyscale'
                                                                                                                              ? ColorFilter.mode(
                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                  BlendMode.saturation,
                                                                                                                                )
                                                                                                                              : nama_filter == 'classic negative'
                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                      BlendMode.saturation,
                                                                                                                                    )
                                                                                                                                  : nama_filter == 'black white blur'
                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                          BlendMode.saturation,
                                                                                                                                        )
                                                                                                                                      : nama_filter == 'mute'
                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                              BlendMode.saturation,
                                                                                                                                            )
                                                                                                                                          : nama_filter == 'webcore'
                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                )
                                                                                                                                              : ColorFilter.mode(
                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                ),
                                                                                                                          child: Container(
                                                                                                                            width: width * 0.12,
                                                                                                                            height: height * 0.3,
                                                                                                                            decoration: BoxDecoration(
                                                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                                                              image: DecorationImage(
                                                                                                                                image: NetworkImage(
                                                                                                                                  i == 0 ? "${Variables.ipv4_local}/storage/${listB[j].toString()}" : "${Variables.ipv4_local}/storage/${listB[j + 4].toString()}",
                                                                                                                                  scale: 1,
                                                                                                                                ),
                                                                                                                                fit: BoxFit.cover,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        // ),
                                                                                                                      ),
                                                                                                                    ),

                                                                                  child: // card 1
                                                                                      (i == 0 && j == 0 && dragItemB.isNotEmpty && dragItemB.contains("00"))
                                                                                          ? Container(
                                                                                              width: width * 0.08,
                                                                                              height: width * 0.09,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            )
                                                                                          :

                                                                                          // card 2
                                                                                          (i == 0 && j == 1 && dragItemB.isNotEmpty && dragItemB.contains("01"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 3
                                                                                              (i == 0 && j == 2 && dragItemB.isNotEmpty && dragItemB.contains("02"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 4
                                                                                                  (i == 0 && j == 3 && dragItemB.isNotEmpty && dragItemB.contains("03"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 6
                                                                                                      (i == 1 && j == 0 && dragItemB.isNotEmpty && dragItemB.contains("10"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          :

                                                                                                          // card 7
                                                                                                          (i == 1 && j == 1 && dragItemB.isNotEmpty && dragItemB.contains("11"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              :

                                                                                                              // card 8
                                                                                                              (i == 1 && j == 2 && dragItemB.isNotEmpty && dragItemB.contains("12"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  :

                                                                                                                  // card 8
                                                                                                                  (i == 1 && j == 3 && dragItemB.isNotEmpty && dragItemB.contains("13"))
                                                                                                                      ? Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      : Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                            color: Colors.white,
                                                                                                                            boxShadow: [],
                                                                                                                          ),
                                                                                                                          child: Padding(
                                                                                                                            padding: EdgeInsets.all(width * 0.0),
                                                                                                                            child: ColorFiltered(
                                                                                                                              colorFilter: nama_filter == 'greyscale'
                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                      BlendMode.saturation,
                                                                                                                                    )
                                                                                                                                  : nama_filter == 'classic negative'
                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                          BlendMode.saturation,
                                                                                                                                        )
                                                                                                                                      : nama_filter == 'black white blur'
                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                              BlendMode.saturation,
                                                                                                                                            )
                                                                                                                                          : nama_filter == 'mute'
                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                )
                                                                                                                                              : nama_filter == 'webcore'
                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                    )
                                                                                                                                                  : ColorFilter.mode(
                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                    ),
                                                                                                                              child: Container(
                                                                                                                                width: width * 0.12,
                                                                                                                                height: height * 0.3,
                                                                                                                                decoration: BoxDecoration(
                                                                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                                                                  image: DecorationImage(
                                                                                                                                    image: NetworkImage(
                                                                                                                                      i == 0 ? "${Variables.ipv4_local}/storage/${listB[j].toString()}" : "${Variables.ipv4_local}/storage/${listB[j + 4].toString()}",
                                                                                                                                      scale: 1,
                                                                                                                                    ),
                                                                                                                                    fit: BoxFit.cover,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                )
                                                                              :

                                                                              // ====================
                                                                              // Draggable Contains C
                                                                              // ====================
                                                                              title.toString().contains("Paket C")
                                                                                  ? Draggable<String>(
                                                                                      data: "$i$j",
                                                                                      onDragCompleted: () async {
                                                                                        // code...

                                                                                        setState(() {
                                                                                          foto_details_oncomplete = "$i$j";
                                                                                          jumlah_drag_complete = jumlah_drag_complete + 1;
                                                                                        });

                                                                                        dragItemC.add(
                                                                                          "$i$j",
                                                                                        );

                                                                                        setState(() {});

                                                                                        print(
                                                                                          "dragItemC onComplete $dragItemC",
                                                                                        );
                                                                                      },
                                                                                      onDragStarted: () {
                                                                                        // ...
                                                                                        print(
                                                                                          "drag start $i $j",
                                                                                        );

                                                                                        setState(() {
                                                                                          foto_details = "$i$j";
                                                                                        });

                                                                                        print(
                                                                                          "drag foto_details $foto_details",
                                                                                        );
                                                                                      },
                                                                                      childWhenDragging: Container(
                                                                                        width: width * 0.08,
                                                                                        height: width * 0.09,
                                                                                      ),
                                                                                      feedback: (i == 0 && j == 0 && dragItemC.isNotEmpty && dragItemC.contains("00"))
                                                                                          ? Container(
                                                                                              width: width * 0.08,
                                                                                              height: width * 0.09,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            )
                                                                                          :

                                                                                          // card 2
                                                                                          (i == 0 && j == 1 && dragItemC.isNotEmpty && dragItemC.contains("01"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 3
                                                                                              (i == 0 && j == 2 && dragItemC.isNotEmpty && dragItemC.contains("02"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 4
                                                                                                  (i == 0 && j == 3 && dragItemC.isNotEmpty && dragItemC.contains("03"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 5
                                                                                                      (i == 0 && j == 4 && dragItemC.isNotEmpty && dragItemC.contains("04"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          :

                                                                                                          // card 6
                                                                                                          (i == 0 && j == 5 && dragItemC.isNotEmpty && dragItemC.contains("05"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              :

                                                                                                              // card 7
                                                                                                              (i == 1 && j == 0 && dragItemC.isNotEmpty && dragItemC.contains("10"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  :

                                                                                                                  // card 8
                                                                                                                  (i == 1 && j == 1 && dragItemC.isNotEmpty && dragItemC.contains("11"))
                                                                                                                      ? Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      :

                                                                                                                      // card 9
                                                                                                                      (i == 1 && j == 2 && dragItemC.isNotEmpty && dragItemC.contains("12"))
                                                                                                                          ? Container(
                                                                                                                              width: width * 0.08,
                                                                                                                              height: width * 0.09,
                                                                                                                              decoration: BoxDecoration(
                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          :

                                                                                                                          // card 10
                                                                                                                          (i == 1 && j == 3 && dragItemC.isNotEmpty && dragItemC.contains("13"))
                                                                                                                              ? Container(
                                                                                                                                  width: width * 0.08,
                                                                                                                                  height: width * 0.09,
                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              :

                                                                                                                              // card 11
                                                                                                                              (i == 1 && j == 4 && dragItemC.isNotEmpty && dragItemC.contains("14"))
                                                                                                                                  ? Container(
                                                                                                                                      width: width * 0.08,
                                                                                                                                      height: width * 0.09,
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                      ),
                                                                                                                                    )
                                                                                                                                  :

                                                                                                                                  // card 12
                                                                                                                                  (i == 1 && j == 5 && dragItemC.isNotEmpty && dragItemC.contains("15"))
                                                                                                                                      ? Container(
                                                                                                                                          width: width * 0.08,
                                                                                                                                          height: width * 0.09,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      : Container(
                                                                                                                                          width: width * 0.08,
                                                                                                                                          height: width * 0.09,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                            color: Colors.white,
                                                                                                                                            boxShadow: [],
                                                                                                                                          ),
                                                                                                                                          child: Padding(
                                                                                                                                            padding: EdgeInsets.all(width * 0.0),
                                                                                                                                            child: ColorFiltered(
                                                                                                                                              colorFilter: nama_filter == 'greyscale'
                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                    )
                                                                                                                                                  : nama_filter == 'classic negative'
                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                        )
                                                                                                                                                      : nama_filter == 'black white blur'
                                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                              BlendMode.saturation,
                                                                                                                                                            )
                                                                                                                                                          : nama_filter == 'mute'
                                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                                )
                                                                                                                                                              : nama_filter == 'webcore'
                                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                    )
                                                                                                                                                                  : ColorFilter.mode(
                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                    ),
                                                                                                                                              child: Container(
                                                                                                                                                width: width * 0.12,
                                                                                                                                                height: height * 0.3,
                                                                                                                                                decoration: BoxDecoration(
                                                                                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                                                                                  image: DecorationImage(
                                                                                                                                                    image: NetworkImage(
                                                                                                                                                      i == 0 ? "${Variables.ipv4_local}/storage/${listC[j].toString()}" : "${Variables.ipv4_local}/storage/${listC[j + 6].toString()}",
                                                                                                                                                      scale: 1,
                                                                                                                                                    ),
                                                                                                                                                    fit: BoxFit.cover,
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                      child: // card 1
                                                                                          (i == 0 && j == 0 && dragItemC.isNotEmpty && dragItemC.contains("00"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 2
                                                                                              (i == 0 && j == 1 && dragItemC.isNotEmpty && dragItemC.contains("01"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 3
                                                                                                  (i == 0 && j == 2 && dragItemC.isNotEmpty && dragItemC.contains("02"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 4
                                                                                                      (i == 0 && j == 3 && dragItemC.isNotEmpty && dragItemC.contains("03"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          :

                                                                                                          // card 6
                                                                                                          (i == 0 && j == 4 && dragItemC.isNotEmpty && dragItemC.contains("04"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              :

                                                                                                              // card 7
                                                                                                              (i == 0 && j == 5 && dragItemC.isNotEmpty && dragItemC.contains("05"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  :

                                                                                                                  // card 8
                                                                                                                  (i == 1 && j == 0 && dragItemC.isNotEmpty && dragItemC.contains("10"))
                                                                                                                      ? Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      :

                                                                                                                      // card 8
                                                                                                                      (i == 1 && j == 1 && dragItemC.isNotEmpty && dragItemC.contains("11"))
                                                                                                                          ? Container(
                                                                                                                              width: width * 0.08,
                                                                                                                              height: width * 0.09,
                                                                                                                              decoration: BoxDecoration(
                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          :

                                                                                                                          // card 8
                                                                                                                          (i == 1 && j == 2 && dragItemC.isNotEmpty && dragItemC.contains("12"))
                                                                                                                              ? Container(
                                                                                                                                  width: width * 0.08,
                                                                                                                                  height: width * 0.09,
                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              :

                                                                                                                              // card 8
                                                                                                                              (i == 1 && j == 3 && dragItemC.isNotEmpty && dragItemC.contains("13"))
                                                                                                                                  ? Container(
                                                                                                                                      width: width * 0.08,
                                                                                                                                      height: width * 0.09,
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                      ),
                                                                                                                                    )
                                                                                                                                  :

                                                                                                                                  // card 8
                                                                                                                                  (i == 1 && j == 4 && dragItemC.isNotEmpty && dragItemC.contains("14"))
                                                                                                                                      ? Container(
                                                                                                                                          width: width * 0.08,
                                                                                                                                          height: width * 0.09,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      :

                                                                                                                                      // card 8
                                                                                                                                      (i == 1 && j == 5 && dragItemC.isNotEmpty && dragItemC.contains("15"))
                                                                                                                                          ? Container(
                                                                                                                                              width: width * 0.08,
                                                                                                                                              height: width * 0.09,
                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                              ),
                                                                                                                                            )
                                                                                                                                          : Container(
                                                                                                                                              width: width * 0.08,
                                                                                                                                              height: width * 0.09,
                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                                color: Colors.white,
                                                                                                                                                boxShadow: [],
                                                                                                                                              ),
                                                                                                                                              child: Padding(
                                                                                                                                                padding: EdgeInsets.all(width * 0.0),
                                                                                                                                                child: ColorFiltered(
                                                                                                                                                  colorFilter: nama_filter == 'greyscale'
                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                        )
                                                                                                                                                      : nama_filter == 'classic negative'
                                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                              BlendMode.saturation,
                                                                                                                                                            )
                                                                                                                                                          : nama_filter == 'black white blur'
                                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                                )
                                                                                                                                                              : nama_filter == 'mute'
                                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                    )
                                                                                                                                                                  : nama_filter == 'webcore'
                                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                        )
                                                                                                                                                                      : ColorFilter.mode(
                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                        ),
                                                                                                                                                  child: Container(
                                                                                                                                                    width: width * 0.12,
                                                                                                                                                    height: height * 0.3,
                                                                                                                                                    decoration: BoxDecoration(
                                                                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                                                                      image: DecorationImage(
                                                                                                                                                        image: NetworkImage(
                                                                                                                                                          i == 0 ? "${Variables.ipv4_local}/storage/${listC[j].toString()}" : "${Variables.ipv4_local}/storage/${listC[j + 6].toString()}",
                                                                                                                                                          scale: 1,
                                                                                                                                                        ),
                                                                                                                                                        fit: BoxFit.cover,
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                    )
                                                                                  :

                                                                                  // ====================
                                                                                  // Draggable Contains D
                                                                                  // ====================
                                                                                  title.toString().contains("Paket D")
                                                                                      ? Draggable<String>(
                                                                                          data: "$i$j",
                                                                                          onDragCompleted: () async {
                                                                                            // code...

                                                                                            setState(() {
                                                                                              foto_details_oncomplete = "$i$j";
                                                                                              jumlah_drag_complete = jumlah_drag_complete + 1;
                                                                                            });

                                                                                            dragItemD.add(
                                                                                              "$i$j",
                                                                                            );

                                                                                            setState(() {});

                                                                                            print(
                                                                                              "dragItemC onComplete $dragItemD",
                                                                                            );
                                                                                          },
                                                                                          onDragStarted: () {
                                                                                            // ...
                                                                                            print(
                                                                                              "drag start $i $j",
                                                                                            );

                                                                                            setState(() {
                                                                                              foto_details = "$i$j";
                                                                                            });

                                                                                            print(
                                                                                              "drag foto_details $foto_details",
                                                                                            );
                                                                                          },
                                                                                          childWhenDragging: Container(
                                                                                            width: width * 0.08,
                                                                                            height: width * 0.09,
                                                                                          ),
                                                                                          feedback: (i == 0 && j == 0 && dragItemD.isNotEmpty && dragItemD.contains("00"))
                                                                                              ? Container(
                                                                                                  width: width * 0.08,
                                                                                                  height: width * 0.09,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                )
                                                                                              :

                                                                                              // card 2
                                                                                              (i == 0 && j == 1 && dragItemD.isNotEmpty && dragItemD.contains("01"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 3
                                                                                                  (i == 0 && j == 2 && dragItemD.isNotEmpty && dragItemD.contains("02"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 4
                                                                                                      (i == 0 && j == 3 && dragItemD.isNotEmpty && dragItemD.contains("03"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          :

                                                                                                          // card 6
                                                                                                          (i == 0 && j == 4 && dragItemD.isNotEmpty && dragItemD.contains("04"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              :

                                                                                                              // card 7
                                                                                                              (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("05"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  :

                                                                                                                  // card 8
                                                                                                                  (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("06"))
                                                                                                                      ? Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      :

                                                                                                                      // card 9
                                                                                                                      (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("07"))
                                                                                                                          ? Container(
                                                                                                                              width: width * 0.08,
                                                                                                                              height: width * 0.09,
                                                                                                                              decoration: BoxDecoration(
                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          :

                                                                                                                          // card 10
                                                                                                                          (i == 1 && j == 0 && dragItemD.isNotEmpty && dragItemD.contains("10"))
                                                                                                                              ? Container(
                                                                                                                                  width: width * 0.08,
                                                                                                                                  height: width * 0.09,
                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              :

                                                                                                                              // card 11
                                                                                                                              (i == 1 && j == 1 && dragItemD.isNotEmpty && dragItemD.contains("11"))
                                                                                                                                  ? Container(
                                                                                                                                      width: width * 0.08,
                                                                                                                                      height: width * 0.09,
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                      ),
                                                                                                                                    )
                                                                                                                                  :

                                                                                                                                  // card 12
                                                                                                                                  (i == 1 && j == 2 && dragItemD.isNotEmpty && dragItemD.contains("12"))
                                                                                                                                      ? Container(
                                                                                                                                          width: width * 0.08,
                                                                                                                                          height: width * 0.09,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      :

                                                                                                                                      // card 13
                                                                                                                                      (i == 1 && j == 3 && dragItemD.isNotEmpty && dragItemD.contains("13"))
                                                                                                                                          ? Container(
                                                                                                                                              width: width * 0.08,
                                                                                                                                              height: width * 0.09,
                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                              ),
                                                                                                                                            )
                                                                                                                                          :

                                                                                                                                          // card 14
                                                                                                                                          (i == 1 && j == 4 && dragItemD.isNotEmpty && dragItemD.contains("14"))
                                                                                                                                              ? Container(
                                                                                                                                                  width: width * 0.08,
                                                                                                                                                  height: width * 0.09,
                                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                                  ),
                                                                                                                                                )
                                                                                                                                              :

                                                                                                                                              // card 15
                                                                                                                                              (i == 1 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("15"))
                                                                                                                                                  ? Container(
                                                                                                                                                      width: width * 0.08,
                                                                                                                                                      height: width * 0.09,
                                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                                      ),
                                                                                                                                                    )
                                                                                                                                                  :

                                                                                                                                                  // card 16
                                                                                                                                                  (i == 1 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("16"))
                                                                                                                                                      ? Container(
                                                                                                                                                          width: width * 0.08,
                                                                                                                                                          height: width * 0.09,
                                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                                          ),
                                                                                                                                                        )
                                                                                                                                                      :

                                                                                                                                                      // card 8
                                                                                                                                                      Container(
                                                                                                                                                          width: width * 0.08,
                                                                                                                                                          height: width * 0.09,
                                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                                            color: Colors.white,
                                                                                                                                                            boxShadow: [],
                                                                                                                                                          ),
                                                                                                                                                          child: Padding(
                                                                                                                                                            padding: EdgeInsets.all(width * 0.0),
                                                                                                                                                            child: ColorFiltered(
                                                                                                                                                              colorFilter: nama_filter == 'greyscale'
                                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                    )
                                                                                                                                                                  : nama_filter == 'classic negative'
                                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                        )
                                                                                                                                                                      : nama_filter == 'black white blur'
                                                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                              BlendMode.saturation,
                                                                                                                                                                            )
                                                                                                                                                                          : nama_filter == 'mute'
                                                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                                                )
                                                                                                                                                                              : nama_filter == 'webcore'
                                                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                                    )
                                                                                                                                                                                  : ColorFilter.mode(
                                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                                    ),
                                                                                                                                                              child: i == 1 && j == 7
                                                                                                                                                                  ? Container()
                                                                                                                                                                  : Container(
                                                                                                                                                                      width: width * 0.12,
                                                                                                                                                                      height: height * 0.3,
                                                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                                                        image: DecorationImage(
                                                                                                                                                                          image: NetworkImage(
                                                                                                                                                                            i == 0 ? "${Variables.ipv4_local}/storage/${dragItemD[j].toString()}" : "${Variables.ipv4_local}/storage/${dragItemD[j + 8].toString()}",
                                                                                                                                                                            scale: 1,
                                                                                                                                                                          ),
                                                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                                                        ),
                                                                                                                                                                      ),
                                                                                                                                                                    ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                          child: // card 1
                                                                                              (i == 0 && j == 0 && dragItemD.isNotEmpty && dragItemD.contains("00"))
                                                                                                  ? Container(
                                                                                                      width: width * 0.08,
                                                                                                      height: width * 0.09,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )
                                                                                                  :

                                                                                                  // card 2
                                                                                                  (i == 0 && j == 1 && dragItemD.isNotEmpty && dragItemD.contains("01"))
                                                                                                      ? Container(
                                                                                                          width: width * 0.08,
                                                                                                          height: width * 0.09,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                          ),
                                                                                                        )
                                                                                                      :

                                                                                                      // card 3
                                                                                                      (i == 0 && j == 2 && dragItemD.isNotEmpty && dragItemD.contains("02"))
                                                                                                          ? Container(
                                                                                                              width: width * 0.08,
                                                                                                              height: width * 0.09,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                              ),
                                                                                                            )
                                                                                                          :

                                                                                                          // card 4
                                                                                                          (i == 0 && j == 3 && dragItemD.isNotEmpty && dragItemD.contains("03"))
                                                                                                              ? Container(
                                                                                                                  width: width * 0.08,
                                                                                                                  height: width * 0.09,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                  ),
                                                                                                                )
                                                                                                              :

                                                                                                              // card 6
                                                                                                              (i == 0 && j == 4 && dragItemD.isNotEmpty && dragItemD.contains("04"))
                                                                                                                  ? Container(
                                                                                                                      width: width * 0.08,
                                                                                                                      height: width * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  :

                                                                                                                  // card 7
                                                                                                                  (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("05"))
                                                                                                                      ? Container(
                                                                                                                          width: width * 0.08,
                                                                                                                          height: width * 0.09,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      :

                                                                                                                      // card 7
                                                                                                                      (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("06"))
                                                                                                                          ? Container(
                                                                                                                              width: width * 0.08,
                                                                                                                              height: width * 0.09,
                                                                                                                              decoration: BoxDecoration(
                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          :

                                                                                                                          // card 7
                                                                                                                          (i == 0 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("07"))
                                                                                                                              ? Container(
                                                                                                                                  width: width * 0.08,
                                                                                                                                  height: width * 0.09,
                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              :

                                                                                                                              // card 8
                                                                                                                              (i == 1 && j == 0 && dragItemD.isNotEmpty && dragItemD.contains("10"))
                                                                                                                                  ? Container(
                                                                                                                                      width: width * 0.08,
                                                                                                                                      height: width * 0.09,
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                      ),
                                                                                                                                    )
                                                                                                                                  :

                                                                                                                                  // card 8
                                                                                                                                  (i == 1 && j == 1 && dragItemD.isNotEmpty && dragItemD.contains("11"))
                                                                                                                                      ? Container(
                                                                                                                                          width: width * 0.08,
                                                                                                                                          height: width * 0.09,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      :

                                                                                                                                      // card 8
                                                                                                                                      (i == 1 && j == 2 && dragItemD.isNotEmpty && dragItemD.contains("12"))
                                                                                                                                          ? Container(
                                                                                                                                              width: width * 0.08,
                                                                                                                                              height: width * 0.09,
                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                              ),
                                                                                                                                            )
                                                                                                                                          :

                                                                                                                                          // card 8
                                                                                                                                          (i == 1 && j == 3 && dragItemD.isNotEmpty && dragItemD.contains("13"))
                                                                                                                                              ? Container(
                                                                                                                                                  width: width * 0.08,
                                                                                                                                                  height: width * 0.09,
                                                                                                                                                  decoration: BoxDecoration(
                                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                                  ),
                                                                                                                                                )
                                                                                                                                              :

                                                                                                                                              // card 8
                                                                                                                                              (i == 1 && j == 4 && dragItemD.isNotEmpty && dragItemD.contains("14"))
                                                                                                                                                  ? Container(
                                                                                                                                                      width: width * 0.08,
                                                                                                                                                      height: width * 0.09,
                                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                                      ),
                                                                                                                                                    )
                                                                                                                                                  :

                                                                                                                                                  // card 8
                                                                                                                                                  (i == 1 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("15"))
                                                                                                                                                      ? Container(
                                                                                                                                                          width: width * 0.08,
                                                                                                                                                          height: width * 0.09,
                                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                                          ),
                                                                                                                                                        )
                                                                                                                                                      :

                                                                                                                                                      // card 8
                                                                                                                                                      (i == 1 && j == 5 && dragItemD.isNotEmpty && dragItemD.contains("16"))
                                                                                                                                                          ? Container(
                                                                                                                                                              width: width * 0.08,
                                                                                                                                                              height: width * 0.09,
                                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                                              ),
                                                                                                                                                            )
                                                                                                                                                          :

                                                                                                                                                          // card 8
                                                                                                                                                          Container(
                                                                                                                                                              width: width * 0.08,
                                                                                                                                                              height: width * 0.09,
                                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                                                color: Colors.white,
                                                                                                                                                                boxShadow: [],
                                                                                                                                                              ),
                                                                                                                                                              child: Padding(
                                                                                                                                                                padding: EdgeInsets.all(width * 0.0),
                                                                                                                                                                child: ColorFiltered(
                                                                                                                                                                  colorFilter: nama_filter == 'greyscale'
                                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                        )
                                                                                                                                                                      : nama_filter == 'classic negative'
                                                                                                                                                                          ? ColorFilter.mode(
                                                                                                                                                                              Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                              BlendMode.saturation,
                                                                                                                                                                            )
                                                                                                                                                                          : nama_filter == 'black white blur'
                                                                                                                                                                              ? ColorFilter.mode(
                                                                                                                                                                                  Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                  BlendMode.saturation,
                                                                                                                                                                                )
                                                                                                                                                                              : nama_filter == 'mute'
                                                                                                                                                                                  ? ColorFilter.mode(
                                                                                                                                                                                      Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                      BlendMode.saturation,
                                                                                                                                                                                    )
                                                                                                                                                                                  : nama_filter == 'webcore'
                                                                                                                                                                                      ? ColorFilter.mode(
                                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                                        )
                                                                                                                                                                                      : ColorFilter.mode(
                                                                                                                                                                                          Color.fromARGB(0, 255, 255, 255),
                                                                                                                                                                                          BlendMode.saturation,
                                                                                                                                                                                        ),
                                                                                                                                                                  child: i == 1 && j == 7
                                                                                                                                                                      ? Container()
                                                                                                                                                                      : Container(
                                                                                                                                                                          width: width * 0.12,
                                                                                                                                                                          height: height * 0.3,
                                                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                                                                                            image: DecorationImage(
                                                                                                                                                                              image: NetworkImage(
                                                                                                                                                                                i == 0 ? "${Variables.ipv4_local}/storage/${dragItemD[j].toString()}" : "${Variables.ipv4_local}/storage/${dragItemD[j + 8].toString()}",
                                                                                                                                                                                scale: 1,
                                                                                                                                                                              ),
                                                                                                                                                                              fit: BoxFit.cover,
                                                                                                                                                                            ),
                                                                                                                                                                          ),
                                                                                                                                                                        ),
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                        )
                                                                                      : Container(),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // =====================================================
                            // =====================================================
                            // End - Menu Pilih Foto / Draggable Card Image / Foto
                            // =====================================================
                            // =====================================================

                            OutlinedButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                                backgroundColor: Colors.black.withOpacity(0.7),
                              ),
                              onPressed: () {
                                // do onpressed...
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FilterWidget(
                                        nama: nama,
                                        title: title,
                                        backgrounds: backgrounds,
                                      ),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: Container(
                                // color: Colors.transparent,
                                width: width * 0.17,
                                // height: height * 0.012,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.arrow_circle_left_outlined,
                                          color: Colors.white,
                                          size: width * 0.015,
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Kembali".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width * 0.010,
                                              color: Colors.white,
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
                      Container(
                        width: width * 0.5,
                        child: Center(
                          child: Column(
                            children: [
                              // top view layout choose view
                              Padding(
                                padding: EdgeInsets.all(
                                  width * 0.015,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: bg_warna_main != ""
                                        ? HexColor(bg_warna_main)
                                        : Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: bg_warna_main != ""
                                            ? HexColor(bg_warna_main)
                                            : Colors.transparent,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  height: height * 0.17,
                                  width: width * 0.375,

                                  // ===========================================================================================
                                  // ============= Row Pilih Kanvas Menu Tengah Kecil, A Dan B Fix 1 Dan 2 Menu ================
                                  // ===========================================================================================
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // ...

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] == '1 Kotak')
                                            if (choose1 == 'Layout 1')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 4,
                                                  height: 900 / 4,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak1_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak1_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak1_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak1_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            // ...
                                                          ),
                                                        ),

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak2_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak2_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak2_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak2_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '2 Kotak, 1 Row')
                                            if (choose1 == 'Layout 2')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak1_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak1_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak1_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak1_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.2,
                                                            // ...
                                                          ),
                                                        ),

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak2_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak2_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak2_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak2_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.2,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak3_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak3_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak3_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak3_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.2,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '2 Kotak, 1 Kolum')
                                            if (choose1 == 'Layout 3')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak1_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak1_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak1_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak1_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.7,
                                                            // ...
                                                          ),
                                                        ),

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak2_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak2_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak2_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak2_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.7,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak3_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak3_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak3_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak3_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.7,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...

                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak4_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak4_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak4_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak4_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.7,
                                                            // ...
                                                          ),
                                                        ),
                                                        // ...
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '4 Kotak, Lurus')
                                            if (choose1 == 'Layout 4')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 4,
                                                  height: 900 / 4,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak1_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak1_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak1_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak1_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),

                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak2_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak2_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak2_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak2_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak3_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak3_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak3_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak3_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),

                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak4_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak4_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak4_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak4_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak5_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak5_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak5_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak5_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.5,
                                                            // ...
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '4 Kotak, Miring Sisi Kanan')
                                            if (choose1 == 'Layout 5')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 4,
                                                  height: 900 / 4,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak1_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak1_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak1_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak1_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak2_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak2_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak2_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak2_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Positioned(
                                                              top: int.parse(layout[
                                                                              'kotak3_top']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              left: int.parse(layout[
                                                                              'kotak3_left']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              child: Container(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        160,
                                                                        117),
                                                                width: int.parse(
                                                                            layout['kotak3_width'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                height: int.parse(
                                                                            layout['kotak3_height'].toString())
                                                                        .toDouble() /
                                                                    4.5,
                                                                // ...
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak4_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak4_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak4_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak4_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak5_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak5_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak5_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak5_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.5,
                                                            // ...
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '4 Kotak, Miring Sisi Kiri')
                                            if (choose1 == 'Layout 6')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 4,
                                                  height: 900 / 4,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak1_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak1_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak1_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak1_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak2_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak2_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak2_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak2_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak3_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak3_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak3_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak3_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak4_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4,
                                                                left: int.parse(
                                                                            layout['kotak4_left'].toString())
                                                                        .toDouble() /
                                                                    4,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak4_width'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  height: int.parse(
                                                                              layout['kotak4_height'].toString())
                                                                          .toDouble() /
                                                                      4.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...
                                                        Positioned(
                                                          top: int.parse(layout[
                                                                          'kotak5_top']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          left: int.parse(layout[
                                                                          'kotak5_left']
                                                                      .toString())
                                                                  .toDouble() /
                                                              4,
                                                          child: Container(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    214,
                                                                    160,
                                                                    117),
                                                            width: int.parse(layout[
                                                                            'kotak5_width']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            height: int.parse(layout[
                                                                            'kotak5_height']
                                                                        .toString())
                                                                    .toDouble() /
                                                                5.5,
                                                            // ...
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '5 Kotak, 2 Kiri, 3 Kanan')
                                            if (choose1 == 'Layout 7')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak1_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak1_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak1_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak1_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak2_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak2_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak2_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak2_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak3_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak3_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak3_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak3_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak4_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak4_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak4_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak4_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak5_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak5_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak5_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak5_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            // ...
                                                          ],
                                                        ),

                                                        // ...

                                                        // ...
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0.0),
                                                          child: Positioned(
                                                            top: int.parse(layout[
                                                                            'kotak6_top']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            left: int.parse(layout[
                                                                            'kotak6_left']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            child: Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      160,
                                                                      117),
                                                              width: int.parse(layout[
                                                                              'kotak6_width']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              height: int.parse(
                                                                          layout['kotak6_height']
                                                                              .toString())
                                                                      .toDouble() /
                                                                  5,
                                                              // ...
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '5 Kotak, 3 Kiri, 2 Kanan')
                                            if (choose1 == 'Layout 8')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak1_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak1_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak1_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak1_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak2_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak2_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak2_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak2_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak3_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak3_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak3_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak3_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak4_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak4_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak4_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak4_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),

                                                                // ...
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Positioned(
                                                                    top: int.parse(layout['kotak5_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak5_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak5_width'].toString())
                                                                              .toDouble() /
                                                                          5.2,
                                                                      height:
                                                                          int.parse(layout['kotak5_height'].toString()).toDouble() /
                                                                              5.2,
                                                                      // ...
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            // ...
                                                          ],
                                                        ),

                                                        // ...

                                                        // ...
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0.0),
                                                          child: Positioned(
                                                            top: int.parse(layout[
                                                                            'kotak6_top']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            left: int.parse(layout[
                                                                            'kotak6_left']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4,
                                                            child: Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      160,
                                                                      117),
                                                              width: int.parse(layout[
                                                                              'kotak6_width']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  4,
                                                              height: int.parse(
                                                                          layout['kotak6_height']
                                                                              .toString())
                                                                      .toDouble() /
                                                                  5,
                                                              // ...
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '6 Kotak, Lurus')
                                            if (choose1 == 'Layout 9')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak1_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak1_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak1_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak1_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak2_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak2_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak2_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak2_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak3_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak3_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak3_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak3_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak4_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak4_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak4_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak4_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak5_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak5_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak5_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak5_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak6_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak6_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak6_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak6_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...

                                                        // ...
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0.0),
                                                          child: Positioned(
                                                            top: int.parse(layout[
                                                                            'kotak7_top']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            left: int.parse(layout[
                                                                            'kotak7_left']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            child: Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      160,
                                                                      117),
                                                              width: int.parse(layout[
                                                                              'kotak7_width']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  3.8,
                                                              height: int.parse(
                                                                          layout['kotak7_height']
                                                                              .toString())
                                                                      .toDouble() /
                                                                  6.5,
                                                              // ...
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '6 Kotak, Miring Sisi Kanan')
                                            if (choose1 == 'Layout 10')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak1_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak1_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak1_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak1_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak2_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak2_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak2_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak2_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak3_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak3_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak3_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak3_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak4_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak4_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak4_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak4_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak5_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak5_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak5_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak5_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak6_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak6_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak6_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak6_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...

                                                        // ...
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0.0),
                                                          child: Positioned(
                                                            top: int.parse(layout[
                                                                            'kotak7_top']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            left: int.parse(layout[
                                                                            'kotak7_left']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            child: Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      160,
                                                                      117),
                                                              width: int.parse(layout[
                                                                              'kotak7_width']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  3.8,
                                                              height: int.parse(
                                                                          layout['kotak7_height']
                                                                              .toString())
                                                                      .toDouble() /
                                                                  6.5,
                                                              // ...
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                      for (var layout in layouts)
                                        if (layout['status'] == 'Aktif')
                                          if (layout['tipe'] ==
                                              '6 Kotak, Miring Sisi Kiri')
                                            if (choose1 == 'Layout 11')
                                              if (isChoose1 = true)
                                                Container(
                                                  // ...
                                                  width: 600 / 3.7,
                                                  height: 900 / 3.7,
                                                  color: Color.fromARGB(
                                                      255, 238, 217, 191),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: DragTarget(
                                                                builder: (BuildContext context,
                                                                    List<Object?>
                                                                        candidateData,
                                                                    List<dynamic>
                                                                        rejectedData) {
                                                                  return Positioned(
                                                                    top: int.parse(layout['kotak1_top'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    left: int.parse(layout['kotak1_left'].toString())
                                                                            .toDouble() /
                                                                        4.8,
                                                                    child:
                                                                        Container(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                      width: int.parse(layout['kotak1_width'].toString())
                                                                              .toDouble() /
                                                                          4.8,
                                                                      height:
                                                                          int.parse(layout['kotak1_height'].toString()).toDouble() /
                                                                              6.5,
                                                                      // ...
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak2_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak2_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak2_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak2_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak3_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak3_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak3_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak3_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak4_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak4_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak4_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak4_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 15,
                                                              ),
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak5_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak5_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak5_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak5_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),

                                                            // ...
                                                            Container(
                                                              child: Positioned(
                                                                top: int.parse(layout['kotak6_top']
                                                                            .toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                left: int.parse(
                                                                            layout['kotak6_left'].toString())
                                                                        .toDouble() /
                                                                    4.8,
                                                                child:
                                                                    Container(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          160,
                                                                          117),
                                                                  width: int.parse(
                                                                              layout['kotak6_width'].toString())
                                                                          .toDouble() /
                                                                      4.8,
                                                                  height: int.parse(
                                                                              layout['kotak6_height'].toString())
                                                                          .toDouble() /
                                                                      6.5,
                                                                  // ...
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // ...

                                                        // ...
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0.0),
                                                          child: Positioned(
                                                            top: int.parse(layout[
                                                                            'kotak7_top']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            left: int.parse(layout[
                                                                            'kotak7_left']
                                                                        .toString())
                                                                    .toDouble() /
                                                                4.8,
                                                            child: Container(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      160,
                                                                      117),
                                                              width: int.parse(layout[
                                                                              'kotak7_width']
                                                                          .toString())
                                                                      .toDouble() /
                                                                  3.8,
                                                              height: int.parse(
                                                                          layout['kotak7_height']
                                                                              .toString())
                                                                      .toDouble() /
                                                                  6.5,
                                                              // ...
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                    ],
                                  ),
                                  // ============ end pilih kanvas atas tengah kecil =================
                                  // =================================================================
                                ),
                              ),

                              // ===============================================
                              // == Layout Yang Dipilih Body View / Main View ==
                              // ===============================================

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    // ...
                                    for (var element in layouts)
                                      if (element['status'] == 'Aktif')
                                        Container(
                                          // ...
                                          width: 600,
                                          height: 900,
                                          color:
                                              Color.fromARGB(255, 209, 153, 85),
                                          child: Center(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: int.parse(
                                                          element['kotak1_top']
                                                              .toString())
                                                      .toDouble(),
                                                  left: int.parse(
                                                          element['kotak1_left']
                                                              .toString())
                                                      .toDouble(),
                                                  child: Container(
                                                    color: Color.fromARGB(
                                                        255, 234, 197, 167),
                                                    width: int.parse(element[
                                                                'kotak1_width']
                                                            .toString())
                                                        .toDouble(),
                                                    height: int.parse(element[
                                                                'kotak1_height']
                                                            .toString())
                                                        .toDouble(),
                                                    // ...
                                                  ),
                                                ),

                                                // ...
                                                Positioned(
                                                  top: int.parse(
                                                          element['kotak2_top']
                                                              .toString())
                                                      .toDouble(),
                                                  left: int.parse(
                                                          element['kotak2_left']
                                                              .toString())
                                                      .toDouble(),
                                                  child: Container(
                                                    color: Color.fromARGB(
                                                        255, 234, 197, 167),
                                                    width: int.parse(element[
                                                                'kotak2_width']
                                                            .toString())
                                                        .toDouble(),
                                                    height: int.parse(element[
                                                                'kotak2_height']
                                                            .toString())
                                                        .toDouble(),
                                                    // ...
                                                  ),
                                                ),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('2 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak3_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak3_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak3_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak3_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('3 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak4_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak4_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak4_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak4_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('4 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak5_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak5_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak5_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak5_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('5 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak6_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak6_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak6_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak6_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('6 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak7_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak7_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak7_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak7_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('7 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak8_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak8_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak8_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak8_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                                // ...

                                                // ...
                                                choose1
                                                        .toString()
                                                        .contains('8 Kotak')
                                                    ? Positioned(
                                                        top: int.parse(element[
                                                                    'kotak9_top']
                                                                .toString())
                                                            .toDouble(),
                                                        left: int.parse(element[
                                                                    'kotak9_left']
                                                                .toString())
                                                            .toDouble(),
                                                        child: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              197,
                                                              167),
                                                          width: int.parse(element[
                                                                      'kotak9_width']
                                                                  .toString())
                                                              .toDouble(),
                                                          height: int.parse(element[
                                                                      'kotak9_height']
                                                                  .toString())
                                                              .toDouble(),
                                                          // ...
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] == '1 Kotak')
                              //       if (choose1 == 'Layout 1')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 DragTarget(
                              //                   builder: (BuildContext context,
                              //                       List<Object?> candidateData,
                              //                       List<dynamic>
                              //                           rejectedData) {
                              //                     return Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak1_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak1_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak1_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak1_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     );
                              //                   },
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak2_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak2_left']
                              //                               .toString())
                              //                           .toDouble() -
                              //                       50,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak2_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak2_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //                 // ...
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] == '2 Kotak, 1 Row')
                              //       if (choose1 == 'Layout 2')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak1_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak1_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak1_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak1_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak2_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak2_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak2_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak2_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak3_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak3_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak3_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak3_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] == '3 Kotak')
                              //       if (choose1 == 'Layout 3')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak1_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak1_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak1_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak1_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak2_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak2_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak2_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak2_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak3_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak3_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak3_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak3_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),

                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak4_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak4_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak4_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak4_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] == '4 Kotak, Lurus')
                              //       if (choose1 == 'Layout 4')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak1_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak1_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak1_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak1_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak2_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak2_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak2_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak2_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak3_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak3_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak3_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak3_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak4_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak4_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak4_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak4_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak5_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak5_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak5_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak5_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.6,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '4 Kotak, Miring Sisi Kanan')
                              //       if (choose1 == 'Layout 5')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Positioned(
                              //                       top: int.parse(layout[
                              //                                       'kotak1_top']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       left: int.parse(layout[
                              //                                       'kotak1_left']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       child: Container(
                              //                         color: Color.fromARGB(
                              //                             255, 214, 160, 117),
                              //                         width: int.parse(layout[
                              //                                         'kotak1_width']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         height: int.parse(layout[
                              //                                         'kotak1_height']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         // ...
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               top: 65.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak2_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak2_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak2_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak2_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               8.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak3_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak3_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak3_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak3_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                           // child: Text("Kotak ke 3"),
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               top: 65.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak4_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak4_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak4_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak4_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak5_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak5_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak5_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak5_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.6,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '4 Kotak, Miring Sisi Kiri')
                              //       if (choose1 == 'Layout 6')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               top: 65.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak1_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak1_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak1_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak1_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               top: 0.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak2_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak2_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak2_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak2_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               8.0),
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.only(
                              //                                 top: 65.0),
                              //                         child: Positioned(
                              //                           top: int.parse(layout[
                              //                                           'kotak3_top']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           left: int.parse(layout[
                              //                                           'kotak3_left']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           child: Container(
                              //                             color: Color.fromARGB(
                              //                                 255,
                              //                                 214,
                              //                                 160,
                              //                                 117),
                              //                             width: int.parse(layout[
                              //                                             'kotak3_width']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             height: int.parse(layout[
                              //                                             'kotak3_height']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             // ...
                              //                             // child: Text("Kotak ke 3"),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               top: 0.0),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak4_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak4_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak4_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak4_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...
                              //                 Positioned(
                              //                   top: int.parse(
                              //                               layout['kotak5_top']
                              //                                   .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   left: int.parse(layout[
                              //                                   'kotak5_left']
                              //                               .toString())
                              //                           .toDouble() /
                              //                       1.5,
                              //                   child: Container(
                              //                     color: Color.fromARGB(
                              //                         255, 214, 160, 117),
                              //                     width: int.parse(layout[
                              //                                     'kotak5_width']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     height: int.parse(layout[
                              //                                     'kotak5_height']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.6,
                              //                     // ...
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '5 Kotak, 2 Kiri, 3 Kanan')
                              //       if (choose1 == 'Layout 7')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak1_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak1_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak1_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak1_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak2_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak2_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak2_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak2_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),

                              //                     Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak3_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak3_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak3_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak3_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak4_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak4_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak4_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak4_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak5_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak5_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak5_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak5_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     // ...
                              //                   ],
                              //                 ),

                              //                 // ...

                              //                 // ...
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 0.0),
                              //                   child: Positioned(
                              //                     top: int.parse(layout[
                              //                                     'kotak6_top']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     left: int.parse(layout[
                              //                                     'kotak6_left']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     child: Container(
                              //                       color: Color.fromARGB(
                              //                           255, 214, 160, 117),
                              //                       width: int.parse(layout[
                              //                                       'kotak6_width']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       height: int.parse(layout[
                              //                                       'kotak6_height']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       // ...
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '5 Kotak, 3 Kiri, 2 Kanan')
                              //       if (choose1 == 'Layout 8')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak1_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak1_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak1_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak1_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak2_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak2_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak2_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak2_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak3_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak3_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak3_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak3_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     // ...

                              //                     Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak4_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak4_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak4_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak4_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),

                              //                         // ...
                              //                         Container(
                              //                           margin:
                              //                               EdgeInsets.all(15),
                              //                           child: Positioned(
                              //                             top: int.parse(layout[
                              //                                             'kotak5_top']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             left: int.parse(layout[
                              //                                             'kotak5_left']
                              //                                         .toString())
                              //                                     .toDouble() /
                              //                                 1.5,
                              //                             child: Container(
                              //                               color:
                              //                                   Color.fromARGB(
                              //                                       255,
                              //                                       214,
                              //                                       160,
                              //                                       117),
                              //                               width: int.parse(layout[
                              //                                               'kotak5_width']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               height: int.parse(layout[
                              //                                               'kotak5_height']
                              //                                           .toString())
                              //                                       .toDouble() /
                              //                                   1.5,
                              //                               // ...
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...

                              //                 // ...
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 0.0),
                              //                   child: Positioned(
                              //                     top: int.parse(layout[
                              //                                     'kotak6_top']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     left: int.parse(layout[
                              //                                     'kotak6_left']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     child: Container(
                              //                       color: Color.fromARGB(
                              //                           255, 214, 160, 117),
                              //                       width: int.parse(layout[
                              //                                       'kotak6_width']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       height: int.parse(layout[
                              //                                       'kotak6_height']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       // ...
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] == '6 Kotak, Lurus')
                              //       if (choose1 == 'Layout 9')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak1_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak1_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak1_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak1_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak2_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak2_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak2_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak2_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak3_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak3_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak3_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak3_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak4_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak4_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak4_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak4_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak5_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak5_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak5_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak5_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak6_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak6_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak6_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak6_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...

                              //                 // ...
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 0.0),
                              //                   child: Positioned(
                              //                     top: int.parse(layout[
                              //                                     'kotak7_top']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     left: int.parse(layout[
                              //                                     'kotak7_left']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     child: Container(
                              //                       color: Color.fromARGB(
                              //                           255, 214, 160, 117),
                              //                       width: int.parse(layout[
                              //                                       'kotak7_width']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       height: int.parse(layout[
                              //                                       'kotak7_height']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       // ...
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '6 Kotak, Miring Sisi Kanan')
                              //       if (choose1 == 'Layout 10')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceAround,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak1_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak1_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak1_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak1_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak2_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak2_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak2_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak2_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak3_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak3_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak3_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak3_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak4_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak4_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak4_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak4_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.all(5),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak5_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak5_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak5_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak5_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak6_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak6_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak6_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak6_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...

                              //                 // ...
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 0.0),
                              //                   child: Positioned(
                              //                     top: int.parse(layout[
                              //                                     'kotak7_top']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     left: int.parse(layout[
                              //                                     'kotak7_left']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     child: Container(
                              //                       color: Color.fromARGB(
                              //                           255, 214, 160, 117),
                              //                       width: int.parse(layout[
                              //                                       'kotak7_width']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       height: int.parse(layout[
                              //                                       'kotak7_height']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       // ...
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // for (var layout in layouts)
                              //   if (layout['status'] == 'Aktif')
                              //     if (layout['tipe'] ==
                              //         '6 Kotak, Miring Sisi Kiri')
                              //       if (choose1 == 'Layout 11')
                              //         Container(
                              //           // ...
                              //           width: 500,
                              //           height: 650,
                              //           color:
                              //               Color.fromARGB(255, 238, 217, 191),
                              //           child: Center(
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceEvenly,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceEvenly,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak1_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak1_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak1_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak1_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak2_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak2_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak2_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak2_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak3_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak3_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak3_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak3_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak4_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak4_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak4_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak4_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),

                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   children: [
                              //                     Container(
                              //                       margin: EdgeInsets.only(
                              //                         top: 30,
                              //                       ),
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak5_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak5_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak5_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak5_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),

                              //                     // ...
                              //                     Container(
                              //                       child: Positioned(
                              //                         top: int.parse(layout[
                              //                                         'kotak6_top']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         left: int.parse(layout[
                              //                                         'kotak6_left']
                              //                                     .toString())
                              //                                 .toDouble() /
                              //                             1.5,
                              //                         child: Container(
                              //                           color: Color.fromARGB(
                              //                               255, 214, 160, 117),
                              //                           width: int.parse(layout[
                              //                                           'kotak6_width']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           height: int.parse(layout[
                              //                                           'kotak6_height']
                              //                                       .toString())
                              //                                   .toDouble() /
                              //                               1.5,
                              //                           // ...
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 // ...

                              //                 // ...
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 0.0),
                              //                   child: Positioned(
                              //                     top: int.parse(layout[
                              //                                     'kotak7_top']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     left: int.parse(layout[
                              //                                     'kotak7_left']
                              //                                 .toString())
                              //                             .toDouble() /
                              //                         1.5,
                              //                     child: Container(
                              //                       color: Color.fromARGB(
                              //                           255, 214, 160, 117),
                              //                       width: int.parse(layout[
                              //                                       'kotak7_width']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       height: int.parse(layout[
                              //                                       'kotak7_height']
                              //                                   .toString())
                              //                               .toDouble() /
                              //                           1.5,
                              //                       // ...
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),

                              // =================================
                              // ====== end layout mainview ======
                              // =================================
                            ],
                          ),
                        ),
                      ),

                      // pilih layout / edit foto view
                      Container(
                        width: width * 0.25,
                        color: bg_warna_main != ""
                            ? HexColor(bg_warna_main)
                            : Colors.transparent,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: width * 0.012,
                                  bottom: width * 0.0,
                                ),
                                child: Text(
                                  foto_details != ""
                                      ? "Edit Foto"
                                      : "Pilih Layout",
                                  style: TextStyle(
                                    fontSize: width * 0.021,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              //
                              SizedBox(height: height * 0.0025),

                              // menu pilih layout / button selanjutnya
                              Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.transparent,
                                    width: 3,
                                  )),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                            width * 0.0,
                                          ),
                                          child: Screenshot(
                                            // screenshot
                                            controller: screenshotController,
                                            child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.all(20.0),
                                                child: Container(
                                                  height: foto_details != ""
                                                      ? width * 0.15
                                                      : height * 0.55,
                                                  width: foto_details != ""
                                                      ? width * 0.15
                                                      : null,
                                                  color: foto_details != ""
                                                      ? Colors.transparent
                                                      : Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: foto_details != ""
                                                        ? Container(
                                                            width: width * 0.13,
                                                            height:
                                                                width * 0.13,
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                RotationTransition(
                                                              turns: new AlwaysStoppedAnimation(
                                                                  _currentSliderValuePutarGambar
                                                                          .round() /
                                                                      360),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(width *
                                                                        0.013),
                                                                child:
                                                                    PhotoView(
                                                                  backgroundDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .transparent,
                                                                    boxShadow: [],
                                                                  ),
                                                                  controller:
                                                                      controller,
                                                                  scaleStateController:
                                                                      scaleStateController,
                                                                  enableRotation:
                                                                      true,
                                                                  initialScale:
                                                                      minScale *
                                                                          1.5,
                                                                  minScale:
                                                                      minScale,
                                                                  maxScale:
                                                                      maxScale,
                                                                  imageProvider:
                                                                      NetworkImage(
                                                                    // =======
                                                                    // Paket A
                                                                    // =======
                                                                    title.toString().contains(
                                                                            "Paket A")
                                                                        ? "${Variables.ipv4_local}/storage/${listA[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "10" ? 3 : foto_details == "11" ? 4 : foto_details == "12" ? 5 : 6].toString()}"
                                                                        :

                                                                        // =======
                                                                        // Paket B
                                                                        // =======
                                                                        title.toString().contains("Paket B")
                                                                            ? "${Variables.ipv4_local}/storage/${listB[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "03" ? 3 : foto_details == "10" ? 4 : foto_details == "11" ? 5 : foto_details == "12" ? 6 : 7].toString()}"
                                                                            :

                                                                            // =======
                                                                            // Paket C
                                                                            // =======
                                                                            title.toString().contains("Paket C")
                                                                                ? "${Variables.ipv4_local}/storage/${listC[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "03" ? 3 : foto_details == "04" ? 4 : foto_details == "05" ? 5 : foto_details == "10" ? 6 : foto_details == "11" ? 7 : foto_details == "12" ? 8 : foto_details == "13" ? 9 : foto_details == "14" ? 10 : foto_details == "15" ? 11 : 12].toString()}"
                                                                                :

                                                                                // =======
                                                                                // Paket D
                                                                                // =======
                                                                                title.toString().contains("Paket D")
                                                                                    ? "${Variables.ipv4_local}/storage/${listD[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "03" ? 3 : foto_details == "04" ? 4 : foto_details == "05" ? 5 : foto_details == "06" ? 6 : foto_details == "07" ? 7 : foto_details == "10" ? 8 : foto_details == "11" ? 9 : foto_details == "12" ? 10 : foto_details == "13" ? 11 : foto_details == "14" ? 12 : foto_details == "15" ? 13 : foto_details == "16" ? 14 : 15].toString()}"
                                                                                    :

                                                                                    // =======
                                                                                    // Paket E
                                                                                    // =======
                                                                                    title.toString().contains("Paket E")
                                                                                        ? "${Variables.ipv4_local}/storage/${listE[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "03" ? 3 : foto_details == "04" ? 4 : foto_details == "05" ? 5 : foto_details == "06" ? 6 : foto_details == "07" ? 7 : foto_details == "08" ? 8 : foto_details == "09" ? 9 : foto_details == "10" ? 10 : foto_details == "11" ? 11 : foto_details == "12" ? 12 : foto_details == "13" ? 13 : foto_details == "14" ? 14 : foto_details == "15" ? 15 : foto_details == "16" ? 16 : foto_details == "17" ? 17 : foto_details == "18" ? 18 : foto_details == "19" ? 19 : 20].toString()}"
                                                                                        :

                                                                                        // =======
                                                                                        // Paket F
                                                                                        // =======
                                                                                        title.toString().contains("Paket F")
                                                                                            ? "${Variables.ipv4_local}/storage/${listF[foto_details == "00" ? 0 : foto_details == "01" ? 1 : foto_details == "02" ? 2 : foto_details == "03" ? 3 : foto_details == "04" ? 4 : foto_details == "05" ? 5 : foto_details == "06" ? 6 : foto_details == "07" ? 7 : foto_details == "08" ? 8 : foto_details == "09" ? 9 : foto_details == "10" ? 10 : foto_details == "11" ? 11 : foto_details == "12" ? 12 : foto_details == "13" ? 13 : foto_details == "14" ? 14 : foto_details == "15" ? 15 : foto_details == "16" ? 16 : foto_details == "17" ? 17 : foto_details == "18" ? 18 : foto_details == "19" ? 19 : foto_details == "20" ? 20 : foto_details == "21" ? 21 : foto_details == "22" ? 22 : foto_details == "23" ? 23 : foto_details == "24" ? 24 : 25].toString()}"
                                                                                            :

                                                                                            // ==============
                                                                                            // Paket G Atau H
                                                                                            // ==============
                                                                                            title.toString().contains("Paket G") || title.toString().contains("Paket H")
                                                                                                ? "${Variables.ipv4_local}/storage/${listG[foto_details == "00" ? 0 : 0].toString()}"
                                                                                                : "${Variables.ipv4_local}/storage/${listH[foto_details == "00" ? 0 : 0].toString()}",
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : ScrollConfiguration(
                                                            behavior: ScrollConfiguration
                                                                    .of(context)
                                                                .copyWith(
                                                                    scrollbars:
                                                                        false),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                verticalDirection:
                                                                    VerticalDirection
                                                                        .down,
                                                                spacing: width *
                                                                    0.01,
                                                                runSpacing:
                                                                    width *
                                                                        0.01,
                                                                children: [
                                                                  // ===========
                                                                  // Loop Layout
                                                                  // ===========

                                                                  // ========
                                                                  // Layout 1
                                                                  // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '1 Kotak')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak1_top'].toString()).toDouble() / 3.5,
                                                                  //                   left: int.parse(layout['kotak1_left'].toString()).toDouble() / 3.5,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak1_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak1_height'].toString()).toDouble() / 3.5,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak2_top'].toString()).toDouble() / 3.5,
                                                                  //                   left: int.parse(layout['kotak2_left'].toString()).toDouble() / 3.5,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak2_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak2_height'].toString()).toDouble() / 3.5,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 2
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '2 Kotak, 1 Row')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4,
                                                                  //                     height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4,
                                                                  //                     height: int.parse(layout['kotak2_height'].toString()).toDouble() / 3.8,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4,
                                                                  //                     height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 3
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '3 Kotak')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak1_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.2,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak2_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.2,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak3_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.2,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4,
                                                                  //                   left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak4_width'].toString()).toDouble() / 3.5,
                                                                  //                     height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.2,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 4
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '4 Kotak, Lurus')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak1_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak1_left'].toString()).toDouble() / 3.5,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak1_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak1_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak2_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak2_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak2_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak2_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak3_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak3_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak3_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak3_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak4_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak4_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak4_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak4_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak5_top'].toString()).toDouble() / 3.8,
                                                                  //                   left: int.parse(layout['kotak5_left'].toString()).toDouble() / 3.8,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak5_width'].toString()).toDouble() / 3.8,
                                                                  //                     height: int.parse(layout['kotak5_height'].toString()).toDouble() / 3.8,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 5
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '4 Kotak, Miring Sisi Kanan')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak1_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak1_left'].toString()).toDouble() / 3.5,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak1_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak1_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 25),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak2_top'].toString()).toDouble() / 3.8,
                                                                  //                         left: int.parse(layout['kotak2_left'].toString()).toDouble() / 3.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak2_width'].toString()).toDouble() / 3.8,
                                                                  //                           height: int.parse(layout['kotak2_height'].toString()).toDouble() / 3.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak3_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak3_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak3_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak3_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 25),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak4_top'].toString()).toDouble() / 3.8,
                                                                  //                         left: int.parse(layout['kotak4_left'].toString()).toDouble() / 3.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak4_width'].toString()).toDouble() / 3.8,
                                                                  //                           height: int.parse(layout['kotak4_height'].toString()).toDouble() / 3.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak5_top'].toString()).toDouble() / 3.8,
                                                                  //                   left: int.parse(layout['kotak5_left'].toString()).toDouble() / 3.8,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak5_width'].toString()).toDouble() / 3.8,
                                                                  //                     height: int.parse(layout['kotak5_height'].toString()).toDouble() / 3.8,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 6
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '4 Kotak, Miring Sisi Kiri')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 25),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak1_top'].toString()).toDouble() / 3.8,
                                                                  //                         left: int.parse(layout['kotak1_left'].toString()).toDouble() / 3.5,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak1_width'].toString()).toDouble() / 3.8,
                                                                  //                           height: int.parse(layout['kotak1_height'].toString()).toDouble() / 3.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak2_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak2_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak2_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak2_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 25),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak3_top'].toString()).toDouble() / 3.8,
                                                                  //                         left: int.parse(layout['kotak3_left'].toString()).toDouble() / 3.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak3_width'].toString()).toDouble() / 3.8,
                                                                  //                           height: int.parse(layout['kotak3_height'].toString()).toDouble() / 3.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Positioned(
                                                                  //                       top: int.parse(layout['kotak4_top'].toString()).toDouble() / 3.8,
                                                                  //                       left: int.parse(layout['kotak4_left'].toString()).toDouble() / 3.8,
                                                                  //                       child: Container(
                                                                  //                         color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                         width: int.parse(layout['kotak4_width'].toString()).toDouble() / 3.8,
                                                                  //                         height: int.parse(layout['kotak4_height'].toString()).toDouble() / 3.8,
                                                                  //                         // ...
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...
                                                                  //                 Positioned(
                                                                  //                   top: int.parse(layout['kotak5_top'].toString()).toDouble() / 3.8,
                                                                  //                   left: int.parse(layout['kotak5_left'].toString()).toDouble() / 3.8,
                                                                  //                   child: Container(
                                                                  //                     color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                     width: int.parse(layout['kotak5_width'].toString()).toDouble() / 3.8,
                                                                  //                     height: int.parse(layout['kotak5_height'].toString()).toDouble() / 3.8,
                                                                  //                     // ...
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 7
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '5 Kotak, 2 Kiri, 3 Kanan')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Column(
                                                                  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                       children: [
                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ],
                                                                  //                     ),

                                                                  //                     Column(
                                                                  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                       children: [
                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak4_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak5_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak5_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak5_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak5_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ],
                                                                  //                     ),
                                                                  //                     // ...
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Padding(
                                                                  //                   padding: const EdgeInsets.only(top: 0.0),
                                                                  //                   child: Positioned(
                                                                  //                     top: int.parse(layout['kotak6_top'].toString()).toDouble() / 4,
                                                                  //                     left: int.parse(layout['kotak6_left'].toString()).toDouble() / 4,
                                                                  //                     child: Container(
                                                                  //                       color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                       width: int.parse(layout['kotak6_width'].toString()).toDouble() / 4,
                                                                  //                       height: int.parse(layout['kotak6_height'].toString()).toDouble() / 2,
                                                                  //                       // ...
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 8
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '5 Kotak, 3 Kiri, 2 Kanan')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Column(
                                                                  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                       children: [
                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ],
                                                                  //                     ),
                                                                  //                     // ...

                                                                  //                     Column(
                                                                  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                       children: [
                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak4_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),

                                                                  //                         // ...
                                                                  //                         Container(
                                                                  //                           margin: EdgeInsets.all(5),
                                                                  //                           child: Positioned(
                                                                  //                             top: int.parse(layout['kotak5_top'].toString()).toDouble() / 4.8,
                                                                  //                             left: int.parse(layout['kotak5_left'].toString()).toDouble() / 4.8,
                                                                  //                             child: Container(
                                                                  //                               color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                               width: int.parse(layout['kotak5_width'].toString()).toDouble() / 4.8,
                                                                  //                               height: int.parse(layout['kotak5_height'].toString()).toDouble() / 4.8,
                                                                  //                               // ...
                                                                  //                             ),
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ],
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Padding(
                                                                  //                   padding: const EdgeInsets.only(top: 0.0),
                                                                  //                   child: Positioned(
                                                                  //                     top: int.parse(layout['kotak6_top'].toString()).toDouble() / 4,
                                                                  //                     left: int.parse(layout['kotak6_left'].toString()).toDouble() / 4,
                                                                  //                     child: Container(
                                                                  //                       color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                       width: int.parse(layout['kotak6_width'].toString()).toDouble() / 4,
                                                                  //                       height: int.parse(layout['kotak6_height'].toString()).toDouble() / 2,
                                                                  //                       // ...
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 9
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '6 Kotak, Lurus')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak4_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak5_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak5_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak5_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak5_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak6_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak6_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak6_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak6_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Padding(
                                                                  //                   padding: const EdgeInsets.only(top: 0.0),
                                                                  //                   child: Positioned(
                                                                  //                     top: int.parse(layout['kotak7_top'].toString()).toDouble() / 4.8,
                                                                  //                     left: int.parse(layout['kotak7_left'].toString()).toDouble() / 4.8,
                                                                  //                     child: Container(
                                                                  //                       color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                       width: int.parse(layout['kotak7_width'].toString()).toDouble() / 3.8,
                                                                  //                       height: int.parse(layout['kotak7_height'].toString()).toDouble() / 2.7,
                                                                  //                       // ...
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 10
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '6 Kotak, Miring Sisi Kanan')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       // margin: EdgeInsets.all(2),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       // margin: EdgeInsets.all(2),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak4_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       // margin: EdgeInsets.all(2),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak5_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak5_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak5_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak5_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak6_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak6_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak6_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak6_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Padding(
                                                                  //                   padding: const EdgeInsets.only(top: 0.0),
                                                                  //                   child: Positioned(
                                                                  //                     top: int.parse(layout['kotak7_top'].toString()).toDouble() / 4.8,
                                                                  //                     left: int.parse(layout['kotak7_left'].toString()).toDouble() / 4.8,
                                                                  //                     child: Container(
                                                                  //                       color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                       width: int.parse(layout['kotak7_width'].toString()).toDouble() / 3.8,
                                                                  //                       height: int.parse(layout['kotak7_height'].toString()).toDouble() / 2.7,
                                                                  //                       // ...
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  // // ========
                                                                  // // Layout 11
                                                                  // // ========
                                                                  // for (var layout
                                                                  //     in layouts)
                                                                  //   if (layout[
                                                                  //           'status'] ==
                                                                  //       'Aktif')
                                                                  //     if (layout[
                                                                  //             'tipe'] ==
                                                                  //         '6 Kotak, Miring Sisi Kiri')
                                                                  //       InkWell(
                                                                  //         onTap:
                                                                  //             () {
                                                                  //           // ...
                                                                  //           setState(() {
                                                                  //             // ...
                                                                  //             choose1 = layout['tipe'];
                                                                  //             isChoose1 = !isChoose1;
                                                                  //           });
                                                                  //         },
                                                                  //         child:
                                                                  //             Container(
                                                                  //           // ...
                                                                  //           width:
                                                                  //               600 / 3.7,
                                                                  //           height:
                                                                  //               900 / 3.7,
                                                                  //           color: Color.fromARGB(
                                                                  //               255,
                                                                  //               238,
                                                                  //               217,
                                                                  //               191),
                                                                  //           child:
                                                                  //               Center(
                                                                  //             child: Column(
                                                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //               children: [
                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak1_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak1_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak1_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak1_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak2_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak2_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak2_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak2_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak3_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak3_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak3_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak3_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak4_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak4_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak4_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak4_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),

                                                                  //                 Row(
                                                                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //                   children: [
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.only(top: 15),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak5_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak5_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak5_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak5_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),

                                                                  //                     // ...
                                                                  //                     Container(
                                                                  //                       margin: EdgeInsets.all(5),
                                                                  //                       child: Positioned(
                                                                  //                         top: int.parse(layout['kotak6_top'].toString()).toDouble() / 4.8,
                                                                  //                         left: int.parse(layout['kotak6_left'].toString()).toDouble() / 4.8,
                                                                  //                         child: Container(
                                                                  //                           color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                           width: int.parse(layout['kotak6_width'].toString()).toDouble() / 4.8,
                                                                  //                           height: int.parse(layout['kotak6_height'].toString()).toDouble() / 4.8,
                                                                  //                           // ...
                                                                  //                         ),
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //                 // ...

                                                                  //                 // ...
                                                                  //                 Padding(
                                                                  //                   padding: const EdgeInsets.only(top: 0.0),
                                                                  //                   child: Positioned(
                                                                  //                     top: int.parse(layout['kotak7_top'].toString()).toDouble() / 4.8,
                                                                  //                     left: int.parse(layout['kotak7_left'].toString()).toDouble() / 4.8,
                                                                  //                     child: Container(
                                                                  //                       color: Color.fromARGB(255, 214, 160, 117),
                                                                  //                       width: int.parse(layout['kotak7_width'].toString()).toDouble() / 3.8,
                                                                  //                       height: int.parse(layout['kotak7_height'].toString()).toDouble() / 2.7,
                                                                  //                       // ...
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ),

                                                                  for (var layout
                                                                      in layouts)
                                                                    if (layout[
                                                                            "status"] ==
                                                                        "aktif")
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          // ============
                                                                          // --- layout 1
                                                                          // ============

                                                                          if (isChoose2 ==
                                                                              true) {
                                                                            setState(() {
                                                                              choose2 = layout["nama"];
                                                                            });
                                                                          }
                                                                          if (isChoose1 ==
                                                                              true) {
                                                                            setState(() {
                                                                              choose1 = layout["nama"];
                                                                            });
                                                                          }

                                                                          print(
                                                                              "choose1 : $choose1");
                                                                          print(
                                                                              "choose2 : $choose2");
                                                                        },
                                                                        //
                                                                        child: layout["nama"] ==
                                                                                "Layout 1"
                                                                            ? Container(
                                                                                width: width * 0.085,
                                                                                decoration: BoxDecoration(color: Colors.white),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(
                                                                                    width * 0.01,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: Container(
                                                                                      width: width * 0.028,
                                                                                      height: width * 0.0725,
                                                                                      color: Colors.grey[300],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : layout["nama"] == "Layout 2"
                                                                                ? Container(
                                                                                    width: width * 0.085,
                                                                                    decoration: BoxDecoration(color: Colors.white),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(
                                                                                        width * 0.0067,
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                              top: width * 0.022,
                                                                                              bottom: width * 0.022,
                                                                                            ),
                                                                                            child: Container(
                                                                                              width: width * 0.032,
                                                                                              height: width * 0.04,
                                                                                              color: Colors.grey[300],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                              top: width * 0.022,
                                                                                              bottom: width * 0.022,
                                                                                            ),
                                                                                            child: Container(
                                                                                              width: width * 0.032,
                                                                                              height: width * 0.04,
                                                                                              color: Colors.grey[300],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : layout["nama"] == "Layout 3"
                                                                                    ? Container(
                                                                                        width: width * 0.084,
                                                                                        height: width * 0.105,
                                                                                        decoration: BoxDecoration(color: Colors.white),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(
                                                                                            width * 0.0047,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                              // ---
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(2.0),
                                                                                                child: Container(
                                                                                                  width: width * 0.04,
                                                                                                  height: width * 0.04,
                                                                                                  color: Colors.grey[300],
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(2.0),
                                                                                                child: Container(
                                                                                                  width: width * 0.04,
                                                                                                  height: width * 0.04,
                                                                                                  color: Colors.grey[300],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : layout["nama"] == "Layout 4"
                                                                                        ? Container(
                                                                                            width: width * 0.084,
                                                                                            height: width * 0.105,
                                                                                            decoration: BoxDecoration(color: Colors.white),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(
                                                                                                width * 0.0048,
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                    child: Container(
                                                                                                      width: width * 0.022,
                                                                                                      height: width * 0.028,
                                                                                                      color: Colors.grey[300],
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                    child: Container(
                                                                                                      width: width * 0.022,
                                                                                                      height: width * 0.028,
                                                                                                      color: Colors.grey[300],
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                    child: Container(
                                                                                                      width: width * 0.022,
                                                                                                      height: width * 0.028,
                                                                                                      color: Colors.grey[300],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : layout["nama"] == "Layout 5"
                                                                                            ? Container(
                                                                                                width: width * 0.084,
                                                                                                height: width * 0.105,
                                                                                                decoration: BoxDecoration(color: Colors.white),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.all(
                                                                                                    width * 0.0048,
                                                                                                  ),
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                                        child: Container(
                                                                                                          width: width * 0.028,
                                                                                                          height: width * 0.028,
                                                                                                          color: Colors.grey[300],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                                        child: Container(
                                                                                                          width: width * 0.028,
                                                                                                          height: width * 0.028,
                                                                                                          color: Colors.grey[300],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                                        child: Container(
                                                                                                          width: width * 0.028,
                                                                                                          height: width * 0.028,
                                                                                                          color: Colors.grey[300],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : layout["nama"] == "Layout 6"
                                                                                                ? Container(
                                                                                                    width: width * 0.085,
                                                                                                    height: width * 0.105,
                                                                                                    decoration: BoxDecoration(color: Colors.white),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(
                                                                                                        width * 0.0047,
                                                                                                      ),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                child: Container(
                                                                                                                  width: width * 0.03,
                                                                                                                  height: width * 0.03,
                                                                                                                  color: Colors.grey[300],
                                                                                                                ),
                                                                                                              ),
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                child: Container(
                                                                                                                  width: width * 0.03,
                                                                                                                  height: width * 0.03,
                                                                                                                  color: Colors.grey[300],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                child: Container(
                                                                                                                  width: width * 0.03,
                                                                                                                  height: width * 0.03,
                                                                                                                  color: Colors.grey[300],
                                                                                                                ),
                                                                                                              ),
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                child: Container(
                                                                                                                  width: width * 0.03,
                                                                                                                  height: width * 0.03,
                                                                                                                  color: Colors.grey[300],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : layout["nama"] == "Layout 7"
                                                                                                    ? Container(
                                                                                                        width: width * 0.084,
                                                                                                        height: width * 0.105,
                                                                                                        decoration: BoxDecoration(color: Colors.white),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.all(
                                                                                                            width * 0.0047,
                                                                                                          ),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                            children: [
                                                                                                              Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  // ---
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.034,
                                                                                                                      height: width * 0.034,
                                                                                                                      color: Colors.grey[300],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    height: 15,
                                                                                                                  ),
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.034,
                                                                                                                      height: width * 0.034,
                                                                                                                      color: Colors.grey[300],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                              Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  // ---
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.024,
                                                                                                                      height: width * 0.024,
                                                                                                                      color: Colors.grey[300],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.024,
                                                                                                                      height: width * 0.024,
                                                                                                                      color: Colors.grey[300],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                                                    child: Container(
                                                                                                                      width: width * 0.024,
                                                                                                                      height: width * 0.024,
                                                                                                                      color: Colors.grey[300],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : layout["nama"] == "Layout 8"
                                                                                                        ? Container(
                                                                                                            width: width * 0.084,
                                                                                                            height: width * 0.105,
                                                                                                            decoration: BoxDecoration(color: Colors.white),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsets.all(
                                                                                                                width * 0.0047,
                                                                                                              ),
                                                                                                              child: Row(
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  Column(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                    children: [
                                                                                                                      // ---
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(5.0),
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.024,
                                                                                                                          height: width * 0.024,
                                                                                                                          color: Colors.grey[300],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(5.0),
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.024,
                                                                                                                          height: width * 0.024,
                                                                                                                          color: Colors.grey[300],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(5.0),
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.024,
                                                                                                                          height: width * 0.024,
                                                                                                                          color: Colors.grey[300],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                  Column(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                    children: [
                                                                                                                      // ---
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.034,
                                                                                                                          height: width * 0.034,
                                                                                                                          color: Colors.grey[300],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      SizedBox(
                                                                                                                        height: 15,
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                                                        child: Container(
                                                                                                                          width: width * 0.034,
                                                                                                                          height: width * 0.034,
                                                                                                                          color: Colors.grey[300],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : layout["nama"] == "Layout 9"
                                                                                                            ? Container(
                                                                                                                width: width * 0.085,
                                                                                                                decoration: BoxDecoration(color: Colors.white),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsets.all(
                                                                                                                    width * 0.0092,
                                                                                                                  ),
                                                                                                                  child: Column(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                    children: [
                                                                                                                      Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                      Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                      Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                                                            child: Container(
                                                                                                                              width: width * 0.028,
                                                                                                                              height: width * 0.024,
                                                                                                                              color: Colors.grey[300],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              )
                                                                                                            : layout["nama"] == "Layout 10"
                                                                                                                ? Container(
                                                                                                                    width: width * 0.085,
                                                                                                                    decoration: BoxDecoration(color: Colors.white),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsets.all(
                                                                                                                        width * 0.0082,
                                                                                                                      ),
                                                                                                                      child: Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.028,
                                                                                                                                  height: width * 0.024,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : Container(
                                                                                                                    width: width * 0.085,
                                                                                                                    height: width * 0.105,
                                                                                                                    decoration: BoxDecoration(color: Colors.white),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsets.all(
                                                                                                                        width * 0.0037,
                                                                                                                      ),
                                                                                                                      child: Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                          Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsets.all(1.0),
                                                                                                                                child: Container(
                                                                                                                                  width: width * 0.02,
                                                                                                                                  height: width * 0.02,
                                                                                                                                  color: Colors.grey[300],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
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
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        foto_details != ""
                                            ? SizedBox(height: height * 0.05)
                                            : Container(),
                                        foto_details != ""
                                            ? Container(
                                                width: width * 0.25,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.01),
                                                  child: Text(
                                                    "Putar Gambar : ${_currentSliderValuePutarGambar.round()}",
                                                    style: TextStyle(
                                                      fontSize: width * 0.008,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        foto_details != ""
                                            ? Container(
                                                width: width * 0.25,
                                                child: Slider(
                                                  value:
                                                      _currentSliderValuePutarGambar,
                                                  min: -50,
                                                  max: 50,
                                                  divisions: 180,
                                                  label:
                                                      _currentSliderValuePutarGambar
                                                          .round()
                                                          .toString(),
                                                  onChanged: (double value) {
                                                    setState(() {
                                                      _currentSliderValuePutarGambar =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              )
                                            : Container(),
                                        foto_details != ""
                                            ? SizedBox(height: height * 0.02)
                                            : Container(),
                                        foto_details != ""
                                            ? Container(
                                                width: width * 0.25,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.01),
                                                  child: Text(
                                                    "Skala : ${_currentSliderValueSkalaGambar.toStringAsFixed(2)}%",
                                                    style: TextStyle(
                                                      fontSize: width * 0.008,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        foto_details != ""
                                            ? Container(
                                                width: width * 0.25,
                                                child: Slider(
                                                  value:
                                                      _currentSliderValueSkalaGambar,
                                                  min: minScale,
                                                  max: maxScale,
                                                  // divisions: 0.01,
                                                  label:
                                                      _currentSliderValueSkalaGambar
                                                          .round()
                                                          .toString(),
                                                  onChanged: (double newScale) {
                                                    //  setState(() {

                                                    //       size_image = 0;
                                                    // });
                                                    setState(() {
                                                      controller?.scale =
                                                          newScale;
                                                      _currentSliderValueSkalaGambar =
                                                          newScale;
                                                      // size_image = size_image + (newScale / 100);
                                                    });
                                                    // print("newScale / 100 : ${newScale/100}");
                                                  },
                                                ),
                                              )
                                            : Container(),
                                        foto_details != ""
                                            ? SizedBox(height: height * 0.1)
                                            : SizedBox(height: height * 0.04),
                                        foto_details != ""
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  OutlinedButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        foto_details = "";
                                                      });
                                                    },
                                                    child: Container(
                                                      // color: Colors.transparent,
                                                      width: width * 0.07,
                                                      // height: height * 0.012,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 15,
                                                          bottom: 15,
                                                        ),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Icon(
                                                                foto_details !=
                                                                        ""
                                                                    ? Icons
                                                                        .arrow_circle_left_outlined
                                                                    : Icons
                                                                        .edit,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        96,
                                                                        96,
                                                                        96),
                                                                size: width *
                                                                    0.015,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Batal",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.010,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          96,
                                                                          96,
                                                                          96),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  // simpan gambar button > functions ...
                                                  OutlinedButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),
                                                    ),
                                                    onPressed: () async {
                                                      print("simpan gambar");
                                                      saveEditImage();

                                                      print(
                                                          "foto_details : $foto_details");
                                                    },
                                                    child: Container(
                                                      // color: Colors.transparent,
                                                      width: width * 0.07,
                                                      // height: height * 0.012,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 15,
                                                          bottom: 15,
                                                        ),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Icon(
                                                                foto_details !=
                                                                        ""
                                                                    ? Icons
                                                                        .arrow_circle_right_outlined
                                                                    : Icons
                                                                        .edit,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        96,
                                                                        96,
                                                                        96),
                                                                size: width *
                                                                    0.015,
                                                              ),
                                                            ),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Simpan",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.010,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            96,
                                                                            96,
                                                                            96),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : OutlinedButton(
                                                style: TextButton.styleFrom(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                                onPressed: () async {
                                                  // ====================================
                                                  // .... Navigate To Background Page ...
                                                  // ===================================
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child: BackgroundWidget(
                                                          nama: nama,
                                                          title: title,
                                                          nama_filter:
                                                              nama_filter,
                                                          choose_layout: title
                                                                      .toString()
                                                                      .contains(
                                                                          "Collage D") ||
                                                                  title
                                                                      .toString()
                                                                      .contains(
                                                                          "Paket D")
                                                              ? choose2
                                                                  .toString()
                                                              : choose1
                                                                  .toString(),
                                                          choose_layout2: title
                                                                      .toString()
                                                                      .contains(
                                                                          "Collage D") ||
                                                                  title
                                                                      .toString()
                                                                      .contains(
                                                                          "Paket D")
                                                              ? choose1
                                                                  .toString()
                                                              : null,

                                                          // drag item untuk card data collage dragItemB2, dragItemB1
                                                          drag_item: title
                                                                  .toString()
                                                                  .contains(
                                                                      "Paket A")
                                                              ? dragItem
                                                              : title
                                                                      .toString()
                                                                      .contains(
                                                                          "Paket B")
                                                                  ? dragItemB
                                                                  : title
                                                                          .toString()
                                                                          .contains(
                                                                              "Paket C")
                                                                      ? dragItemC
                                                                      : null,
                                                          drag_item2: title
                                                                      .toString()
                                                                      .contains(
                                                                          "Collage D") ||
                                                                  title
                                                                      .toString()
                                                                      .contains(
                                                                          "Paket D")
                                                              ? dragItemB1
                                                              : null,
                                                          backgrounds:
                                                              backgrounds,
                                                        ),
                                                        inheritTheme: true,
                                                        ctx: context),
                                                  );
                                                  // ===============================
                                                  // -------------------------------
                                                  // ===============================
                                                },
                                                child: Container(
                                                  width: width * 0.17,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15,
                                                      bottom: 15,
                                                    ),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_circle_right_outlined,
                                                            color: Colors.white,
                                                            size: width * 0.015,
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Selanjutnya",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(height: height * 0.02),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // =======================
            // Positioned Layout Main
            // =======================
            // for (var layout in layouts)
            //   if (layout['status'] == 'Aktif')
            //     Positioned(
            //       top: 365,
            //       left: 785,
            //       child: Container(
            //         // ...
            //         width: int.parse(layout['lebar'].toString()).toDouble() -
            //             245.0,
            //         height: int.parse(layout['panjang'].toString()).toDouble() -
            //             245.0,
            //         color: Color.fromARGB(255, 238, 217, 191),
            //         child: Stack(
            //           children: [
            //             // ...
            //             Positioned(
            //               top: int.parse(layout['kotak1_top'].toString())
            //                   .toDouble()/
            // 1.5,
            //               left: int.parse(layout['kotak1_left'].toString())
            //                       .toDouble() -
            //                   15.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak1_width'].toString())
            //                         .toDouble() -
            //                     115.0,
            //                 height:
            //                     int.parse(layout['kotak1_height'].toString())
            //                             .toDouble() -
            //                         115.0,
            //                 // ...
            //               ),
            //             ),

            //             // ...
            //             Positioned(
            //               top: int.parse(layout['kotak2_top'].toString())
            //                   .toDouble()/
            // 1.5,
            //               left: int.parse(layout['kotak2_left'].toString())
            //                       .toDouble() -
            //                   120.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak2_width'].toString())
            //                         .toDouble() -
            //                     115.0,
            //                 height:
            //                     int.parse(layout['kotak2_height'].toString())
            //                             .toDouble() -
            //                         115.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak3_top'].toString())
            //                       .toDouble() -
            //                   95.0,
            //               left: int.parse(layout['kotak3_left'].toString())
            //                       .toDouble() -
            //                   120.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak3_width'].toString())
            //                         .toDouble() -
            //                     115.0,
            //                 height:
            //                     int.parse(layout['kotak3_height'].toString())
            //                             .toDouble() -
            //                         115.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak4_top'].toString())
            //                       .toDouble() -
            //                   95.0,
            //               left: int.parse(layout['kotak4_left'].toString())
            //                       .toDouble() -
            //                   15.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak4_width'].toString())
            //                         .toDouble() -
            //                     115.0,
            //                 height:
            //                     int.parse(layout['kotak4_height'].toString())
            //                             .toDouble() -
            //                         115.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak5_top'].toString())
            //                       .toDouble() -
            //                   215.0,
            //               left: int.parse(layout['kotak5_left'].toString())
            //                       .toDouble() -
            //                   15.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak5_width'].toString())
            //                         .toDouble() -
            //                     220.0,
            //                 height:
            //                     int.parse(layout['kotak5_height'].toString())
            //                             .toDouble() -
            //                         0.0,
            //                 // ...
            //               ),
            //             ),

            //             // ...
            //           ],
            //         ),
            //       ),
            //     ),

            // ============================
            // Positioned Layout Kecil Atas
            // ============================
            // for (var layout in layouts)
            //   if (layout['status'] == 'Aktif')
            //     Positioned(
            //       top: 170,
            //       left: 900,
            //       child: Container(
            //         // ...
            //         width: int.parse(layout['lebar'].toString()).toDouble() -
            //             470.0,
            //         height: int.parse(layout['panjang'].toString()).toDouble() -
            //             740.0,
            //         color: Color.fromARGB(255, 238, 217, 191),
            //         child: Stack(
            //           children: [
            //             // ...
            //             Positioned(
            //               top: int.parse(layout['kotak1_top'].toString())
            //                       .toDouble() -
            //                   35.0,
            //               left: int.parse(layout['kotak1_left'].toString())
            //                       .toDouble() -
            //                   35.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak1_width'].toString())
            //                         .toDouble() -
            //                     200.0,
            //                 height:
            //                     int.parse(layout['kotak1_height'].toString())
            //                             .toDouble() -
            //                         200.0,
            //                 // ...
            //               ),
            //             ),

            //             // ...
            //             Positioned(
            //               top: int.parse(layout['kotak2_top'].toString())
            //                       .toDouble() -
            //                   35.0,
            //               left: int.parse(layout['kotak2_left'].toString())
            //                       .toDouble() -
            //                   245.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak2_width'].toString())
            //                         .toDouble() -
            //                     200.0,
            //                 height:
            //                     int.parse(layout['kotak2_height'].toString())
            //                             .toDouble() -
            //                         200.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak3_top'].toString())
            //                       .toDouble() -
            //                   275.0,
            //               left: int.parse(layout['kotak3_left'].toString())
            //                       .toDouble() -
            //                   245.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak3_width'].toString())
            //                         .toDouble() -
            //                     200.0,
            //                 height:
            //                     int.parse(layout['kotak3_height'].toString())
            //                             .toDouble() -
            //                         200.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak4_top'].toString())
            //                       .toDouble() -
            //                   275.0,
            //               left: int.parse(layout['kotak4_left'].toString())
            //                       .toDouble() -
            //                   35.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak4_width'].toString())
            //                         .toDouble() -
            //                     200.0,
            //                 height:
            //                     int.parse(layout['kotak4_height'].toString())
            //                             .toDouble() -
            //                         200.0,
            //                 // ...
            //               ),
            //             ),

            //             Positioned(
            //               top: int.parse(layout['kotak5_top'].toString())
            //                       .toDouble() -
            //                   535.0,
            //               left: int.parse(layout['kotak5_left'].toString())
            //                       .toDouble() -
            //                   35.0,
            //               child: Container(
            //                 color: Color.fromARGB(255, 214, 160, 117),
            //                 width: int.parse(layout['kotak5_width'].toString())
            //                         .toDouble() -
            //                     410.0,
            //                 height:
            //                     int.parse(layout['kotak5_height'].toString())
            //                             .toDouble() -
            //                         125.0,
            //                 // ...
            //               ),
            //             ),

            //             // ...
            //           ],
            //         ),
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }
}
