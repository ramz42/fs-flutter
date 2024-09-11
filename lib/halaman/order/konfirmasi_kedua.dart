// ignore_for_file: unused_field, unused_local_variable, duplicate_ignore, override_on_non_overriding_member, must_be_immutable, unused_import

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../src/variables.g.dart';
import '../awal/halaman_awal.dart';
import 'konfirmasi_ketiga.dart';
import 'package:http/http.dart' as http;
import 'pilih_pembayaran.dart';
import '../../../src/database/db.dart';

class KonfirmasiKedua extends StatefulWidget {
  const KonfirmasiKedua({
    super.key,
    required this.qris_content,
    required this.qris_request_date,
    required this.qris_invoiceid,
    required this.jenis_pembayaran,
    required this.backgrounds,
  });

  final qris_content;
  final qris_request_date;
  final qris_invoiceid;
  final jenis_pembayaran;
  final backgrounds;

  @override
  State<KonfirmasiKedua> createState() => _KonfirmasiKeduaState(
        qris_content,
        qris_request_date,
        qris_invoiceid,
        jenis_pembayaran,
        backgrounds,
      );
}

class _KonfirmasiKeduaState extends State<KonfirmasiKedua>
    with SingleTickerProviderStateMixin {
  _KonfirmasiKeduaState(this.qris_content, this.qris_request_date,
      this.qris_invoiceid, this.jenis_pembayaran, this.backgrounds);

  final LocalStorage storage = new LocalStorage('parameters');
  final double barHeight = 10.0;

  final backgrounds;
  final qris_content;
  final qris_request_date;
  final qris_invoiceid;
  final jenis_pembayaran;

  late AnimationController _controller;

  String title = "";
  String deskripsi = "";
  String nama_user = "";
  String no_telp = "";
  String email_user = "";
  String ig = "";
  int harga = 0;
  String waktu = "";

  String nama_bank = "";
  String virtual_account = "";

  String headerImg = "";
  String bgImg = "";

  int _counter = 0;
  int levelClock = 600;

  var db = new Mysql();
  var random_string = "";
  var id_foto = "";
  var status_transaksi = "";
  var jenis_transaksi = "";

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

  // kode voucher ...
  var kode_voucher = '';

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

    // get localstorage
    _getStorage();
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock,
      ), // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();
    if (levelClock == 590) {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: KonfirmasiKetiga(
              backgrounds: backgrounds,
            ),
            inheritTheme: true,
            ctx: context),
      );
    } else {}

    getOrderSettings();
    getWarnaBg();
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

  void getInvoice() async {
    // print('get invoices');
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var date = qris_request_date.substring(0, 10);
    // print('date : ' + date);

    // ignore: unused_local_variable
    var hargaPaid = 100;
    // ignore: unused_local_variable
    var invidPaid = '11229987428';
    // ignore: unused_local_variable
    var datePaid = '2023-06-07';

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://qris.id/restapi/qris/checkpaid_qris.php?do=checkStatus&apikey=139139230121963&mID=195299656285&invid=$qris_invoiceid&trxvalue=$harga&trxdate=$date'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var item =
          const JsonDecoder().convert(await response.stream.bytesToString());

      // old statements, comment sementara
      setState(() {
        status_transaksi = item['data']['qris_status'];
      });

      // print('item data get invoices : ${item['data']}');

      // print('status paid : ' + status_paid);
    } else {
      print(response.reasonPhrase);
    }
  }

  // insert user new
  _insertUser(status, nama, voucher) async {
    db.getConnection().then(
      (value) {
        String sql =
            "insert into user_fotos (nama, hp, email, title_photobooth, harga, id_foto, status_transaksi, jenis_transaksi, voucher, status_voucher, waktu) VALUES ('$nama', '$no_telp', '$email_user', '$title', '$harga', '$random_string', '$status_transaksi', '$jenis_transaksi', '$voucher', 'belum', '$waktu');";
        value.query(sql).then((value) {
          print("berhasil insert user $nama status $status");
        });
        return value.close();
      },
    );
  }

  sendMail() async {
    // add generate string / code
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    String date = DateTime.now().day.toString();
    String month = DateTime.now().month.toString();
    String r1 = getRandomString(1);
    String r2 = getRandomString(3);

    setState(() {
      // ignore: prefer_interpolation_to_compose_strings
      kode_voucher = 'M' + r1 + "-" + date + month + "-" + "A" + r2;
    });

    _insertUser('belum', nama_user, kode_voucher);

    String username = 'muhammadnurramadhan920307@gmail.com';
    String password = 'wkzgszlpcwcoemzm';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, nama_user)
      ..recipients.add(email_user)
      ..subject = 'Selfie-Booth'
      ..text = 'Terima kasih telah mengunjungi selfiebooth'
      ..html =
          // ignore: prefer_interpolation_to_compose_strings
          '<html lang="en"> <head> <meta charset="UTF-8" /> <meta name="viewport" content="width=device-width, initial-scale=1.0" /> <title>Selfie-Booth</title> </head> <body style="background-color: #f06d06; font-family: system-ui; color: aliceblue; text-align: justify; padding: 20%;"> <center><h1>👋 Hi, Kita Dari Selfi Booth,</h1><br /><br /><h3><i>Terima kasih telah mengunjungi foto selfi booth kami,</i></h3><h3><i>Berikut e-mail qrcode untuk scan qr - edit foto dan sesi foto,</i></h3></center><br /><br /><center><img id="barcode"src="https://api.qrserver.com/v1/create-qr-code/?data=$kode_voucher&amp;size=100x100"alt="``"title="qrcode" width="150" height="150"/></center><br /><br /><center><h3><i>Dan berikut kode voucher untuk transaksi foto selfie booth</i></h3></center><center><div style="border: 15px solid whitesmoke; padding: 5px; border-radius: 25px;"><h2><i><b>$kode_voucher</b></i></h2></div></center></body></html>';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    // await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }

  _getStorage() async {
    if (await storage.ready) {
      setState(() {
        nama_bank = storage.getItem('nama_bank') ?? "";
        virtual_account = storage.getItem('virtual_account') ?? "";

        title = storage.getItem('judul') ?? "";
        deskripsi = storage.getItem('deskripsi') ?? "";
        harga = int.parse(storage.getItem('harga').toString());
        waktu = storage.getItem('waktu') ?? "";

        jenis_transaksi = storage.getItem('jenis_transaksi') ?? "";
        status_transaksi = storage.getItem('status_transaksi') ?? "";

        nama_user = storage.getItem('nama') ?? "";
        no_telp = storage.getItem('telp') ?? "";
        email_user = storage.getItem('email') ?? "";
        ig = storage.getItem('ig') ?? "";
      });
    } else {}
    print("nama user storage : $nama_user");
    print("nama deksirpsi storage : $deskripsi");

    print("nama bank storage : $nama_bank");
    print("virtual_account storage : $virtual_account");
    print("email user : $email_user");
    print("title photobooth user : $title");
  }

  createInvoices() async {
    // ...
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    const _numbers = '1234567890';

    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length))));

    String date = DateTime.now().day.toString();
    String month = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();

    // ...
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.ipv4_local}/api/invoices'));
    request.fields.addAll({
      'tanggal': '$date/$month/$year',
      'no_invoice': 'INV${getRandomString(6)}-${getRandomString(3)}',
      'code': getRandomString(9),
      'paket': title,
      'customer': nama_user,
      'email': email_user,
      'no_telp': no_telp,
      'harga': harga.toString(),
      'image': '-'
    });

    // request.files.add(await http.MultipartFile.fromPath(
    //     'image', '/C:/Users/rama/Documents/1720471768_main.jpg'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                color: Color.fromARGB(255, 155, 61, 93),
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
                        colors: [Colors.transparent, Colors.transparent],
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
              // color: Colors.white,
              height: width * 0.46,
              width: width * 1,
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
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
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // container
                          SizedBox(
                            height: width * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            // child: Row(
                            //   children: [
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: width * 0.018,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: width * 0.33,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: InkWell(
                                              // onTap: () {
                                              //   Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           const HomeWidget(),
                                              //     ),
                                              //   );
                                              // },
                                              child: Card(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                elevation: 12,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  onTap: () {
                                                    //  ...
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(25.0),
                                                      //   child: Icon(
                                                      //     Icons.arrow_circle_left,
                                                      //     color: Colors.white,
                                                      //     size: width * 0.0225,
                                                      //   ),
                                                      // ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Text(
                                                          jenis_pembayaran ==
                                                                  "qris"
                                                              ? "Qris Code"
                                                                  .toUpperCase()
                                                              : jenis_pembayaran ==
                                                                      "bank payment"
                                                                  ? "Virtual Account"
                                                                  : "Bayar Di Tempat"
                                                                      .toUpperCase(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.025,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    54,
                                                                    54,
                                                                    54),
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
                                        height: 10,
                                      ),
                                      Center(
                                        child: Container(
                                          width: width * 0.325,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                                child: jenis_pembayaran ==
                                                        "qris"
                                                    ? Container(
                                                        child: QrImageView(
                                                          data: qris_content,
                                                          version:
                                                              QrVersions.auto,
                                                          size: 320,
                                                          gapless: false,
                                                        ),
                                                      )
                                                    : jenis_pembayaran ==
                                                            "bank payment"
                                                        ? FaIcon(
                                                            FontAwesomeIcons
                                                                .rupiahSign,
                                                            color: Colors.white,
                                                            size: 140,
                                                          )
                                                        : Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          35),
                                                              border: Border.all(
                                                                  width: 5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      155,
                                                                      61,
                                                                      93),
                                                            ),
                                                            // color:
                                                            //     Color.fromARGB(
                                                            //         255,
                                                            //         251,
                                                            //         142,
                                                            //         178),
                                                            height:
                                                                width * 0.15,
                                                            width:
                                                                double.infinity,
                                                            child: Center(
                                                                child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .rupiahSign,
                                                              color:
                                                                  Colors.white,
                                                              size: width * 0.1,
                                                            ))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: width * 0.33,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: InkWell(
                                            // ...
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                color: Color.fromARGB(
                                                    255, 155, 61, 93),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                onTap: () {
                                                  //  ...
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(25.0),
                                                    //   child: Icon(
                                                    //     Icons.arrow_circle_left,
                                                    //     color: Colors.white,
                                                    //     size: width * 0.0225,
                                                    //   ),
                                                    // ),
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Masa Berlaku"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 15.0),
                                                          child: Countdown(
                                                            animation:
                                                                StepTween(
                                                              begin:
                                                                  levelClock, // THIS IS A USER ENTERED NUMBER
                                                              end: 0,
                                                            ).animate(
                                                                    _controller),
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
                                Container(
                                  width: width * 0.6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.025,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  jenis_pembayaran == "qris"
                                                      ? "Request Date - $qris_request_date"
                                                      : jenis_pembayaran ==
                                                              "bank payment"
                                                          ? "No Va - $virtual_account"
                                                          : "Step Pembayaran Ditempat / Cash",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.012,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  jenis_pembayaran == "qris"
                                                      ? "Invoice ID - $qris_invoiceid"
                                                      : jenis_pembayaran ==
                                                              "bank payment"
                                                          ? "Virutal Account - $virtual_account"
                                                          : "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.012,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: jenis_pembayaran == "qris"
                                                ? 45
                                                : jenis_pembayaran ==
                                                        "bank payment"
                                                    ? 45
                                                    : 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Text(
                                                    "Untuk melakukan pembayaran\nanda bisa mengikuti step - step dibawah ini.",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.010,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Text(
                                                    jenis_pembayaran == "qris"
                                                        ? "1. Buka aplikasi m-banking / qris payment banking di smartphone."
                                                        : jenis_pembayaran ==
                                                                "bank payment"
                                                            ? "1. Buka aplikasi m-banking di smartphone."
                                                            : "1. Melakukan Pembayaran Ditempat, Dengan Menggunakan Uang Cash",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.010,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          jenis_pembayaran != "bayar ditempat"
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Text(
                                                          "2. Masukkan username dan password.",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          jenis_pembayaran != "bayar ditempat"
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Text(
                                                          "3. Pilih menu transfer : transfer VA \n( Virtual Account / Qris Payment ).",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.010,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          jenis_pembayaran == "bayar ditempat"
                                              ? Container()
                                              : qris_content != null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Text(
                                                              "4. Bayar Qris Id dengan scan Qris yang ada dan lakukan konfirmasi pembayaran.",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Text(
                                                              "4. Masukkan Nomor Virtual Account \npemesanan kamu yang terdapat \ndalam layar pemesanan.",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                          jenis_pembayaran == "bayar ditempat"
                                              ? Container()
                                              : qris_content != null
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 0,
                                                            ),
                                                            child: Text(
                                                              "5. Lalu masukkan Pin Bank kamu.",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                          jenis_pembayaran == "bayar ditempat"
                                              ? Container()
                                              : qris_content != null
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Text(
                                                              "6. Setelah melakukan transfer / \npembayaran melalui VA bank, \ntekan tombol Pengecekan pembayaran.",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                          jenis_pembayaran == "bayar ditempat"
                                              ? Container()
                                              : qris_content != null
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Text(
                                                              "7. Bukti pembayaran akan anda terima \nmelalui email yang sudah anda daftarkan \n`pastikan amati` yang anda daftarkan sesuai ya.",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.010,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(45.0),
                            //   child:
                            // ),
                            //   ],
                            // ),
                          ),

                          SizedBox(
                            height: width * 0.02,
                          ),
                          Container(
                            // color: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  // left: 25.0,
                                  // right: 25,
                                  ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
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
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          onPressed: () {
                                            // do onpressed...
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         PilihPembayaran(),
                                            //   ),
                                            // );
                                            // Navigator.of(context).push(
                                            //     _routeAnimate(
                                            //         PilihPembayaran()));

                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: PilihPembayaran(
                                                    backgrounds: backgrounds,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_left_outlined,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 96, 96, 96),
                                                      size: width * 0.025,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Kembali".toUpperCase(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.016,
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
                                  Container(
                                    // color: Colors.grey,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.025),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: OutlinedButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          onPressed: () {
                                            // do onpressed...

                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: KonfirmasiKetiga(
                                                    backgrounds: backgrounds,
                                                  ),
                                                  inheritTheme: true,
                                                  ctx: context),
                                            );

                                            sendMail();
                                            createInvoices();
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
                                                  SizedBox(
                                                    width: 45,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Cek".toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: width * 0.016,
                                                        color: Color.fromARGB(
                                                            255, 96, 96, 96),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 96, 96, 96),
                                                      size: width * 0.025,
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
                        ],
                      ),
                    ),
                    // ),r
                    // ),
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

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
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
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
