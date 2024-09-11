// ignore_for_file: unused_import, unused_local_variable, duplicate_ignore, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fs_dart/halaman/edit/review.dart';
import 'package:fs_dart/halaman/order/review.dart';
import 'package:flutter/material.dart';
import 'package:fs_dart/halaman/order/konfirmasi_pertama.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../src/variables.g.dart';
import 'konfirmasi_kedua.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../src/database/db.dart';

class PilihPembayaran extends StatefulWidget {
  const PilihPembayaran({super.key, required this.backgrounds});

  final backgrounds;
  @override
  State<PilihPembayaran> createState() =>
      _ReviewKonfirmasiPertamaState(this.backgrounds);
}

class _ReviewKonfirmasiPertamaState extends State<PilihPembayaran> {
  final LocalStorage storage = new LocalStorage('parameters');
  final backgrounds;
  String title = "";
  String deskripsi = "";
  String nama_user = "";
  String no_telp = "";
  String email_user = "";
  String ig = "";
  int harga = 0;

  var db = new Mysql();

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

  // ignore: prefer_typing_uninitialized_variables
  var apikey;
  // ignore: prefer_typing_uninitialized_variables
  var mid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var harga_invoice;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var invoices_status = 'PENDING';

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var qris_content;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var qris_request_date;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var qris_invoiceid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var qris_nmid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var status_paid = 'unpaid';

  var random_string = "";

  var id_foto = "";

  var status_transaksi = "";

  var jenis_transaksi = "";

  var jenis_pembayaran = "";

  _ReviewKonfirmasiPertamaState(this.backgrounds);

  @override
  void initState() {
    // TODO: implement initState
    // _saveStorage(title, deskripsi, nama, telp, email, ig, harga);
    getOrderSettings();
    _getStorage();
    getWarnaBg();
    super.initState();
  }

  var bg_warna_main = "";
  var warna1 = "";
  var warna2 = "";

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

  void generateIdFoto() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    setState(() {
      id_foto = getRandomString(5).toString();
    });
  }

  _getStorage() async {
    setState(() {
      // await storage.setItem('nama', nama_user);
      // await storage.setItem('telp', no_telp);
      // await storage.setItem('email', email_user);
      // await storage.setItem('ig', ig);

      title = storage.getItem('title') ?? "";
      deskripsi = storage.getItem('deskripsi') ?? "";
      harga = int.parse(storage.getItem('harga').toString());

      nama_user = storage.getItem('nama') ?? "";
      no_telp = storage.getItem('telp') ?? "";
      email_user = storage.getItem('email') ?? "";
      ig = storage.getItem('ig') ?? "";
    });

    print("nama user : $nama_user");
  }

  _createRequestPayment(nama_bank) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic U0ItTWlkLXNlcnZlci04R0hEODU0RDk1SF96M0Y0b2hpZTEweE06'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.sandbox.midtrans.com/v2/charge'));
    request.body = json.encode({
      "payment_type": "bank_transfer",
      "transaction_details": {
        "gross_amount": int.parse(harga.toString()),
        "order_id":
            "order-photobooth-${DateTime.now().day}${DateTime.now().second}"
      },
      // nama_bank == "gopay" || nama_bank == "qris"
      //     ? "gopay"
      //     : {
      //         "enable_callback": true,
      //         "callback_url": "someapps://callback"
      //       }: null,
      "customer_details": {
        "email": "$email_user",
        "first_name": "$nama_user",
        "last_name": "",
        "phone": "$no_telp"
      },
      "item_details": [
        {
          "id": "item01",
          "price": int.parse(harga.toString()),
          "quantity": 1,
          "name": "$title"
        }
      ],
      "bank_transfer": {"bank": "$nama_bank", "va_number": "12345678"}
    });
    request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    http.Response response =
        await http.Response.fromStream(await request.send());

    var jsonResponse;

    if (response.statusCode == 200) {
      // print(await response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(response.body);
      print("data : ${data["va_numbers"]}");
      print("data : ${data["va_numbers"][0]["va_number"]}");

      _saveStorage("$nama_bank", data["va_numbers"][0]["va_number"]);

      // asusmsi sudah membayar pembayaran -> saveusertodb
      _saveUserToDb();
    } else {
      print(response.reasonPhrase);
    }
  }

  // get invoice qris id payment
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
            'https://qris.id/restapi/qris/checkpaid_qris.php?do=checkStatus&apikey=139139230121963&mID=195299656285&invid=$qris_invoiceid&trxvalue=$harga_invoice&trxdate=$date'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var item =
          const JsonDecoder().convert(await response.stream.bytesToString());

      // old statements, comment sementara
      setState(() {
        status_paid = item['data']['qris_status'];
        status_transaksi = item['data']['qris_status'];
      });

      // print('item data get invoices : ${item['data']}');

      // print('status paid : ' + status_paid);
    } else {
      print(response.reasonPhrase);
    }
  }

  void createInvoices() async {
    // ignore: no_leading_underscores_for_local_identifiers
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    setState(() {
      random_string = getRandomString(5).toString();
    });

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://qris.online/restapi/qris/show_qris.php?do=create-invoice&apikey=139139230121963&mID=195299656285&cliTrxNumber=${random_string}&cliTrxAmount=${int.parse(harga.toString())}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var item =
          const JsonDecoder().convert(await response.stream.bytesToString());

      setState(() {
        qris_content = item['data']['qris_content'];
        qris_request_date = item['data']['qris_request_date'];
        qris_invoiceid = item['data']['qris_invoiceid'];
      });
      print("qris_content : $qris_content");
      print("qris_request_date : $qris_request_date");
      print("qris_invoiceid : $qris_invoiceid");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => KonfirmasiKedua(
      //       qris_content: qris_content,
      //       qris_request_date: qris_request_date,
      //       qris_invoiceid: qris_invoiceid, // parameter dari filter
      //       jenis_pembayaran: jenis_pembayaran,
      //     ),
      //   ),
      // );
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: KonfirmasiKedua(
              qris_content: qris_content,
              qris_request_date: qris_request_date,
              qris_invoiceid: qris_invoiceid, // parameter dari filter
              jenis_pembayaran: jenis_pembayaran,
              backgrounds: backgrounds,
            ),
            inheritTheme: true,
            ctx: context),
      );
      // Navigator.of(context).push(_routeAnimate(KonfirmasiKedua(
      //   qris_content: qris_content,
      //   qris_request_date: qris_request_date,
      //   qris_invoiceid: qris_invoiceid, // parameter dari filter
      //   jenis_pembayaran: jenis_pembayaran,
      // )));
    } else {
      print(response.reasonPhrase);
    }
  }

  _saveUserToDb() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('192.168.137.1/api/users'));
    request.fields.addAll({
      'nama': nama_user,
      'title_photobooth': title,
      'harga': harga.toString(),
      'id_foto': nama_user +
          "_" +
          DateTime.now().day.toString() +
          "_" +
          DateTime.now().millisecond.toString() +
          "_" +
          title,
      'status_transaksi': "sudah",
    });

    http.Response response =
        await http.Response.fromStream(await request.send());

    var jsonResponse;

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  _saveStorage(nama_bank, virtual_account) async {
    print("nama_bank onsave : $nama_bank");
    await storage.setItem('nama_bank', nama_bank);
    await storage.setItem('virtual_account', virtual_account);
    Timer(
      Duration(seconds: 2),
      () =>
          // Navigator.of(context).push(_routeAnimate(KonfirmasiKedua(
          //   qris_content: qris_content,
          //   qris_request_date: qris_request_date,
          //   qris_invoiceid: qris_invoiceid, // parameter dari filter
          //   jenis_pembayaran: jenis_pembayaran,
          // ))),

          Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: KonfirmasiKedua(
              qris_content: qris_content,
              qris_request_date: qris_request_date,
              qris_invoiceid: qris_invoiceid, // parameter dari filter
              jenis_pembayaran: jenis_pembayaran,
              backgrounds: backgrounds,
            ),
            inheritTheme: true,
            ctx: context),
      ),
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => KonfirmasiKedua(
      //       qris_content: qris_content,
      //       qris_request_date: qris_request_date,
      //       qris_invoiceid: qris_invoiceid, // parameter dari filter
      //       jenis_pembayaran: jenis_pembayaran,
      //     ),
      //   ),
      // ),
    );
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
              height: width * 0.46,
              width: width * 1,
              // color: Colors.white,
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
                    height: width * 0.45,
                    // child: SingleChildScrollView(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    // child: Container(
                    // width: width * 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // container
                          Container(
                            width: width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width * 0.42,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: InkWell(
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 155, 61, 93),
                                              elevation: 12,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                onTap: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: width * 0.02,
                                                        bottom: width * 0.02,
                                                        right: width * 0.045,
                                                        left: width * 0.045,
                                                      ),
                                                      child: Text(
                                                        "Qr Code / Cash"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.023,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
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
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              // width: width * 0.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    color: Color.fromARGB(
                                                        255, 155, 61, 93),
                                                    elevation: width * 0.005,
                                                    child: Container(
                                                      width: width * 0.12,
                                                      height: width * 0.2,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          // ...
                                                          print(
                                                              "gopay payment");

                                                          createInvoices();
                                                          setState(() {
                                                            jenis_pembayaran =
                                                                "qris";
                                                          });
                                                          await storage.setItem(
                                                              'jenis_transaksi',
                                                              'gopay');
                                                          await storage.setItem(
                                                              'status_transaksi',
                                                              'sudah');
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(25),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .qrcode,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 140,
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    "Gopay",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          42,
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
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Card(
                                                    color: Color.fromARGB(
                                                        255, 155, 61, 93),
                                                    elevation: width * 0.005,
                                                    child: Container(
                                                      width: width * 0.12,
                                                      height: width * 0.2,
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            // ...
                                                            print(
                                                                "qris payment");

                                                            createInvoices();
                                                            setState(() {
                                                              jenis_pembayaran =
                                                                  "qris";
                                                            });
                                                            await storage.setItem(
                                                                'jenis_transaksi',
                                                                'qris');
                                                            await storage.setItem(
                                                                'status_transaksi',
                                                                'sudah');
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    25),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .qrcode,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 140,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "Qris",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            42,
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
                                                    width: 15,
                                                  ),
                                                  Card(
                                                    color: Color.fromARGB(
                                                        255, 155, 61, 93),
                                                    elevation: width * 0.005,
                                                    child: Container(
                                                      width: width * 0.12,
                                                      height: width * 0.2,
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            // ...
                                                            print(
                                                                "bayar ditempat");
                                                            await storage.setItem(
                                                                'jenis_transaksi',
                                                                'bayar ditempat');
                                                            await storage.setItem(
                                                                'status_transaksi',
                                                                'sudah');

                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      KonfirmasiKedua(
                                                                    qris_content:
                                                                        qris_content,
                                                                    qris_request_date:
                                                                        qris_request_date,
                                                                    qris_invoiceid:
                                                                        qris_invoiceid, // parameter dari filter
                                                                    jenis_pembayaran:
                                                                        "bayar ditempat",
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
                                                                EdgeInsets.all(
                                                                    25),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .rupiahSign,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 140,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "Bayar Ditempat",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            24,
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: width * 0.04,
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
                                            //         ReviewPaymentWidget(),
                                            //   ),
                                            // );
                                            // Navigator.of(context).push(
                                            //     _routeAnimate(
                                            //         ReviewPaymentWidget()));

                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: ReviewPaymentWidget(
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
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         KonfirmasiKedua(
                                            //       qris_content: qris_content,
                                            //       qris_request_date:
                                            //           qris_request_date,
                                            //       qris_invoiceid:
                                            //           qris_invoiceid, // parameter dari filter
                                            //       jenis_pembayaran:
                                            //           jenis_pembayaran,
                                            //     ),
                                            //   ),
                                            // );
                                            // Navigator.of(context).push(
                                            //     _routeAnimate(KonfirmasiKedua(
                                            //   qris_content: qris_content,
                                            //   qris_request_date:
                                            //       qris_request_date,
                                            //   qris_invoiceid:
                                            //       qris_invoiceid, // parameter dari filter
                                            //   jenis_pembayaran:
                                            //       jenis_pembayaran,
                                            // )));

                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: KonfirmasiKedua(
                                                    qris_content: qris_content,
                                                    qris_request_date:
                                                        qris_request_date,
                                                    qris_invoiceid:
                                                        qris_invoiceid, // parameter dari filter
                                                    jenis_pembayaran:
                                                        jenis_pembayaran,
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
                                                  SizedBox(
                                                    width: 45,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Lanjut".toUpperCase(),
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
                                                          .arrow_circle_right_outlined,
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
