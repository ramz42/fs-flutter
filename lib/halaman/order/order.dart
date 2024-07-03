// ignore_for_file: sized_box_for_whitespace, override_on_non_overriding_member, avoid_unnecessary_containers, unused_import

import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_dart/halaman/order/review.dart';
import 'package:localstorage/localstorage.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:mysql1/mysql1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../src/database/db.dart';
import '../awal/halaman_awal.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // ...

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
  String ig = "";

  var menu;
  int lengthMenu = 0;

  @override
  void initState() {
    getMenuOrder();
    getOrderSettings();
    super.initState();
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
  // end statements color waves ===

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  @override
  Widget build(BuildContext context) {
    // ...
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------
            // header page view
            // ----------------
            Container(
              height: height * 0.12,
              width: width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.ipv4_local}/storage/order/header-image/$headerImg"),
                  fit: BoxFit.cover,
                ),
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
                            color: const Color.fromARGB(255, 49, 49, 49),
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
                  Container(
                    height: height * 0.025,
                    width: width * 1,
                    child: WaveWidget(
                      config: CustomConfig(
                        colors: _colors,
                        durations: _durations,
                        heightPercentages: _heightPercentages,
                      ),
                      backgroundColor: Colors.transparent,
                      size: const Size(double.infinity, double.infinity),
                      waveAmplitude: 0,
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
              height: height * 0.85,
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
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/left-arrow.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: width * 0.775,
                                  height: height * 0.8,
                                  // color: Colors.green,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        // verticalDirection: VerticalDirection.,
                                        // hor
                                        spacing: width * 0.01,
                                        runSpacing: width * 0.15,
                                        children: [
                                          if (menu != null)
                                            for (var item in menu)
                                              Container(
                                                width: width * 0.25,
                                                height: height * 0.75,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Card(
                                                    color: Color.fromARGB(
                                                        255, 57, 93, 68),
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
                                                                  ReviewPaymentWidget(),
                                                              inheritTheme:
                                                                  true,
                                                              ctx: context),
                                                        );
                                                        // Navigator.of(context)
                                                        //     .push(_routeAnimate(
                                                        //         ReviewPaymentWidget()));

                                                        //                                       Navigator.push(
                                                        //   context,
                                                        //   PageTransition(
                                                        //       type: PageTransitionType.fade,
                                                        //       child: OrderWidget(),
                                                        //       inheritTheme: true,
                                                        //       ctx: context),
                                                        // );
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Column(
                                                            children: [
                                                              Card(
                                                                child: Image(
                                                                  image:
                                                                      NetworkImage(
                                                                    "${Variables.ipv4_local}/storage/background-image/sub/${item["image"]}",
                                                                    scale: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                item["title"]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.02,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                item[
                                                                    "deskripsi"],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.014,
                                                                  color: Colors
                                                                      .white,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Harga : Rp. ${item["harga"]},-"
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.014,
                                                                  color: Colors
                                                                      .white,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Waktu Sesi : ${item["waktu"]} Menit"
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.014,
                                                                  color: Colors
                                                                      .white,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
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
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/right-arrow.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width * 0.035,
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
                                      child: HalamanAwal(),
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
                                        child: Icon(
                                          Icons.arrow_circle_left_outlined,
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
