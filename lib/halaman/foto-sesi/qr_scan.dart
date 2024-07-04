// ignore_for_file: unused_import, unused_field, unnecessary_null_comparison, override_on_non_overriding_member

import 'dart:convert';
import 'dart:typed_data';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fs_dart/halaman/foto-sesi/foto_sesi.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mysql1/mysql1.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:http/http.dart' as http;

import '../../src/database/db.dart';

class QrCodeScanSesiWidget extends StatefulWidget {
  const QrCodeScanSesiWidget({super.key});

  @override
  State<QrCodeScanSesiWidget> createState() => _QrCodeScanSesiWidgetState();
}

class _QrCodeScanSesiWidgetState extends State<QrCodeScanSesiWidget> {
  // ...
  final LocalStorage storage = new LocalStorage('parameters');
  Uint8List bytes = Uint8List(0);
  late TextEditingController _inputController;
  late TextEditingController _outputController;

  _QrCodeScanSesiWidgetState();

  var barcode_scan_string;
  var users;

  // variables localstorage
  var title;
  var deskripsi;

  int harga = 0;

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();

    // print("object");
    setState(() {
      barcode_scan_string = '';
    });

    print("object =======================");

    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();

    super.initState();
  }

  _clearStorage() async {
    await storage.clear();
  }

  _saveStorage() async {
    await storage.setItem('title', "Title parameter dari localstorage");
  }

  // ignore: unused_element
  final double barHeight = 10.0;

  bool isRunPostSesiMethods = false;

  var db = new Mysql();
  // colors wave
  
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

  // scan methods
  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = barcode;
      print("data scan : $barcode");
      if (barcode != null) {
        // request get users data
        setState(() {
          barcode_scan_string = barcode;
        });
        getUsers();
      } else {}
    }
  }

  getUsers() async {
    print("get users");
    db.getConnection().then(
      (value) {
        String sql = "select * from `user_fotos`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              users = row;
              // jumlahVoucher = count as int;
            });
            print('barcode_scan_string: ${barcode_scan_string}}');
            print('Name: ${users[1]}}');

            if (barcode_scan_string.toString().contains(users[1])) {
              // post sesi foto saat scan dan getuser functions
              _postSesiPhoto('buka', users[1], users[3]);

              print("data ada yang sama");
              setState(() {
                barcode_scan_string = '';
              });
              _outputController.clear();
              print("barcode_scan_string : $barcode_scan_string");
              print("_outputController : ${_outputController.text}");
            } else {
              print("data tidak sama");
            }
          } // Finally, close the connection
        });
        return value.close();
      },
    );
  }

  _postSesiPhoto(status, nama, title) async {
    // print("nama : $nama");
    // print("title : $title");
    // final conn = await MySqlConnection.connect(
    //   ConnectionSettings(
    //     host: '217.21.72.2',
    //     port: 3306,
    //     user: 'n1575196_foto_selfie_flutter',
    //     db: 'n1575196_foto_selfie_flutter',
    //     password: '%;Eq}m3Wjy{&',
    //   ),
    // ).whenComplete(
    //   () {
    //     print('connect datbase mysql online foto selfi rama');
    //   },
    // );
    // await conn.query(
    //     'update sesi_photo set status=?, nama=?, title=? where id=?',
    //     ['buka', nama, title, 1]);

    // // setState(() {
    // //   isRunPostSesiMethods = true;
    // // });

    // // test print debug
    // print("post buka sesi photo");
    // // Finally, close the connection
    // await conn.close();

    print("get sesi data");
    db.getConnection().then(
      (value) {
        // query update
        String sql = "UPDATE `sesi_photo` SET `status`='buka',`nama`='" +
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scan'),
          content: Text(
            'Scan QRCode yang anda dapatkan pada email\nLalu lakukan foto sesi setelahnya.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Scan'),
              onPressed: () {
                Navigator.of(context).pop();
                _scan().whenComplete(() {
                  print("output qr code : ${this._outputController.text}");
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Color.fromARGB(255, 224, 224, 224),
              height: width * 0.45,
              width: width * 1,
              child: WaveWidget(
                config: CustomConfig(
                  colors: _colors,
                  durations: _durations,
                  heightPercentages: _heightPercentages,
                ),
                backgroundColor: _backgroundColor,
                size: Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
            Container(
              // color: Color.fromARGB(255, 255, 123, 145),
              height: height * 0.55,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  elevation: 1,
                  color: Colors.pinkAccent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                    onTap: () {
                      print("scan qr code tap");
                      _dialogBuilder(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: width * 0.1,
                        bottom: width * 0.1,
                        left: width * 0.09,
                        right: width * 0.09,
                      ),
                      child: Text(
                        "Scan Qr Anda\nUntuk Ke Halaman\n Sesi Photo",
                        style: TextStyle(
                          fontSize: width * 0.06,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
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
