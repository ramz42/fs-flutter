// ignore_for_file: unused_import, must_call_super, override_on_non_overriding_member

import 'package:fs_dart/halaman/order/konfirmasi_kedua.dart';
import 'package:flutter/material.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:fs_dart/konfigurasi/database/db.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../src/variables.g.dart';
import '../awal/halaman_awal.dart';
import 'pilih_pembayaran.dart';

class KonfirmasiKetiga extends StatefulWidget {
  const KonfirmasiKetiga({super.key});

  @override
  State<KonfirmasiKetiga> createState() => _KonfirmasiKetigaState();
}

class _KonfirmasiKetigaState extends State<KonfirmasiKetiga> {
  final LocalStorage storage = new LocalStorage('parameters');

  String title = "";
  String deskripsi = "";
  String nama_user = "";
  String no_telp = "";
  String email_user = "";
  String ig = "";
  int harga = 0;
  final double barHeight = 10.0;

  var db = new Mysql();

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

  @override
  void initState() {
    // TODO: implement initState
    // _saveStorage(title, deskripsi, nama, telp, email, ig, harga);
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    _getStorage();
    getOrderSettings();
  }

  String headerImg = "";
  String bgImg = "";
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

  _getStorage() async {
    if (await storage.ready) {
      setState(() {
        title = storage.getItem('judul') ?? "";
        deskripsi = storage.getItem('deskripsi') ?? "";
        harga = storage.getItem('harga') ?? "";

        nama_user = storage.getItem('nama') ?? "";
        no_telp = storage.getItem('telp') ?? "";
        email_user = storage.getItem('email') ?? "";
        ig = storage.getItem('ig') ?? "";
      });

      print("judul : $title");
      print("deskripsi : $deskripsi");
      print("harga : $harga");
      print("nama : $nama_user");
      print("telp : $no_telp");
      print("ig : $ig");
    } else {}

    print("nama user : $nama_user");
  }

  // end statements color waves

  @override
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
                "${Variables.ipv4_local}/storage/order/background-image/$bgImg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      children: [
                        Text(
                          "Order",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
                          "Review",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
                          "Payment",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: const Color.fromARGB(255, 49, 49, 49),
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
                      size: Size(double.infinity, double.infinity),
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
              height: width * 0.46,
              width: width * 1,
              child: Padding(
                padding: EdgeInsets.all(width * 0.018),
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
                  child: Container(
                    // color: Colors.black26,
                    width: width * 1,
                    height: width * 1,
                    child: SingleChildScrollView(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      // child: Container(
                      // width: width * 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // container

                          Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Terima Kasih",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Text(
                                      "Terima kasih telah berbelanja produk di selly time. bukti pembayaran Qr Code kami kirimkan melalui email yang sudah anda daftarkan, periksa folder spam atau junk pada email anda jika pada beberapa saat ini anda belum juga menerima email dari kami.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.015,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Text(
                                      "Follow Social media kami untuk mendapatkan info promo - promo terbaru. \n\n @IG - @FB - @Twitter \n\n `Tagline`",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.015,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: width * 0.03,
                          ),
                          Container(
                            // width: width * 1,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  // left: 25.0,
                                  width * 0.02),
                              child: Container(
                                // color: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: width * 0.025,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: OutlinedButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      onPressed: () {
                                        // do onpressed...
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => HalamanAwal(),
                                        //   ),
                                        // );
                                        // Navigator.of(context)
                                        //     .push(_routeAnimate(HalamanAwal()));

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => HalamanAwal(),
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
                                                  Icons
                                                      .arrow_circle_left_outlined,
                                                  color: const Color.fromARGB(
                                                      255, 96, 96, 96),
                                                  size: width * 0.025,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 45,
                                              ),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Kembali".toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: width * 0.016,
                                                      color: Color.fromARGB(
                                                          255, 96, 96, 96),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))
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

                          SizedBox(
                            height: width * 0.01,
                          ),
                        ],
                      ),
                      // ),r
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

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}