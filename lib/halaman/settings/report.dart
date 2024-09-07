// ignore_for_file: duplicate_import

import 'dart:io';

import 'package:fs_dart/halaman/settings/halaman_awal.dart';
import 'package:fs_dart/halaman/settings/menu.dart';
import 'package:fs_dart/halaman/settings/settings.dart';
import 'package:fs_dart/src/database/db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

// localstorage
import 'package:localstorage/localstorage.dart';
import 'package:fs_dart/src/variables.g.dart';

import '../awal/halaman_awal.dart';
import 'edit_pages/add-background.dart';
import 'edit_pages/add-filter.dart';
import 'edit_pages/add-layout.dart';
import 'edit_pages/add-sticker.dart';
import '../../src/database/db.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key, this.restorationId});

  final String? restorationId;
  // final CameraDescription camera;
  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> with RestorationMixin {
  // ...
  // final CameraDescription camera;
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2024, 1, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    filterUser(_selectedDate.value.month.toString(),
        _selectedDate.value.day.toString());
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}'),
        // ));
      });
    }
  }

  final LocalStorage storage = new LocalStorage('parameters');

  List<dynamic> users = [];
  var filePick;

  var db = new Mysql();
  int total_harga = 0;
  var bg_image = "";

  String judul = '';
  String deskripsi = '';

  bool isVisibleMainView = false;

  _ReportWidgetState();

  @override
  void initState() {
    // TODO: implement initState
    _saveStorage();
    _clearStorage();
    getSettings();
    getWarnaBg();
    getUsers();
    super.initState();
  }

  var bg_warna_main = "";

  getWarnaBg() async {
    // print("get sesi data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `main_color`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              bg_warna_main = row[1];
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
        password: 'rama4422',
      ),
    ).whenComplete(
      // ignore: avoid_print
      () => print('koneksi ke db'),
    );

    var results_filter = await conn.query(
        'SELECT * FROM `user_fotos` AS t1 WHERE NOT EXISTS ( SELECT * FROM `user_fotos` AS t2 WHERE t2.nama = t1.nama AND t2.id != t1.id );');

    setState(() {});

    users.addAll(results_filter);

    for (var element in users) {
      setState(() {
        total_harga = total_harga + int.parse(element['harga']);
      });
    }

    print("object total harga $total_harga");

    await conn.close();
  }

  filterUser(m, d) async {
    print("object filter user");
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'foto_selfi',
        password: 'rama4422',
      ),
    ).whenComplete(
      // ignore: avoid_print

      () {
        print('koneksi ke db');
        users.clear();
      },
    );

    var results_filter = await conn.query(
        'SELECT * FROM `user_fotos` WHERE `created_at` LIKE "%${m}-${d}%"');

    setState(() {});
    users.addAll(results_filter);

    // for (var element in users) {
    //   setState(() {
    //     total_harga = total_harga + int.parse(element['harga']);
    //   });
    // }

    print("object total harga $total_harga");

    await conn.close();
  }

  _clearStorage() async {
    await storage.clear();
  }

  _saveStorage() async {
    await storage.setItem('title', "Title parameter dari localstorage");
  }

  // dialog edit menu
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
            // color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: AlertDialog(
                backgroundColor:
                    const Color.fromARGB(255, 24, 116, 59).withOpacity(0.4),
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
                            backgroundColor: Colors.orange.withOpacity(0.4),
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
                            backgroundColor: Colors.orange.withOpacity(0.4),
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
                            backgroundColor: Colors.orange.withOpacity(0.4),
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
                            backgroundColor: Colors.orange.withOpacity(0.4),
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
                            backgroundColor: Colors.redAccent.withOpacity(0.4),
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
                            setState(() {
                              isVisibleMainView = !isVisibleMainView;
                            });
                            // ...
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

  final double barHeight = 10.0;

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
                "${Variables.ipv4_local}/storage/background-image/main/$bg_image"),
            fit: BoxFit.cover,
          ),
        ),
        child: Visibility(
          visible: !isVisibleMainView,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // tambah background image ...

                color: bg_warna_main != ""
                    ? Color(int.parse(bg_warna_main)).withOpacity(0.95)
                    : Colors.transparent,
                // end background image ...
                height: height * 0.12,
                width: width * 1,
                // color: const Color.fromARGB(255, 24, 116, 59),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                                setState(() {
                                  isVisibleMainView = !isVisibleMainView;
                                });
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
                                      child: HalamanAwal(
                                        backgrounds: null,
                                        header: null,
                                      ),
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
                height: height * 0.055,
              ),
              Container(
                // color: Color.fromARGB(255, 255, 123, 145),
                height: width * 0.43,
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
                          color:
                              Color.fromARGB(255, 77, 117, 70).withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
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
                          color:
                              Color.fromARGB(255, 77, 117, 70).withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
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
                          color:
                              Color.fromARGB(255, 77, 117, 70).withOpacity(0.9),
                          child: InkWell(
                            onTap: () {
                              // ...
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
                      height: height * 0.045,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.215,
                        right: width * 0.215,
                        bottom: width * 0.012,
                      ),
                      child: Container(
                        width: width * 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: Color.fromARGB(255, 77, 117, 70)
                                  .withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width * 0.28,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // width: width * 0.15,
                                        child: InkWell(
                                          onTap: () {
                                            _restorableDatePickerRouteFuture
                                                .present();

                                            users.clear();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.01),
                                              child: Text(
                                                'Tanggal : ${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.0095,
                                                  fontWeight: FontWeight.bold,
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
                            Card(
                              color: Color.fromARGB(255, 77, 117, 70)
                                  .withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width * 0.25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        // width: width * 0.1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0095,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Container(
                                        // width: width * 0.1,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.01),
                                          child: Text(
                                            "Rp. ${total_harga}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0095,
                                              fontWeight: FontWeight.bold,
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
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.215,
                        right: width * 0.215,
                      ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          child: Container(
                            color: Color.fromARGB(255, 77, 117, 70)
                                .withOpacity(0.9),
                            width: width * 1,
                            height: height * 0.44,
                            child: ListView(
                              children: [
                                Table(
                                  border: TableBorder.all(color: Colors.white),
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'No'.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width * 0.012,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Customer'.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width * 0.012,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Hp'.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width * 0.012,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Harga'.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width * 0.012,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                                    // for (int i = 0; i < 4; i++)

                                    if (users.isNotEmpty)
                                      // for (var user in users)
                                      for (int i = 0; i < users.length; i++)
                                        // if (!users[i]['nama'].toString().contains(
                                        //         users[i + 1]['nama'].toString()) &&
                                        //     i >= users.length)
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  (i + 1).toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  "${users[i]['nama']}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  "${users[i]['hp'].toString()}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  "${users[i]['harga']}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                  ],
                                ),
                              ],
                            ),
                            // height: height * 1,
                            // child: DataTable(
                            //     columns: DataColumn(label: Text("text")),
                            //     rows: DataRow(cells: [])),
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
                    //     builder: (context) => const ReportWidget(),
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
          height: 40,
          color: Colors.transparent,
          child: Card(
            color: Colors.transparent,
            // color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
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
                        //     builder: (context) => const ReportWidget(),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
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
