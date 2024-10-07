// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:ui';

import 'package:fs_dart/halaman/settings/halaman_awal.dart';
// localstorage
import 'package:localstorage/localstorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:fs_dart/src/variables.g.dart';

import '../../../src/database/db.dart';
import '../../awal/halaman_awal.dart';
import 'add-background.dart';
import 'add-layout.dart';
import 'add-sticker.dart';
import 'dart:convert';
import 'dart:io';

class AddFilter extends StatefulWidget {
  const AddFilter({super.key});

  // final CameraDescription camera;
  @override
  State<AddFilter> createState() => _AddFilterState();
}

class _AddFilterState extends State<AddFilter> {
  // ...
  // final CameraDescription camera;
  final LocalStorage storage = LocalStorage('parameters');

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

  var db = new Mysql();

  _AddFilterState();

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();
    getSettings();
    getUsers();
    getWarnaBg();
    super.initState();
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
          print("bg main color : $bg_warna_main");
        });
        return value.close();
      },
    );
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
              // pin = row[3];
              bg_image = row[6];
            });
          } // Finally, close the connection
        }).then((value) => print(""));
        return value.close();
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

  // update filter status
  _updateFilter(status, nama) async {
    db.getConnection().then(
      (value) {
        // query update "UPDATE filter SET status = 'aktif' WHERE nama = 'mute';"
        String sql =
            "UPDATE filter SET status = '$status' WHERE nama = '$nama';";
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
                Text('Update Filter "$nama",\nStatus "$status".'),
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
        print('');
      },
    );
    var results2 = await conn.query('SELECT * FROM `user_fotos`');

    for (var row in results2) {
      setState(() {
        users = row;
        // jumlahVoucher = count as int;
      });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.12,
              width: width * 1,
              color: bg_warna_main != ""
                  ? HexColor(bg_warna_main).withOpacity(0.95)
                  : Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 1,
                    width: width * 0.82,
                    child: Padding(
                      padding: EdgeInsets.only(top: width * 0.001),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: width * 0.0275,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Text(
                          //   deskripsi.toUpperCase(),
                          //   style: TextStyle(
                          //     fontSize: width * 0.01,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
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
              height: height * 0.27,
            ),
            Container(
              // height: height * 0.4,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // filter 1
                  InkWell(
                    onTap: () {
                      _dialogBuilderFilter(context, "black white blur");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.0045),
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.15,
                              height: height * 0.25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/man.jpg",
                                    ),
                                    colorFilter: ColorFilter.mode(
                                      Color.fromARGB(255, 255, 255, 255),
                                      BlendMode.modulate,
                                    ),
                                    fit: BoxFit.contain),
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
                                      ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(94, 255, 255, 255)
                                            .withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.007,
                            ),
                            Text(
                              "Black White Blur",
                              style: TextStyle(
                                fontSize: width * 0.01,
                                color: const Color.fromARGB(255, 102, 102, 102),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // filter 2
                  InkWell(
                    onTap: () {
                      _dialogBuilderFilter(context, "mute");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.0045),
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.15,
                              height: height * 0.25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/man.jpg",
                                    ),
                                    colorFilter: ColorFilter.mode(
                                      Color.fromARGB(255, 255, 255, 255),
                                      BlendMode.modulate,
                                    ),
                                    fit: BoxFit.contain),
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
                                      ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(94, 255, 255, 255)
                                            .withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.007,
                            ),
                            Text(
                              "Mute",
                              style: TextStyle(
                                fontSize: width * 0.01,
                                color: const Color.fromARGB(255, 102, 102, 102),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // filter 3
                  InkWell(
                    onTap: () {
                      _dialogBuilderFilter(context, "webcore");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.0045),
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.15,
                              height: height * 0.25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/man.jpg",
                                    ),
                                    colorFilter: ColorFilter.mode(
                                      Color.fromARGB(255, 255, 255, 255),
                                      BlendMode.modulate,
                                    ),
                                    fit: BoxFit.contain),
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
                                      ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(94, 255, 255, 255)
                                            .withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.007,
                            ),
                            Text(
                              "Webcore",
                              style: TextStyle(
                                fontSize: width * 0.01,
                                color: const Color.fromARGB(255, 102, 102, 102),
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
          ],
        ),
      ),
    );
  }

  // dialog filter
  Future<void> _dialogBuilderFilter(BuildContext context, nama_filter) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Menambah Filter Ini?'),
          content: Text(
            'Apakah Anda Ingin, Menambah Filter "$nama_filter" Ini.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                _updateFilter("tidak aktif", nama_filter);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Aktifkan'),
              onPressed: () {
                _updateFilter("aktif", nama_filter);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> _dialogAddMenuEdit(
    BuildContext context, title, content, stage, pin) {
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
                //     //     builder: (context) => const HomeAddFilter(),
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
