// ignore_for_file: unused_field, unused_local_variable, unused_import

import 'package:fs_dart/halaman/settings/edit_pages/add-background.dart';
import 'package:fs_dart/halaman/awal/halaman_awal.dart';
import 'package:fs_dart/halaman/settings/halaman_awal.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fs_dart/halaman/settings/menu.dart';
import 'package:fs_dart/halaman/settings/report.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:localstorage/localstorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fs_dart/src/database/db.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'add-filter.dart';
import 'add-sticker.dart';

// localstorage

class AddLayout extends StatefulWidget {
  const AddLayout({super.key});

  @override
  State<AddLayout> createState() => _AddLayoutState();
}

class _AddLayoutState extends State<AddLayout> {
  // ...
  final LocalStorage storage = LocalStorage('parameters');
  final double barHeight = 10.0;
  final _formKey = GlobalKey<FormState>();

  var bg_warna_main = "";
  var warna_1 = "";
  var warna_2 = "";
  var users;

  String filePick = "";
  String pin = "";
  String type = "";
  String server_key = "";
  String image = "";
  String bg_image = "";
  String judul = '';
  String deskripsi = '';

  _AddLayoutState();

  var db = new Mysql();

  var nama_layout = "";
  int top = 0;
  int bottom = 0;
  int left = 0;
  int right = 0;
  int _width = 0;
  int _height = 0;

  int _lebar = 0;

  double panjang_kanvas_get = 0;
  double lebar_kanvas_get = 0;

  // visible kotak boolean
  bool isKotak1 = false;
  bool isKotak2 = false;
  bool isKotak3 = false;
  bool isKotak4 = false;
  bool isKotak5 = false;
  bool isKotak6 = false;
  bool isKotak7 = false;
  bool isKotak8 = false;
  bool isKotak9 = false;
  bool isKotak10 = false;
  bool isLogo = false;

  bool isVisibleTambahLayoutKanvas = false;
  bool isVisibleLayoutKanvas = false;

  List<dynamic> kostumLayout = [];

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();
    getSettings();
    getUsers();
    getWarnaBg();
    getLayoutKustom();
    super.initState();
  }

  getLayoutKustom() async {
    var request = http.Request(
        'GET', Uri.parse('http://127.0.0.1:8000/api/custom-layout'));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // ...
      final result = jsonDecode(response.body) as List<dynamic>;
      kostumLayout.addAll(result);

      // ...
      for (var element in kostumLayout) {
        if (element["id"] == 6) {
          setState(() {
            panjang_kanvas_get = double.parse(element["panjang"].toString());
            lebar_kanvas_get = double.parse(element["lebar"].toString());
          });

          print("panjang_kanvas_get : $panjang_kanvas_get");
          print("lebar_kanvas_get : $lebar_kanvas_get");
        }
      }
      // ...
    } else {
      print(response.reasonPhrase);
    }
  }

  tambahKotak() async {
    // ...
  }

  simpanLayout() async {
    // ...
  }

  tambahLayoutKanvas(nama_layout) async {
    // ...
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/custom-layout'));
    request.fields.addAll({
      'nama': nama_layout,
      'kotak1': ' Photo',
      'kotak1_top': ' 1',
      'kotak1_bottom': ' 1',
      'kotak1_left': ' 1',
      'kotak1_right': ' 1',
      'kotak2': ' Photo',
      'kotak2_top': ' 1',
      'kotak2_bottom': ' 1',
      'kotak2_left': ' 1',
      'kotak2_right': ' 1',
      'kotak3': ' Photo',
      'kotak3_top': ' 1',
      'kotak3_bottom': ' 1',
      'kotak3_left': ' 1',
      'kotak3_right': ' 1',
      'kotak4': ' Photo',
      'kotak4_top': ' 1',
      'kotak4_bottom': ' 1',
      'kotak4_left': ' 1',
      'kotak4_right': ' 1',
      'kotak5': ' Photo',
      'kotak5_top': ' 1',
      'kotak5_bottom': ' 1',
      'kotak5_left': ' 1',
      'kotak5_right': ' 1',
      'kotak6': ' Photo',
      'kotak6_top': ' 1',
      'kotak6_bottom': ' 1',
      'kotak6_left': ' 1',
      'kotak6_right': ' 1',
      'kotak7': ' Photo',
      'kotak7_top': ' 1',
      'kotak7_bottom': ' 1',
      'kotak7_left': ' 1',
      'kotak7_right': ' 1',
      'kotak8': ' Photo',
      'kotak8_top': ' 1',
      'kotak8_bottom': ' 1',
      'kotak8_left': ' 1',
      'kotak8_right': ' 1',
      'kotak9': ' Photo',
      'kotak9_top': ' 1',
      'kotak9_bottom': ' 1',
      'kotak9_left': ' 1',
      'kotak9_right': ' 1',
      'kotak10': ' Photo',
      'kotak10_top': ' 1',
      'kotak10_bottom': ' 1',
      'kotak10_left': ' 1',
      'kotak10_right': ' 1',
      'logo': ' Logo',
      'logo_top': ' 1',
      'logo_bottom': ' 1',
      'logo_left': ' 1',
      'logo_right': ' 1',
      'panjang': _height.toString(),
      'lebar': _lebar.toString(),
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      setState(() {
        isVisibleTambahLayoutKanvas = !isVisibleTambahLayoutKanvas;
        isVisibleLayoutKanvas = !isVisibleLayoutKanvas;
        nama_layout = "";
        left = 0;
        right = 0;
        _width = 0;
        _height = 0;
        isKotak1 = !isKotak1;
      });
      _formKey.currentState!.reset();
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
              warna_1 = row[2];
              warna_2 = row[3];
            });
          } // Finally, close the connection
        }).then((value) {
          // ...
          // print("bg main color : $bg_warna_main");
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

  getSettings() async {
    db.getConnection().then(
      (value) {
        String sql = "select * from `settings`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              judul = row[1];
              deskripsi = row[2];
              bg_image = row[6];
            });
          } // Finally, close the connection
        }).then((value) => print(""));
        return value.close();
      },
    );
  }

  // update filter status
  _updateLayout(status, nama) async {
    db.getConnection().then(
      (value) {
        // query update "UPDATE filter SET status = 'aktif' WHERE nama = 'mute';"
        String sql =
            "UPDATE layout SET status = '$status' WHERE nama = '$nama';";
        value.query(sql).then((value) {
          print("berhasil update filter $nama status $status");
          _showMyDialog(nama, status);
        });
        return value.close();
      },
    );
  }

  // dialog update
  Future<void> _showMyDialog(nama, status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Filter'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Update Layout "$nama",\nStatus "$status".'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Baik'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var snackBar = SnackBar(
    content: Text('Data berhasil disimpan'),
  );

  _postSettings() async {
    print("object test post settings value");
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/settings'));
    request.fields
        .addAll({'pin': pin, 'type': "main", 'server_key': server_key});
    request.files.add(await http.MultipartFile.fromPath(
        'image', filePick.toString().replaceAll(r'\', r'/')));

    http.Response response =
        await http.Response.fromStream(await request.send());

    var jsonResponse;

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
        password: 'root4422',
      ),
    ).whenComplete(
      () {
        // ignore: avoid_print
        print('');
      },
    );
    // Query again database using a parameterized query
    var results2 = await conn.query('SELECT * FROM `user_fotos`');

    for (var row in results2) {
      setState(() {
        users = row;
      });
    }
  }

  _clearStorage() async {
    await storage.clear();
  }

  _saveStorage() async {
    await storage.setItem('title', "Title parameter dari localstorage");
  }

  Future<void> _dialogAddMenuEdit(
      BuildContext context, title, content, stage, pin) {
    // route animate on dialog

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 100,
          height: 100,
          color: Colors.transparent,
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: AlertDialog(
                backgroundColor: HexColor(bg_warna_main).withOpacity(0.95),
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
                              backgroundColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 55,
                                right: 55,
                              ),
                              child: Text(
                                'Filter'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      HexColor(bg_warna_main).withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
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
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: OutlinedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            backgroundColor: Colors.white,
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
                                style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      HexColor(bg_warna_main).withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: AddLayout(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
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
                              backgroundColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Background'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                color:
                                    HexColor(bg_warna_main).withOpacity(0.95),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: AddBackground(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
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
                              backgroundColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 55,
                                right: 55,
                              ),
                              child: Text(
                                'Sticker'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      HexColor(bg_warna_main).withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: AddSticker(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
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
                              backgroundColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 45,
                                right: 45,
                              ),
                              child: Text(
                                'Kembali'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      HexColor(bg_warna_main).withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              // isVisibleMainView = !isVisibleMainView;
                            });
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

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: bg_image != ""
            ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.ipv4_local}/storage/background-image/main/$bg_image"),
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.12,
                  width: width * 1,
                  decoration: BoxDecoration(
                    color: bg_warna_main != ""
                        ? HexColor(bg_warna_main).withOpacity(0.95)
                        : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: height * 1,
                        // ...
                        width: width * 0.82,
                        child: Padding(
                          padding: EdgeInsets.only(top: width * 0.001),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Layout",
                                style: TextStyle(
                                  fontSize: width * 0.0275,
                                  color: bg_warna_main != ""
                                      ? Colors.white
                                      : Colors.transparent,
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
                                      "Ke Settings Edit Photo ?",
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
                Visibility(
                  visible: !isVisibleTambahLayoutKanvas,
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.1),
                    width: width * 1,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ...

                          Container(
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // ...
                                        Padding(
                                          padding: EdgeInsets.only(
                                              // bottom: width * 0.01,
                                              // left: width * 0.02,
                                              ),
                                          child: SizedBox(
                                            // width: width * 0.1,
                                            child: Text(
                                              "Tambah Layout Kanvas",
                                              style: TextStyle(
                                                color: bg_warna_main != ""
                                                    ? HexColor(bg_warna_main)
                                                        .withOpacity(0.8)
                                                    : Colors.transparent,
                                                fontSize: width * 0.012,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: height * 0.025,
                                        ),

                                        // ==========
                                        // Nama Layout
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Nama',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Nama Layout",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    nama_layout =
                                                        value.toString();
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan nama layout';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    nama_layout =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ==========
                                        // Ukuran Panjang
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Panjang ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    _height = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan ukuran left';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    _height = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ==========
                                        // Ukuran Lebar
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Lebar ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    _lebar = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan ukuran Lebar';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    _lebar = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // =========
                                        // Tambah
                                        // =========
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: width * 0.02,
                                            left: width * 0.02,
                                          ),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 137, 62, 67),
                                              ),
                                              onPressed: () {
                                                // Simpan Layout Methods ...
                                                tambahLayoutKanvas(nama_layout);
                                                setState(() {
                                                  _lebar = 0;
                                                  _width = 0;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width * 0.025,
                                                  right: width * 0.025,
                                                  top: width * 0.005,
                                                  bottom: width * 0.005,
                                                ),
                                                child: const Text(
                                                  'Buat Layout',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
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
                  ),
                ),
                Visibility(
                  visible: isVisibleLayoutKanvas,
                  child: Container(
                    width: width * 1,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ...
                          Container(
                            width:
                                lebar_kanvas_get != 0 ? lebar_kanvas_get : 500,
                            height: panjang_kanvas_get != 0
                                ? panjang_kanvas_get
                                : 700,
                            color: bg_warna_main != ""
                                ? HexColor(bg_warna_main).withOpacity(0.8)
                                : Colors.transparent,
                          ),
                          Container(
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // ...
                                        Padding(
                                          padding: EdgeInsets.only(
                                              // bottom: width * 0.01,
                                              // left: width * 0.02,
                                              ),
                                          child: SizedBox(
                                            // width: width * 0.1,
                                            child: Text(
                                              "Tambah Photo Layout",
                                              style: TextStyle(
                                                color: bg_warna_main != ""
                                                    ? HexColor(bg_warna_main)
                                                        .withOpacity(0.8)
                                                    : Colors.transparent,
                                                fontSize: width * 0.012,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: height * 0.025,
                                        ),

                                        // ==========
                                        // Ukuran Top
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Top ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    top = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan ukuran top';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    top = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ==========
                                        // Ukuran Bottom
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Left ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    left = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan ukuran left';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    left = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ==========
                                        // Ukuran Left
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Width ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    _width = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan ukuran width';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    _width = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ==========
                                        // Ukuran Right
                                        // ==========
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01,
                                              left: width * 0.01),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Pixels',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 11,
                                                    top: 11,
                                                    right: 15,
                                                  ),
                                                  focusColor: bg_warna_main !=
                                                          ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  fillColor: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                          .withOpacity(0.8)
                                                      : Colors.transparent,
                                                  label: Text(
                                                    "Ukuran Height ( Pixels )",
                                                    style: TextStyle(
                                                      color: bg_warna_main != ""
                                                          ? HexColor(
                                                                  bg_warna_main)
                                                              .withOpacity(0.8)
                                                          : Colors.transparent,
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
                                                    // setstate value pin
                                                    _height = int.parse(
                                                        value.toString());
                                                  });
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'masukkan height';
                                                  }
                                                  return null;
                                                },

                                                onChanged: (value) {
                                                  setState(() {
                                                    _height = int.parse(
                                                        value.toString());
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // =========
                                        // Tambah
                                        // =========
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: width * 0.02,
                                            left: width * 0.02,
                                          ),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 36, 36, 36),
                                              ),
                                              onPressed: () {
                                                // Tambah Kotak Methods ...
                                                tambahKotak();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width * 0.025,
                                                  right: width * 0.025,
                                                  top: width * 0.005,
                                                  bottom: width * 0.005,
                                                ),
                                                child: const Text(
                                                  'Tambah Kotak',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // =========
                                        // Tambah
                                        // =========
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: width * 0.02,
                                            left: width * 0.02,
                                          ),
                                          child: SizedBox(
                                            width: width * 0.25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 137, 62, 67),
                                              ),
                                              onPressed: () {
                                                // Simpan Layout Methods ...
                                                simpanLayout();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width * 0.025,
                                                  right: width * 0.025,
                                                  top: width * 0.005,
                                                  bottom: width * 0.005,
                                                ),
                                                child: const Text(
                                                  'Simpan Layout',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
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
                  ),
                ),
              ],
            ),

            // =======
            // kotak 1
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak1,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 2
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak2,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 3
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak3,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 4
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak4,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 5
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak5,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 6
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak6,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 7
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak7,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 8
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak8,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 9
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak9,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // kotak 10
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isKotak10,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),

            // =======
            // logo 1
            // =======
            Positioned(
              top: 238 + top.toDouble(),
              left: 300 + left.toDouble(),
              child: Visibility(
                visible: isLogo,
                child: Container(
                  width: 10 + _width.toDouble(),
                  height: 10 + _height.toDouble(),
                  color: Color.fromARGB(255, 115, 68, 84),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// dialog layout
  Future<void> _dialogBuilderLayout(BuildContext context, nama) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Menambah Layout Ini?'),
          content: Text(
            'Apakah Anda Ingin, Menambah $nama Ini.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                _updateLayout("tidak aktif", nama);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Aktifkan'),
              onPressed: () {
                _updateLayout("aktif", nama);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
