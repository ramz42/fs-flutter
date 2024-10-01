// ignore_for_file: sized_box_for_whitespace, override_on_non_overriding_member, avoid_unnecessary_containers, unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fs_dart/halaman/order/review.dart';
import 'package:localstorage/localstorage.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../src/database/db.dart';
import '../awal/halaman_awal.dart';
import 'dart:io';

class OrderWidget extends StatefulWidget {
  OrderWidget({
    super.key,
    required this.backgrounds,
  });

  final backgrounds;

  @override
  State<OrderWidget> createState() => _OrderWidgetState(
        this.backgrounds,
      );
}

class _OrderWidgetState extends State<OrderWidget> {
  _OrderWidgetState(this.backgrounds);
  // ...
  final backgrounds;
  var db = new Mysql();
  // ...
  final LocalStorage storage = new LocalStorage('parameters');

  // variables card order
  String headerImg = "";
  String bgImg = "";
  int harga = 0;
  String waktu = "";

  // ...
  String nama_user = "";
  int no_telp = 0;
  String email_user = "";
  int lengthMenu = 0;
  String ig = "";

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";
  var menu;

  @override
  void initState() {
    getMenuOrder();
    getWarnaBg();
    getOrderSettings();

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

  // ...
  getOrderSettings() async {
    // print("get sesi data");
    db.getConnection().then(
      (value) {
        String sql = "select * from `halaman_order`";
        value.query(sql).then((value) {
          for (var row in value) {
            setState(() {
              headerImg = row[2];
              bgImg = row[3];
            });
          } // Finally, close the connection
        }).then((value) => print("object pin : $headerImg"));
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

  getMenuOrder() async {
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
    var results2 = await conn.query('SELECT * FROM `menu_settings`');

    setState(() {
      menu = results2;
    });
  }

  _saveStorage(judul, deskripsi, harga, waktu) async {
    if (await storage.ready) {
      await storage.setItem('judul', judul).whenComplete(
        () {
          // ignore: avoid_print
          print('judul set');
        },
      );
      await storage.setItem('deskripsi', deskripsi).whenComplete(
        () {
          // ignore: avoid_print
          print('desk set');
        },
      );
      await storage.setItem('harga', harga).whenComplete(
        () {
          // ignore: avoid_print
          print('harga set');
        },
      );
      await storage.setItem('waktu', waktu).whenComplete(
        () {
          // ignore: avoid_print
          print('waktu set');
        },
      );
    } else {}
  }

  // variables wave widget animations ===
  final double barHeight = 10.0;

  // colors wave

  static const _durations = [
    10000,
    75000,
  ];

  static const _heightPercentages = [
    0.90,
    0.70,
  ];
  // end statements color waves

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  @override
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: bgImg != "" && backgrounds != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(bgImg == ""
                      ? "${Variables.ipv4_local}/storage/order/background-image/$backgrounds"
                      : "${Variables.ipv4_local}/storage/order/background-image/$bgImg"),
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------
            // header page view
            // ----------------
            Container(
              height: height * 0.12,
              width: width * 1,
              decoration: BoxDecoration(
                color: warna1 != "" ? HexColor(warna1) : Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    height: width * 0.025,
                    width: width * 1,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: width * 0.025,
                    width: width * 1,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ...
                      // header halaman order
                      // ...
                      children: [
                        Text(
                          "Order",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Review",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Payment",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------------------
            // end header page view
            // ---------------------

            Container(
              color: Colors.transparent,
              height: height * 0.87,
              width: width * 1,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
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
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ...
                        Center(
                          child: Container(
                            width: width * 1,
                            height: height * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: width * 0.045,
                                    height: width * 0.045,
                                    child: ShaderMask(
                                      child: Image(
                                        image: AssetImage(
                                          "assets/icons/left-arrow.png",
                                        ),
                                      ),
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 255, 255),
                                            Color.fromARGB(255, 255, 255, 255),
                                          ],
                                          stops: [
                                            0.0,
                                            0.5,
                                          ],
                                        ).createShader(bounds);
                                      },
                                      blendMode: BlendMode.srcATop,
                                    )),
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: width * 0.85,
                                  height: height * 0.8,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: width * 0.025,
                                        runSpacing: width * 0.15,
                                        children: [
                                          if (menu != null)
                                            for (var item in menu)
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  border: Border.all(
                                                      width: 10,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                  color: bg_warna_main != ""
                                                      ? HexColor(bg_warna_main)
                                                      : Colors.transparent,
                                                ),
                                                width: width * 0.14,
                                                height: height * 0.4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Card(
                                                    color:
                                                        HexColor(bg_warna_main),
                                                    child: InkWell(
                                                      onTap: () {
                                                        print(
                                                            "object : ${item["title"].toString()}");
                                                        print(
                                                            "object : ${item["deskripsi"].toString()}");
                                                        print(
                                                            "object : ${item["harga"].toString()}");
                                                        print(
                                                            "object : ${item["waktu"].toString()}");
                                                        _saveStorage(
                                                          item["title"]
                                                              .toString(),
                                                          item["deskripsi"]
                                                              .toString(),
                                                          item["harga"]
                                                              .toString(),
                                                          item["waktu"]
                                                              .toString(),
                                                        );
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  ReviewPaymentWidget(
                                                                backgrounds:
                                                                    backgrounds,
                                                              ),
                                                              inheritTheme:
                                                                  true,
                                                              ctx: context),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              height:
                                                                  height * 0.2,
                                                              width: width * 1,
                                                              child: Card(
                                                                child: Image(
                                                                  height:
                                                                      height *
                                                                          1,
                                                                  width:
                                                                      width * 1,
                                                                  image:
                                                                      NetworkImage(
                                                                    "${Variables.ipv4_local}/storage/background-image/sub/${item["image"]}",
                                                                    scale: 1,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  item["title"]
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.012,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.015,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .fileText,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.007,
                                                                ),
                                                                Text(
                                                                  item[
                                                                      "deskripsi"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.008,
                                                                    color: Colors
                                                                        .white,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.015,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .rupiahSign,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.007,
                                                                ),
                                                                Text(
                                                                  "Harga : Rp. ${item["harga"]},-"
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.008,
                                                                    color: Colors
                                                                        .white,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.015,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .clock,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.007,
                                                                ),
                                                                Text(
                                                                  "Waktu Sesi : ${item["waktu"]} Menit"
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.008,
                                                                    color: Colors
                                                                        .white,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
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
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: width * 0.045,
                                  height: width * 0.045,
                                  child: ShaderMask(
                                    child: Image(
                                      image: AssetImage(
                                        "assets/icons/right-arrow.png",
                                      ),
                                    ),
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 255, 255, 255),
                                          Color.fromARGB(255, 255, 255, 255),
                                        ],
                                        stops: [
                                          0.0,
                                          0.5,
                                        ],
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.srcATop,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width * 0.064,
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
                                // do onpressed...
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const HalamanAwal(),
                                //   ),
                                // );
                                // Navigator.of(context)
                                //     .push(_routeAnimate(HalamanAwal()));

                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: HalamanAwal(
                                        backgrounds:
                                            "1719751112-background.jpg",
                                        header: "1719751264-header.jpg",
                                      ),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: Container(
                                // color: Colors.transparent,
                                width: width * 0.15,
                                // height: height * 0.012,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: FaIcon(
                                          FontAwesomeIcons.caretLeft,
                                          color: const Color.fromARGB(
                                              255, 96, 96, 96),
                                          size: width * 0.025,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 45,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Kembali".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width * 0.016,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
