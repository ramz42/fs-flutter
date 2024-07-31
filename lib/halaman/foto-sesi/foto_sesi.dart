// ignore_for_file: unused_field, depend_on_referenced_packages, unnecessary_import, unused_local_variable, override_on_non_overriding_member

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:fs_dart/src/database/db.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Example app for Camera Windows plugin.
class FotoSesiWidget extends StatefulWidget {
  /// Default Constructor
  const FotoSesiWidget({
    super.key,
    required this.nama,
    required this.title,
    required this.waktu,
  });

  final nama;
  final title;
  final waktu;

  @override
  State<FotoSesiWidget> createState() =>
      _FotoSesiWidgetState(this.nama, this.title, this.waktu);
}

class _FotoSesiWidgetState extends State<FotoSesiWidget>
    with SingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();

  final nama;
  final title;
  final waktu;

  final double barHeight = 10.0;

  var db = new Mysql();
  var stores;
  var foto;

  late File image;
  late Timer _timer;
  late Timer _timerSnap;
  late Timer _timerLevelClock;
  late AnimationController _controller;

  Uint8List? _imageFile = null;
  bool isRunPostSesiMethods = false;

  int countTakePictures = 0;
  int _startLevelClock = 10;
  int lengthDataImages = 0;
  int levelClock = 0;
  int _startSnap = 5;
  int _start = 300;

  // colors wave
  static const _backgroundColor = Color.fromARGB(255, 196, 75, 146);

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

  String _cameraInfo = 'Unknown';
  List<CameraDescription> _cameras = <CameraDescription>[];

  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;
  bool _recording = false;
  bool _recordingTimed = false;
  bool _recordAudio = true;
  bool _previewPaused = false;
  Size? _previewSize;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  List<dynamic> background = [];

  String headerImg = "";
  String bgImg = "";

  List<dynamic> list = [];
  ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  _FotoSesiWidgetState(this.nama, this.title, this.waktu);

  @override
  void initState() {
    _getAllImages();
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras().then(
      (value) {
        _initializeCamera();
      },
    );
    setState(() {
      levelClock = int.parse(waktu.toString()) * 60;
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock,
      ), // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();
    _startTimerClock();
    countTakePicture();

    getWarnaBg();

    getOrderSettings();
  }

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

  postFotoSesi() async {
    db.getConnection().then(
      (value) {
        String sql = "UPDATE `sesi_photo` SET `status`='tutup',`nama`='" +
            nama +
            "',`title`='" +
            title +
            "' WHERE 1";
        value.query(sql).then((value) {
          print("berhasil update sesi foto");
        });
        return value.close();
      },
    );
  }

  // timer countdown photo
  Future<void> _timerPhotoSessions() async {
    // code...
  }

  // timer seconds photo after take-pictures
  Future<void> _timerAfterTakePicture() async {
    // code...
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startSnap == 0) {
          setState(() {
            timer.cancel();
            _startSnap = _startSnap + 5;
          });
        } else {
          setState(() {
            _startSnap = _startSnap - 1;
            // getSesiData();
          });
        }
      },
    );
  }

  Future<void> _startTimerClock() async {
    // code...
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

    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      levelClock--;
      if (levelClock == 0) {
        setState(() {
          timer.cancel();
        });

        dispose();
        _disposeCurrentCamera();

        // post sesi foto tutup
        postFotoSesi();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const LockScreenFotoSesiWidget(),
        //   ),
        // );
        Navigator.of(context).push(_routeAnimate(LockScreenFotoSesiWidget()));
      }
    });

    // const oneSec = const Duration(seconds: 1);
    // _timerLevelClock = new Timer.periodic(
    //   oneSec,
    //   (Timer timer) {
    //     if (levelClock == 0) {
    //       setState(() {
    //         timer.cancel();
    //       });

    //       dispose();
    //       _disposeCurrentCamera();

    //       // post sesi foto tutup
    //       postFotoSesi();

    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const LockScreenFotoSesiWidget(),
    //         ),
    //       );
    //     } else {
    //       setState(() {
    //         levelClock = levelClock - 1;
    //       });
    //     }
    //   },
    // );
  }

  // get images / all images from storage laravel with api get
  Future<void> _getAllImages() async {
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
      list.addAll(jsonDecode(response.body));
      stores = jsonDecode(response.body);
      print("response. length : ${stores.length}");
      setState(() {
        lengthDataImages = stores.length;
      });
      for (var i = 0; i < stores.length; i++) {
        print("object $i ${list[i]}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void startTimer() {
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

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          print("foto sesi habis");
          isRunPostSesiMethods == false
              ? {
                  _postSesiPhoto('tutup', "", "", 1),
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LockScreenFotoSesiWidget(
                  // nama: nama,
                  // title: title,
                  //         ),
                  //   ),
                  // ),
                  Navigator.of(context)
                      .push(_routeAnimate(LockScreenFotoSesiWidget(
//  nama: nama,
//                           title: title,
                          ))),
                  setState(() {
                    isRunPostSesiMethods == true;
                  }),
                  dispose(),
                  _disposeCurrentCamera(),
                }
              : null;
        } else {
          setState(() {
            _start = _start - 1;
          });

          print("timer : $_start");
        }
      },
    );
  }

  _postSesiPhoto(status, nama, title, int id) async {
    print("post sesi foto tutup");
    db.getConnection().then(
      (value) {
        // query update
        String sql =
            "UPDATE `sesi_photo` SET `status`='tutup',`nama`='',`title`='' WHERE 1";
        value.query(sql).then((value) {
          print("berhasil update sesi foto");
        });
        return value.close();
      },
    );
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameras = cameras;
        _cameraInfo = cameraInfo;
      });
    }
  }

  /// Initializes the camera on the device.
  Future<void> _initializeCamera() async {
    int cameraId = -1;

    assert(!_initialized);
    print("object $_initialized");

    if (_cameras.isEmpty) {
      print("cameras empty");
      return;
    }

    try {
      final int cameraIndex = _cameraIndex % _cameras.length;
      final CameraDescription camera = _cameras[cameraIndex];

      cameraId = await CameraPlatform.instance.createCamera(
        camera,
        _resolutionPreset,
        enableAudio: _recordAudio,
      );

      print("cameraIndex $cameraIndex");

      unawaited(_errorStreamSubscription?.cancel());
      _errorStreamSubscription = CameraPlatform.instance
          .onCameraError(cameraId)
          .listen(_onCameraError);

      unawaited(_cameraClosingStreamSubscription?.cancel());
      _cameraClosingStreamSubscription = CameraPlatform.instance
          .onCameraClosing(cameraId)
          .listen(_onCameraClosing);

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _initialized = true;
          _cameraId = cameraId;
          _cameraIndex = cameraIndex;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }
    } on CameraException catch (e) {
      try {
        if (cameraId >= 0) {
          await CameraPlatform.instance.dispose(cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;
          _recording = false;
          _recordingTimed = false;
          _cameraInfo =
              'Failed to initialize camera: ${e.code}: ${e.description}';
        });
      }
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
            _previewSize = null;
            _recording = false;
            _recordingTimed = false;
            _previewPaused = false;
            _cameraInfo = 'Camera disposed';
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          setState(() {
            _cameraInfo =
                'Failed to dispose camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Widget _buildPreview() {
    return Container(
      // width: 472,
      // height: 709,
      child: _startSnap != 5
          ? CameraPlatform.instance.buildPreview(_cameraId)
          : CameraPlatform.instance.buildPreview(_cameraId),
    );
  }

  Future<void> _takePicture() async {
    if (countTakePictures != 0) {
      _timerAfterTakePicture();
      final XFile file = await CameraPlatform.instance.takePicture(_cameraId);

      File files = File(file.path);

      list.clear();
      _uploadImage(file.path).whenComplete(() {
        _getAllImages().then((value) {});
      });
      setState(() {
        countTakePictures = countTakePictures - 1;
      });

      if (countTakePictures == 0) {
        startTimer();
      }
    } else {
      _showInSnackBar('Jumlah Shoot Habis');
      print("count take picture : ${countTakePictures}");
      startTimer();
    }
  }

  // upload image functions
  Future<void> _uploadImage(file) async {
    print("upload image");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.ipv4_local}/api/upload-image'));
    request.fields.addAll({
      'nama': "$nama-${DateTime.now().day}-${DateTime.now().hour}",
      'title_photobooth': title
    });
    request.files.add(await http.MultipartFile.fromPath('image', file));

    // ...
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  // delete image functions
  // ignore: unused_element
  Future<void> _deleteImage(filename) async {
    // code...
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/delete-image/'));
    request.fields.addAll({'filename': filename});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        // ...
        countTakePictures = countTakePictures + 1;
      });
      list.clear();
      _getAllImages().then((value) {});
      print("countTakePictures : $countTakePictures");
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.isNotEmpty) {
      // select next index;
      _cameraIndex = (_cameraIndex + 1) % _cameras.length;
      if (_initialized && _cameraId >= 0) {
        await _disposeCurrentCamera();
        await _fetchCameras();
        if (_cameras.isNotEmpty) {
          await _initializeCamera();
        }
      } else {
        await _fetchCameras();
      }
    }
  }

  Future<void> _onAudioChange(bool recordAudio) async {
    setState(() {
      _recordAudio = recordAudio;
    });
    if (_initialized && _cameraId >= 0) {
      // Re-inits camera with new record audio setting.
      await _disposeCurrentCamera();
      await _initializeCamera();
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${event.description}')));

      // Dispose camera on camera error as it can not be used anymore.
      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      _showInSnackBar('Camera is closing');
    }
  }

  void _showInSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void countTakePicture() async {
    if (title.toString().contains(" A") ||
        title.toString().contains(" a") ||
        title.toString().contains("collage a") ||
        title.toString().contains("Collage A") ||
        title.toString().contains("Strip A") ||
        title.toString().contains("Paket A")) {
      setState(() {
        countTakePictures = 8;
      });
      print("take picture 8x");
    } else {
      setState(() {
        countTakePictures = 16;
      });
      print("take picture 16x");
    }
  }

  Future<void> _dialogRetake(BuildContext context, filename, index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 100,
          height: 100,
          child: Card(
            // color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: AlertDialog(
                backgroundColor: const Color.fromARGB(255, 42, 193, 188),
                title: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 50),
                  child: Text(
                    "Retake Shoot",
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
                    "Foto ini ?",
                    style: const TextStyle(
                      fontSize: 46,
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
                      // ...
                      _deleteImage(filename);
                      Navigator.of(context).pop();
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<ResolutionPreset>> resolutionItems =
        ResolutionPreset.values
            .map<DropdownMenuItem<ResolutionPreset>>((ResolutionPreset value) {
      return DropdownMenuItem<ResolutionPreset>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();

    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        color: Color.fromARGB(218, 33, 33, 33),
        child: Stack(
          children: [
            // Positioned(
            // top: 150,
            // child:

            // ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ----------------
                  // header page view
                  // ----------------
                  Container(
                    height: height * 0.12,
                    width: width * 1,
                    child: Column(
                      children: [
                        Container(
                            height: width * 0.025,
                            width: width * 1,
                            color: Color(int.parse(bg_warna_main))),
                        Container(
                          height: height * 0.025,
                          width: width * 1,
                          child: WaveWidget(
                            config: CustomConfig(
                              colors: [
                                Color(int.parse(warna1)),
                                Color(int.parse(warna2))
                              ],
                              durations: _durations,
                              heightPercentages: _heightPercentages,
                            ),
                            backgroundColor: Color(int.parse(bg_warna_main)),
                            size: Size(double.infinity, double.infinity),
                            waveAmplitude: 0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 2,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: height * 0.875,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                25,
                              ),
                            ),
                          ),
                          elevation: 1,
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Variables.ipv4_local}/storage/order/background-image/$bgImg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: width * 1,
                            height: height * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    width: width * 0.17,
                                    height: height * 1,
                                    // child: SingleChildScrollView(
                                    //   scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   "Hasil Photo",
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: width * 0.02,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: list.length <= 8
                                        //       ? width * 0.08
                                        //       : width * 0.12,
                                        // ),
                                        // Column(
                                        //   children: [
                                        Container(
                                          width: width * 0.08,
                                          height: width * 0.08,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/chevron-arrow-up.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.17,
                                          height: width * 0.18,
                                          // color: Colors.green,
                                          child: Center(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                spacing: width * 0.01,
                                                runSpacing: width * 0.01,
                                                children: [
                                                  for (var i = 0;
                                                      i < list.length;
                                                      i++)
                                                    Container(
                                                      width: width * 0.08,
                                                      height: width * 0.08,
                                                      color: list[i] != null &&
                                                              list.isNotEmpty
                                                          ? Colors.transparent
                                                          : Colors.white,
                                                      child: Card(
                                                        elevation: 5,
                                                        child: InkWell(
                                                          onTap: () {
                                                            // ...
                                                            _dialogRetake(
                                                                context,
                                                                list[i],
                                                                i);
                                                            print(
                                                                "filename : ${list[i]}");
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: list[i] !=
                                                                        null &&
                                                                    list.isNotEmpty
                                                                ? Image.network(
                                                                    "${Variables.ipv4_local}/storage/" +
                                                                        list[i],
                                                                    scale: 1,
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.08,
                                          height: width * 0.08,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/chevron-arrow-down.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // ...
                                    // camera preview
                                    (_initialized &&
                                            _cameraId > 0 &&
                                            _previewSize != null)
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 1,
                                            ),
                                            child: Align(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25.0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            maxHeight: 670,
                                                            maxWidth: 1152,
                                                          ),
                                                          child: Container(
                                                            width: 1152,
                                                            height: 670,
                                                            color: Colors
                                                                .transparent,
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  1152 / 670,
                                                              child:
                                                                  _buildPreview(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: width * 0.5,
                                            height: width * 0.25,
                                            color: Colors.black,
                                          ),
                                  ],
                                ),
                                SizedBox(
                                    // width: width * 0.015,
                                    ),

                                // menu sebelah kanan
                                Container(
                                  width: width * 0.17,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20,
                                                left: 40,
                                                right: 40,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Waktu Shoot",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.012,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 31, 31, 31),
                                                    ),
                                                  ),
                                                  // count down widgewt here
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 15.0),
                                                    child: Countdown(
                                                      animation: StepTween(
                                                        begin:
                                                            levelClock, // THIS IS A USER ENTERED NUMBER
                                                        end: 0,
                                                      ).animate(_controller),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        countTakePictures != 0
                                            ? ElevatedButton(
                                                onPressed: _initialized
                                                    ? _takePicture
                                                    : null,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: Icon(
                                                    Icons.camera,
                                                    size: width * 0.04,
                                                    color: const Color.fromARGB(
                                                        255, 44, 44, 44),
                                                  ),
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    size: width * 0.04,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                      ],
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
                ],
              ),
            ),

            Visibility(
              visible: _startSnap != 5 ? true : false,
              child: Center(
                child: Container(
                  width: width * 1,
                  height: height * 1,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      _startSnap.toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.25),
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

// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print(
    //     'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: width * 0.03,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LockScreenFotoSesiWidget extends StatefulWidget {
  const LockScreenFotoSesiWidget({super.key});

  @override
  State<LockScreenFotoSesiWidget> createState() =>
      _LockScreenFotoSesiWidgetState();
}

class _LockScreenFotoSesiWidgetState extends State<LockScreenFotoSesiWidget> {
  final double barHeight = 10.0;

  // colors wave
  static const _backgroundColor = Color.fromARGB(255, 75, 196, 111);

  static const _colors = [
    Color.fromARGB(255, 111, 212, 142),
    Color.fromARGB(255, 175, 252, 198),
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
  var waktu;

  // ignore: unused_field
  late Timer _timer;
  var counter = 600;
  var voucher = "";

  var db = new Mysql();

  bool isNavigate = true;
  bool isVisibleTapCard = true;

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  List<dynamic> background = [];

  String headerImg = "";
  String bgImg = "";

  @override
  void initState() {
    // TODO: implement initState
    // timerPeriodFunc(); // timer periodic functions
    setState(() {
      isNavigate = true;
    });

    getOrderSettings();
    getWarnaBg();
    super.initState();
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FotoSesiWidget(
                      //       nama: nama,
                      //       title: title,
                      //       waktu: waktu,
                      //     ),
                      //   ),
                      // )
                      Navigator.of(context).push(_routeAnimate(FotoSesiWidget(
                        nama: nama,
                        title: title,
                        waktu: waktu,
                      ))),
                    }
                  : null;
            } else {
              // print("object : status foto edit belum 'buka'");
            }
          } // Finally, close the connection
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
              "berhasil update user $nama, voucher : $voucher, value : $value");
        });
        return value.close();
      },
    );
  }

  // getSettings() async {
  //     // print("get sesi data");
  //     db.getConnection().then(
  //       (value) {
  //         String sql = "select * from `settings`";
  //         value.query(sql).then((value) {
  //           for (var row in value) {
  //             setState(() {
  //               pin = row[1];
  //               bg_image = row[4];
  //             });
  //           } // Finally, close the connection
  //         }).then((value) => print("object pin : $pin"));
  //         return value.close();
  //       },
  //     );
  //   }

  _getUser(voucher) async {
    // SELECT * FROM `user_fotos` WHERE `voucher`= 'Mw-246-Afm7'
    db.getConnection().then(
      (value) {
        String sql = "SELECT * FROM `user_fotos` WHERE `voucher`= '$voucher';";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              nama = row[1];
              title = row[4];
              waktu = row[8];
            });
          }
        }).then((value) => {
              print("object nama : $nama"),
              print("object title : $title"),
              print("object waktu : $waktu"),
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FotoSesiWidget(
              //       nama: nama,
              //       title: title,
              //       waktu: waktu,
              //     ),
              //   ),
              // ),
              Navigator.of(context).push(_routeAnimate(FotoSesiWidget(
                nama: nama,
                title: title,
                waktu: waktu,
              ))),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
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
                                    fontWeight: FontWeight.bold,
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
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
                                    fontWeight: FontWeight.bold,
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
                            _getUser(voucher);
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

  @override
  Widget build(BuildContext context) {
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
            AnimatedOpacity(
              opacity: isVisibleTapCard == true ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
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
                          top: width * 0.02,
                          bottom: width * 0.02,
                          left: width * 0.2,
                          right: width * 0.2,
                        ),
                        child: Text(
                          "Scan Qr \n\or\n Tap Voucher",
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
