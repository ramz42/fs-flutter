// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:io';

import 'package:fs_dart/halaman/settings/edit_pages/add-background.dart';
import 'package:fs_dart/halaman/settings/edit_pages/add-layout.dart';
import 'package:fs_dart/halaman/settings/edit_pages/add-sticker.dart';
import 'package:fs_dart/halaman/settings/halaman_awal.dart';
import 'package:fs_dart/halaman/settings/menu.dart';
import 'package:fs_dart/halaman/settings/report.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:fs_dart/src/variables.g.dart';
import '../../src/database/db.dart';

// localstorage
import 'package:localstorage/localstorage.dart';

import 'edit_pages/add-filter.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  // final CameraDescription camera;
  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  //
  // final CameraDescription camera;
  final LocalStorage storage = LocalStorage('parameters');
  var db = new Mysql();

  var users;

  String filePick = "";

  String filePickHeader = "";
  String filePickBackground = "";

  String judul = "";
  String deskripsi = "";
  String pin = "";
  String bg_image = "";
  String type = "";
  String server_key = "";
  String image = "";

  String image_header = "";
  String image_background = "";
  _SettingsWidgetState();

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();
    getSettings();
    getUsers();
    super.initState();
  }

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

  var snackBar = const SnackBar(
    content: Text('Data berhasil disimpan'),
  );

  _postSettings() async {
    var jsonResponse;
    print("object test post settings value");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.ipv4_local}/api/settings'));
    request.fields.addAll({
      'judul': judul,
      'deskripsi': deskripsi,
      'pin': pin,
      'type': "main",
      'server_key': server_key
    });
    request.files.add(await http.MultipartFile.fromPath(
        'image', image.toString().replaceAll(r'\', r'/')));

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      // print(await response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(response.body);
      print("object data $data");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Update'),
          content: const Text('Update Settings Berhasil'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Kembali'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context, 'OK');
                Navigator.of(context).pop();
                getSettings(); // memanggil kembali fungsi get settings untuk refresh data dari database
              },
              child: const Text('Baik'),
            ),
          ],
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  _postOrder() async {
    var jsonResponse;
    print("object image_header : $filePickHeader");
    print("object image_background : $filePickBackground");

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.ipv4_local}/api/order'));

    request.fields.addAll({'title': 'order'});

    request.files.add(await http.MultipartFile.fromPath(
        'header_image', filePickHeader.toString().replaceAll(r'\', r'/')));

    request.files.add(await http.MultipartFile.fromPath('background_image',
        filePickBackground.toString().replaceAll(r'\', r'/')));

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // print(await response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(response.body);
      print("object data $data");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Update'),
          content: const Text('Update Order Halaman Berhasil'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Kembali'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context, 'OK');
                Navigator.of(context).pop();
                getSettings(); // memanggil kembali fungsi get settings untuk refresh data dari database
              },
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
      print("filePick : $filePick");
    } else {
      // User canceled the picker
    }
  }

  pickFileOrderHeader() async {
    print("pick file header order");
    FilePickerResult? result1 = await FilePicker.platform.pickFiles();

    if (result1 != null) {
      File fileHeader = File(result1.files.single.path!);
      setState(() {
        filePickHeader = fileHeader.path;
      });
      // print("filePick : $filePick");
    } else {
      // User canceled the picker
    }
  }

  pickFileOrderBg() async {
    print("pick file bg order");
    FilePickerResult? result2 = await FilePicker.platform.pickFiles();

    if (result2 != null) {
      File fileBackground = File(result2.files.single.path!);
      setState(() {
        filePickBackground = fileBackground.path;
      });
      // print("filePick : $filePick");
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

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    //
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
              // color: const Color.fromARGB(255, 24, 116, 59),
              // tambah background image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image != ""
                      ? "${Variables.ipv4_local}/storage/background-image/main/$bg_image"
                      : "${Variables.ipv4_local}/storage/background-image/main/$bg_image"),
                  fit: BoxFit.cover,
                ),
              ),
              // end background image

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 1,
                    width: width * 0.9,
                    child: Padding(
                      padding: EdgeInsets.only(top: width * 0.0),
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
                                  pin.toString());
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
              height: height * 0.1,
            ),
            SizedBox(
              // color: Color.fromARGB(255, 255, 123, 145),
              height: width * 0.36,
              child: Column(
                children: [
                  // menu primari
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
                        color: Colors.blueGrey[900],
                        child: InkWell(
                          onTap: () {},
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

                      // menu
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
                            //     builder: (context) => const MenuWidget(
                            //         // camera: camera,
                            //         ),
                            //   ),
                            // );

                            // Navigator.of(context)
                            //     .push(_routeAnimate(MenuWidget()));
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: MenuWidget(),
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

                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.215,
                    ),
                    child: Container(
                      width: width * 1,
                      height: height * 0.4,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            // height: height * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // label menu settings
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Text(
                                      "Konfigurasi Halaman Settings",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * 0.012,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // end label

                                // input menu settings
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                          hintText: 'Pin / Maksimal 4 Digit',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15,
                                          ),
                                          focusColor: Colors.black,
                                          fillColor: Colors.black,
                                          label: Text(
                                            "Pin",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 53, 53, 53),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          setState(() {
                                            // setstate value pin
                                            pin = value.toString();
                                          });
                                          if (value == null || value.isEmpty) {
                                            return 'masukkan pin baru';
                                          }

                                          print("object pin $pin");
                                          // if (value.length == 4 ||
                                          //     value.isNotEmpty) {
                                          //   return 'Maximum input digits';
                                          // }
                                          // return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                          hintText: 'masukkan server key',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15,
                                          ),
                                          label: Text(
                                            "Server Key",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 53, 53, 53),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          setState(() {
                                            server_key = value.toString();
                                          });
                                          if (value == null || value.isEmpty) {
                                            return 'masukkan server key';
                                          }
                                          print(
                                              "object server key $server_key");
                                          // return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Ganti Judul Header',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15,
                                          ),
                                          focusColor: Colors.black,
                                          fillColor: Colors.black,
                                          label: Text(
                                            "Judul Header",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),
                                          ),
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                        ),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 53, 53, 53),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          setState(() {
                                            judul = value.toString();
                                          });

                                          print("object judul : $judul");
                                          if (value == null || value.isEmpty) {
                                            return 'coba masukkan judul';
                                          }
                                          return null;
                                        },

                                        onChanged: (value) {
                                          setState(() {
                                            judul = value.toString();
                                          });

                                          print("object waktu : $judul");
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Ganti Deskripsi',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.only(
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
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                        ),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 53, 53, 53),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          setState(() {
                                            deskripsi = value.toString();
                                          });

                                          print("object judul : $deskripsi");
                                          if (value == null || value.isEmpty) {
                                            return 'coba masukkan judul';
                                          }
                                          return null;
                                        },

                                        onChanged: (value) {
                                          setState(() {
                                            deskripsi = value.toString();
                                          });

                                          // print("object waktu : $deskripsi");
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.35,
                                        // height: 200,
                                        // child: Row(
                                        //   children: [
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          color: Colors.white,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Ambil Gambar Background",
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 11,
                                                right: 15,
                                              ),
                                              label: Text(
                                                // ignore: unnecessary_null_comparison
                                                filePick.isNotEmpty
                                                    ? filePick.toString()
                                                    : "Background Image",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 53, 53, 53),
                                                ),
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                            ),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),

                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              // if (image.isEmpty) {
                                              //   return 'coba ambil gambar';
                                              // } else {
                                              setState(() {
                                                image = filePick.toString();
                                              });
                                            },
                                          ),
                                        ),
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
                                              padding: EdgeInsets.all(
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: width * 0.02,
                                    left: width * 0.02,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 36, 36, 36),
                                    ),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        _postSettings();
                                        // _postSettings();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.025,
                                        right: width * 0.025,
                                        top: width * 0.005,
                                        bottom: width * 0.005,
                                      ),
                                      child: const Text(
                                        'Konfigurasi Halaman Settings',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: height * 0.065,
                                ),
                                // label menu settings order
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Text(
                                      "Konfigurasi Halaman Order",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * 0.012,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // end label

                                //
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.35,
                                        // height: 200,
                                        // child: Row(
                                        //   children: [
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          color: Colors.white,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Ambil Gambar Header - Order",
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 11,
                                                right: 15,
                                              ),
                                              label: Text(
                                                // ignore: unnecessary_null_comparison
                                                filePickHeader.isNotEmpty
                                                    ? filePickHeader.toString()
                                                    : "Header Image Order",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 53, 53, 53),
                                                ),
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                            ),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),

                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              // if (image.isEmpty) {
                                              //   return 'coba ambil gambar';
                                              // } else {
                                              setState(() {
                                                image_header =
                                                    filePickHeader.toString();
                                              });
                                              // }
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
                                              pickFileOrderHeader();
                                              print("pick file header");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(
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

                                // ambil gambar background
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: width * 0.01, left: width * 0.02),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.35,
                                        // height: 200,
                                        // child: Row(
                                        //   children: [
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          color: Colors.white,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Ambil Gambar Background - Order",
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 11,
                                                right: 15,
                                              ),
                                              label: Text(
                                                // ignore: unnecessary_null_comparison
                                                filePickBackground.isNotEmpty
                                                    ? filePickBackground
                                                        .toString()
                                                    : "Background Image Order",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 53, 53, 53),
                                                ),
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                            ),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 53, 53),
                                            ),

                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              // if (image.isEmpty) {
                                              //   return 'coba ambil gambar';
                                              // } else {
                                              setState(() {
                                                image_background =
                                                    filePickBackground
                                                        .toString();
                                              });
                                              // }
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
                                              pickFileOrderBg();

                                              print("pick file bg order");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: width * 0.02,
                                    left: width * 0.02,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 36, 36, 36),
                                    ),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      // if (_formKey.currentState!.validate()) {
                                      // _postSettings();
                                      // _postSettings();
                                      _postOrder();
                                      // }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.025,
                                        right: width * 0.025,
                                        top: width * 0.005,
                                        bottom: width * 0.005,
                                      ),
                                      child: const Text(
                                        'Konfigurasi Halaman Order',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                            padding: const EdgeInsets.only(
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
                          // Navigator.of(context).pop();
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
                        },
                      ),
                    ),
                    const SizedBox(
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
                    const SizedBox(
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
                    const SizedBox(
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
                            padding: const EdgeInsets.only(
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
                    const SizedBox(
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