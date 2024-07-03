// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

import 'package:fs_dart/halaman/settings/halaman_awal.dart';
import 'package:fs_dart/halaman/settings/report.dart';
import 'package:fs_dart/halaman/settings/settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

import 'package:fs_dart/src/variables.g.dart';
// localstorage
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

import 'edit_pages/add-background.dart';
import 'edit_pages/add-filter.dart';
import 'edit_pages/add-layout.dart';
import 'edit_pages/add-sticker.dart';
import '../../src/database/db.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  // final CameraDescription camera;
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  // ...
  // final CameraDescription camera;
  final LocalStorage storage = LocalStorage('parameters');
  var db = new Mysql();

  var users;
  var filePick;

  String menu_title = "";
  String title = "";
  String deskripsi = "";
  String harga = "";
  String waktu = "";

  String bg_image = "";
  String judul = "";

  _MenuWidgetState();

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();
    getSettings();
    getUsers();
    super.initState();
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
              // pin = row[3];
              bg_image = row[6];
            });
          } // Finally, close the connection
        }).then((value) => print(""));
        return value.close();
      },
    );
  }

  _postMenusettings(type, id) async {
    print("object test post menu value");
    var request = http.MultipartRequest(
        type == "delete" ? 'DELETE' : 'POST',
        Uri.parse(type == "buat"
            ? '${Variables.ipv4_local}/api/menu-buat'
            : type == "update"
                ? '${Variables.ipv4_local}/api/menu-update'
                : '${Variables.ipv4_local}/api/menu-delete/$id'));

    type != "delete"
        ? request.fields.addAll({
            'menu_title': menu_title.toString(),
            'title': title,
            'deskripsi': deskripsi,
            'harga': harga.toString(),
            'waktu': waktu.toString(),
          })
        : null;

    type != "delete"
        ? request.files.add(
            await http.MultipartFile.fromPath(
              'image',
              filePick.toString().replaceAll(r'\', r'/'),
            ),
          )
        : null;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print(await response.bodyBytes);
      // Map<String, dynamic> data = jsonDecode(response.body);
      // print("object data $data");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: type == "buat"
              ? Text('Buat')
              : type == "update"
                  ? Text('Update')
                  : type == "delete"
                      ? Text('Delete')
                      : null,
          content: type == "buat"
              ? Text('Buat Menu Berhasil')
              : type == "update"
                  ? Text('Update Menu Berhasil')
                  : type == "delete"
                      ? Text('Delete Menu Berhasil')
                      : null,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Kembali'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Baik'),
            ),
          ],
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        filePick = file.path;
      });

      print("filePick path : $filePick");
    } else {
      // User canceled the picker
    }
  }

  getUsers() async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'foto_selfi',
        password: 'rama4422',

        // host: "217.21.72.2",
        // port: 3306,
        // user: 'n1575196_foto_selfie_flutter',
        // db: 'n1575196_foto_selfie_flutter',
        // password: '%;Eq}m3Wjy{&',
      ),
    ).whenComplete(
      () {
        // ignore: avoid_print
        print('');
      },
    );
    // // Query again database using a parameterized query
    var results2 = await conn.query('SELECT * FROM `user_fotos`');

    for (var row in results2) {
      setState(() {
        users = row;
        // jumlahVoucher = count as int;
      });
      // print('Name: ${users[0]}, email: ${users[1]} age: ${users[2]}');
    }
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

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bg2.jpeg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.12,
              width: width * 1,
              // color: const Color.fromARGB(255, 24, 116, 59),
              // tambah background image ...
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.ipv4_local}/storage/background-image/main/$bg_image"),
                  fit: BoxFit.cover,
                ),
              ),
              // end background image ...
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 1,
                    width: width * 0.9,
                    child: Padding(
                      padding: EdgeInsets.only(top: width * 0.001),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            judul.toUpperCase(),
                            style: TextStyle(
                              fontSize: width * 0.0275,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            deskripsi.toUpperCase(),
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
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              _dialogAddMenuEdit(
                                context,
                                "Menu",
                                "Apakah Anda Ingin Ke Menu\nSettings Edit Page ?",
                                1,
                                "",
                              );
                            },
                            child: const Icon(
                              Icons.add_box,
                              size: 55,
                              color: Colors.white,
                              semanticLabel: "Add",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const HalamanAwalSettings(),
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
                            child: const Icon(
                              Icons.power_settings_new,
                              size: 55,
                              color: Colors.white,
                              semanticLabel: "Logout",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              // color: Color.fromARGB(255, 255, 123, 145),
              height: width * 0.42,
              // color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // settings menu
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        elevation: 1,
                        color: Colors.blue[900],
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const SettingsWidget(
                            //         // camera: camera,
                            //         ),
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
                              left: width * 0.025,
                              right: width * 0.025,
                            ),
                            child: Text(
                              "Settings".toUpperCase(),
                              style: TextStyle(
                                fontSize: width * 0.02,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.034,
                      ),

                      // ...........
                      // menu atas
                      // ...........
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        elevation: 1,
                        color: Colors.blueGrey[900],
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => LockScreenFotoEditWidget(
                            //         // camera: camera,
                            //         ),
                            //   ),
                            // );
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
                              left: width * 0.04,
                              right: width * 0.04,
                            ),
                            child: Text(
                              "Menu".toUpperCase(),
                              style: TextStyle(
                                fontSize: width * 0.02,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.034,
                      ),

                      // report
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        elevation: 1,
                        color: Colors.blue[900],
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ReportWidget(
                            //         // camera: camera,
                            //         ),
                            //   ),
                            // );
                            // Navigator.of(context)
                            //     .push(_routeAnimate(ReportWidget()));
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ReportWidget(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
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
                              left: width * 0.03,
                              right: width * 0.03,
                            ),
                            child: Text(
                              "Report".toUpperCase(),
                              style: TextStyle(
                                fontSize: width * 0.02,
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

                  // form pin serverkey background
                  SizedBox(
                    height: width * 0.035,
                  ),
                  Container(
                    // color: Colors.transparent,
                    height: height * 0.5,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        // child: Container(
                        // height: height * 0.5,
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: width * 0.08,
                            // ),

                            // ............
                            // menu tambah
                            // ............
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.215,
                                top: width * 0.025,
                              ),
                              child: Container(
                                width: width * 1,
                                height: height * 0.485,
                                child: Form(
                                  key: _formKey,
                                  child: SizedBox(
                                    height: height * 0.325,
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: SingleChildScrollView(
                                        // physics: NeverScrollableScrollPhysics(),

                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // menu 1
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  "Menu Buat",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.012,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Menu Title',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Menu Title",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        menu_title =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Title',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Title",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        title =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Deskripsi',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Deskripsi",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        deskripsi =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Harga',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Harga",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        harga =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Timer',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Timer",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        waktu =
                                                            value.toString();
                                                      });

                                                      print(
                                                          "object waktu : $waktu");
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },

                                                    onChanged: (value) {
                                                      setState(() {
                                                        waktu =
                                                            value.toString();
                                                      });

                                                      print(
                                                          "object waktu : $waktu");
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: width * 0.01,
                                                left: width * 0.02,
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.35,
                                                    // height: 200,
                                                    // child: Row(
                                                    //   children: [
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: new OutlineInputBorder(
                                                              borderSide:
                                                                  new BorderSide(
                                                                      color: Colors
                                                                          .transparent)),
                                                          hintText: filePick
                                                              .toString(),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15,
                                                            bottom: 11,
                                                            top: 11,
                                                            right: 15,
                                                          ),
                                                          label: const Text(
                                                            "BACKGROUND IMAGE",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      53,
                                                                      53,
                                                                      53),
                                                            ),
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),

                                                        // The validator receives the text that the user has entered.
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter some text';
                                                          }
                                                          return filePick
                                                              .toString();
                                                          //
                                                        },
                                                      ),
                                                    ),

                                                    //   ],
                                                    // ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.15,
                                                    child: Card(
                                                      color: Colors.black,
                                                      child: InkWell(
                                                        onTap: () {
                                                          pickFile();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                            width * 0.0055,
                                                          ),
                                                          child: Icon(
                                                            Icons.image,
                                                            size: width * 0.014,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: width * 0.0035,
                                            // ),

                                            // button simpan
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: width * 0.02,
                                                left: width * 0.02,
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 36, 36, 36),
                                                ),
                                                onPressed: () {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    // _postSettings();
                                                  }
                                                  _postMenusettings("buat", "");
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * 0.025,
                                                    right: width * 0.025,
                                                    top: width * 0.005,
                                                    bottom: width * 0.005,
                                                  ),
                                                  child: Text(
                                                    'Buat'.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
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

                            SizedBox(
                              height: width * 0.035,
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.22,
                                right: width * 0.22,
                              ),
                              child: Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            // ............
                            // menu update
                            // ............
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.215,
                              ),
                              child: Container(
                                width: width * 1,
                                height: height * 0.485,
                                child: Form(
                                  key: _formKey1,
                                  child: SizedBox(
                                    height: height * 0.325,
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: SingleChildScrollView(
                                        // physics: NeverScrollableScrollPhysics(),

                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // menu 1
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  "Menu Update",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.012,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Menu Title',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Menu Title",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        menu_title =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Title',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Title",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        title =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Deskripsi',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Deskripsi",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        deskripsi =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Harga',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Harga",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        harga =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Timer',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Timer",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        waktu =
                                                            value.toString();
                                                      });

                                                      print(
                                                          "object waktu : $waktu");
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },

                                                    onChanged: (value) {
                                                      setState(() {
                                                        waktu =
                                                            value.toString();
                                                      });

                                                      print(
                                                          "object waktu : $waktu");
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.35,
                                                    // height: 200,
                                                    // child: Row(
                                                    //   children: [
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: new OutlineInputBorder(
                                                              borderSide:
                                                                  new BorderSide(
                                                                      color: Colors
                                                                          .transparent)),
                                                          hintText: filePick
                                                              .toString(),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15,
                                                            bottom: 11,
                                                            top: 11,
                                                            right: 15,
                                                          ),
                                                          label: const Text(
                                                            "BACKGROUND IMAGE",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      53,
                                                                      53,
                                                                      53),
                                                            ),
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),

                                                        // The validator receives the text that the user has entered.
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter some text';
                                                          }
                                                          return filePick
                                                              .toString();
                                                          //
                                                        },
                                                      ),
                                                    ),

                                                    //   ],
                                                    // ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.15,
                                                    child: Card(
                                                      color: Colors.black,
                                                      child: InkWell(
                                                        onTap: () {
                                                          pickFile();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                            width * 0.0055,
                                                          ),
                                                          child: Icon(
                                                            Icons.image,
                                                            size: width * 0.014,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: width * 0.012,
                                            // ),

                                            // button simpan
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: width * 0.02,
                                                left: width * 0.02,
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 36, 36, 36),
                                                ),
                                                onPressed: () {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  if (_formKey1.currentState!
                                                      .validate()) {
                                                    // ...
                                                  }
                                                  _postMenusettings(
                                                      "update", "");
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * 0.025,
                                                    right: width * 0.025,
                                                    top: width * 0.005,
                                                    bottom: width * 0.005,
                                                  ),
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
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

                            SizedBox(
                              height: width * 0.035,
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.22,
                                right: width * 0.22,
                              ),
                              child: Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            // ............
                            // menu delete
                            // ............
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.215,
                              ),
                              child: Container(
                                width: width * 1,
                                // height: height * 0.485,
                                child: Form(
                                  key: _formKey2,
                                  child: SizedBox(
                                    // height: height * 0.325,
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: SingleChildScrollView(
                                        // physics: NeverScrollableScrollPhysics(),

                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // menu 1
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  "Menu Delete",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.012,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.01,
                                                  left: width * 0.02),
                                              child: SizedBox(
                                                width: width * 0.5,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      hintText: 'Menu index',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15,
                                                        bottom: 11,
                                                        top: 11,
                                                        right: 15,
                                                      ),
                                                      focusColor: Colors.black,
                                                      fillColor: Colors.black,
                                                      label: Text(
                                                        "Menu Index",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 53, 53, 53),
                                                        ),
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    validator: (value) {
                                                      setState(() {
                                                        menu_title =
                                                            value.toString();
                                                      });
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // SizedBox(
                                            //   height: width * 0.012,
                                            // ),

                                            // button simpan
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: width * 0.02,
                                                left: width * 0.02,
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 36, 36, 36),
                                                ),
                                                onPressed: () {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  if (_formKey2.currentState!
                                                      .validate()) {
                                                    // ...
                                                  }
                                                  _postMenusettings(
                                                      "delete", menu_title);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * 0.025,
                                                    right: width * 0.025,
                                                    top: width * 0.005,
                                                    bottom: width * 0.005,
                                                  ),
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
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
                            SizedBox(
                              height: width * 0.035,
                            ),
                          ],
                        ),
                        // ),
                      ),
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
                    //     builder: (context) => const MenuWidget(),
                    //   ),
                    // );

                    _dialogPin(context);
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

Future<void> _dialogPin(BuildContext context) {
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
              child: SizedBox(
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
                        return s == '2222' ? null : 'Pin is incorrect';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) {
                        print(pin);
                        if (pin == '2222') {
                          Navigator.of(context).pop();
                        } else {}
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
                        //     builder: (context) => const MenuWidget(),
                        //   ),
                        // );
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

Future<void> _dialogAddMenuEdit(
    BuildContext context, title, content, stage, pin) {
  // route animate on dialog
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
                Column(
                  children: [
                    Center(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 55,
                              right: 55,
                            ),
                            child: Text(
                              'Filter'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddFilter(),
                          //   ),
                          // );
                          // Navigator.of(context)
                          //     .push(_routeAnimate(AddFilter()));
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: AddFilter(),
                                inheritTheme: true,
                                ctx: context),
                          );

                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 45,
                              right: 45,
                            ),
                            child: Text(
                              'Layout'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddLayout(),
                          //   ),
                          // );

                          // Navigator.of(context)
                          //     .push(_routeAnimate(AddLayout()));

                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: AddLayout(),
                                inheritTheme: true,
                                ctx: context),
                          );
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Background'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddBackground(),
                          //   ),
                          // );

                          // Navigator.of(context)
                          //     .push(_routeAnimate(AddBackground()));

                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: AddBackground(),
                                inheritTheme: true,
                                ctx: context),
                          );
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 55,
                              right: 55,
                            ),
                            child: Text(
                              'Sticker'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddSticker(),
                          //   ),
                          // );

                          // Navigator.of(context)
                          //     .push(_routeAnimate(AddSticker()));
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: AddSticker(),
                                inheritTheme: true,
                                ctx: context),
                          );
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 45,
                              right: 45,
                            ),
                            child: Text(
                              'Kembali'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                // OutlinedButton(
                //   style: TextButton.styleFrom(
                //     textStyle: Theme.of(context).textTheme.labelLarge,
                //     backgroundColor: Colors.orange,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Text(
                //       'Lanjut'.toUpperCase(),
                //       style: const TextStyle(
                //         fontSize: 30,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     // Navigator.of(context).pop();
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => const HalamanAwalSettings(),
                //     //   ),
                //     // );

                //     _dialogPin(context, pin);
                //   },
                // ),
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
