// ignore_for_file: unused_import

import 'dart:async';

import 'package:fs_dart/halaman/order/pilih_pembayaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_dart/halaman/order/konfirmasi_pertama.dart';
import 'package:fs_dart/src/variables.g.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:localstorage/localstorage.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../src/database/db.dart';

late StreamSubscription<bool> keyboardSubscription;

class ReviewPaymentWidget extends StatefulWidget {
  const ReviewPaymentWidget({
    super.key,
    required this.backgrounds,
  });

  final backgrounds;

  @override
  State<ReviewPaymentWidget> createState() =>
      _ReviewPaymentWidgetState(this.backgrounds);
}

class _ReviewPaymentWidgetState extends State<ReviewPaymentWidget> {
  // ...
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

  // bool tap input
  bool isTapInputNama = false;
  bool isTapInputTelp = false;
  bool isTapInputEmail = false;
  bool isTapInputInstagram = false;

  // keyboard onpress
  /// Fired when the virtual keyboard key is pressed.
  ///
  // Holds the text that user typed.
  String textNama = '';
  String textTelp = '';
  String textEmail = '';
  String textIg = '';
  String text = '';
  // CustomLayoutKeys _customLayoutKeys;
  // True if shift enabled.
  bool shiftEnabled = false;

  // is true will show the numeric keyboard.
  bool isNumericMode = false;

  bool isKeyboard = true;

  // var TextEditingController _controllerTextNama;
  // var TextEditingController _controllerTextEmail;
  // var TextEditingController _controllerTextTelp;
  // var TextEditingController _controllerTextIg;

  var txtNama = TextEditingController();
  var txtEmail = TextEditingController();
  var txtTelp = TextEditingController();
  var txtIg = TextEditingController();

  late VirtualKeyboardKey keyNama;
  late VirtualKeyboardKey keyEmail;
  late VirtualKeyboardKey keyTelp;
  late VirtualKeyboardKey keyIg;

  // late VirtualKeyboardKey key;

  // FocusNode inputNode = FocusNode();

  String headerImg = "";
  String bgImg = "";

  _ReviewPaymentWidgetState(this.backgrounds);

  @override
  void initState() {
    // TODO: implement initState

    getOrderSettings();
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

  _onKeyPressKeyboardVirutal(VirtualKeyboardKey key) {
    // if (type.isNotEmpty) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      if (isTapInputNama == true) {
        textNama =
            textNama + (shiftEnabled ? key.capsText : key.text).toString();
        // ...
        setState(() {
          // ...
          txtNama.text = textNama;
        });
      }
      if (isTapInputEmail == true) {
        textEmail =
            textEmail + (shiftEnabled ? key.capsText : key.text).toString();
        // ...
        setState(() {
          // ...
          txtEmail.text = textEmail;
        });
      }
      if (isTapInputTelp == true) {
        textTelp =
            textTelp + (shiftEnabled ? key.capsText : key.text).toString();
        // ...
        setState(() {
          // ...
          txtTelp.text = textTelp;
        });
      }
      if (isTapInputInstagram == true) {
        textIg = textIg + (shiftEnabled ? key.capsText : key.text).toString();
        // ...
        setState(() {
          // ...
          txtIg.text = textIg;
        });
      }
      print("object text : $text");
      print("onpress key");
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (textNama.length == 0) return;
          {
            if (isTapInputNama == true) {
              textNama = textNama.substring(0, textNama.length - 1);
              // txtNama.addListener("");
              // ...
              setState(() {
                // ...
                txtNama.text = textNama;
              });
            }
          }

          //
          if (textEmail.length == 0) return;
          {
            if (isTapInputEmail == true) {
              textEmail = textEmail.substring(0, textEmail.length - 1);
              // ...
              setState(() {
                // ...
                txtEmail.text = textEmail;
              });
            }
          }

          //
          if (textTelp.length == 0) return;
          {
            if (isTapInputTelp == true) {
              textTelp = textTelp.substring(0, textTelp.length - 1);
              // ...
              setState(() {
                // ...
                txtTelp.text = textTelp;
              });
            }
          }

          //
          if (textIg.length == 0) return;
          {
            if (isTapInputInstagram == true) {
              textIg = textIg.substring(0, textIg.length - 1);
              // ...
              setState(() {
                // ...
                txtIg.text = textIg;
              });
            }
          }
          break;
        case VirtualKeyboardKeyAction.Return:
          {
            if (isTapInputNama == true) {
              textNama = textNama + '\n';
              // txtNama.addListener("");
              // ...
              setState(() {
                // ...
                txtNama.text = textNama;
              });
            }
            if (isTapInputEmail == true) {
              textEmail = textEmail + '\n';
              // ...
              setState(() {
                // ...
                txtEmail.text = textEmail;
              });
            }
            if (isTapInputTelp == true) {
              textTelp = textTelp + '\n';
              // ...
              setState(() {
                // ...
                txtTelp.text = textTelp;
              });
            }
            if (isTapInputInstagram == true) {
              textIg = textIg + '\n';
              // ...
              setState(() {
                // ...
                txtIg.text = textIg;
              });
            }
          }
          break;
        case VirtualKeyboardKeyAction.Space:
          {
            // text = text + key.text.toString();

            if (isTapInputNama == true) {
              textNama = textNama + key.text.toString();
              // txtNama.addListener("");
              // ...
              setState(() {
                // ...
                txtNama.text = textNama;
              });
            }
            if (isTapInputEmail == true) {
              textEmail = textEmail + key.text.toString();
              // ...
              setState(() {
                // ...
                txtEmail.text = textEmail;
              });
            }
            if (isTapInputTelp == true) {
              textTelp = textTelp + key.text.toString();
              // ...
              setState(() {
                // ...
                txtTelp.text = textTelp;
              });
            }
            if (isTapInputInstagram == true) {
              textIg = textIg + key.text.toString();
              // ...
              setState(() {
                // ...
                txtIg.text = textIg;
              });
            }
          }
          break;
        case VirtualKeyboardKeyAction.Shift:
          {
            shiftEnabled = !shiftEnabled;
          }
          break;
        default:
      }
      print("object text : $text");
    }
    // Update the screen
    setState(() {});
    // } else {
    //   setState(() {
    //     text = "";
    //   });
    // }
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

  _saveStorage() async {
    print("nama user onsave : $nama_user");
    // await storage.setItem('title', title);
    // await storage.setItem('deskripsi', deskripsi);
    await storage.setItem('nama', nama_user);
    await storage.setItem('telp', no_telp);
    await storage.setItem('email', email_user);
    await storage.setItem('ig', ig);
    // await storage.setItem('harga', harga);
  }

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

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
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
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 26, 26).withOpacity(0.7),
              ),
              height: height * 0.12,
              width: width * 1,
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
              // color: Color.fromARGB(255, 255, 152, 178),
              height: width * 0.46,
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
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: width * 0.025,
                        ),
                        child: Container(
                          width: width * 1,
                          height: width * 0.6,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.045,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Container(
                                  // width: width * 0.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        child: Card(
                                          elevation: 12,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: TextFormField(
                                              controller: txtNama,
                                              onTap: () {
                                                print("tap textformfield nama");
                                                setState(() {
                                                  isTapInputNama =
                                                      !isTapInputNama;

                                                  isTapInputEmail = false;
                                                  isTapInputInstagram = false;
                                                  isTapInputTelp = false;
                                                });
                                                print(
                                                    "isTapInputNama : $isTapInputNama");
                                              },

                                              // focusNode: inputNode,
                                              // autofocus: true,
                                              //maxLines: 1,
                                              style: TextStyle(
                                                fontSize: width * 0.012,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                icon: Padding(
                                                  padding: EdgeInsets.all(
                                                    width * 0.025,
                                                  ),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: width * 0.025,
                                                  ),
                                                ),
                                                hintText: 'Nama kamu ?',
                                                labelText: 'Nama',
                                                hintStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                hintFadeDuration:
                                                    Duration(microseconds: 10),
                                                labelStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                  width * 0.015,
                                                ),
                                              ),
                                              onSaved: (String? value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                              },
                                              onChanged: (value) {
                                                // ...
                                                setState(() {
                                                  nama_user = value;
                                                });

                                                print("nama_user : $nama_user");
                                                print(
                                                    "txtNama : ${txtNama.text}");
                                              },
                                              validator: (String? value) {
                                                return (value != null &&
                                                        value.contains('@'))
                                                    ? 'Do not use the @ char.'
                                                    : null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Container(
                                  // width: width * 0.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        child: Card(
                                          elevation: 12,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: TextFormField(
                                              controller: txtTelp,
                                              onTap: () {
                                                print("tap textformfield telp");
                                                setState(() {
                                                  isTapInputTelp =
                                                      !isTapInputTelp;

                                                  isTapInputEmail = false;
                                                  isTapInputInstagram = false;
                                                  isTapInputNama = false;

                                                  textNama = "";
                                                });
                                              },
                                              style: TextStyle(
                                                fontSize: width * 0.012,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                icon: Padding(
                                                  padding: EdgeInsets.all(
                                                    width * 0.025,
                                                  ),
                                                  child: Icon(
                                                    Icons.phone_android,
                                                    size: width * 0.025,
                                                  ),
                                                ),
                                                hintText: 'No telp kamu ?',
                                                labelText: 'Telp',
                                                hintStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                labelStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                  width * 0.015,
                                                ),
                                              ),
                                              onSaved: (String? value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                              },
                                              onChanged: (value) {
                                                // ...
                                                setState(() {
                                                  no_telp = value;
                                                });
                                              },
                                              validator: (String? value) {
                                                return (value != null &&
                                                        value.contains('@'))
                                                    ? 'Do not use the @ char.'
                                                    : null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Container(
                                  // width: width * 0.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        child: Card(
                                          elevation: 12,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: TextFormField(
                                              controller: txtEmail,
                                              onTap: () {
                                                print(
                                                    "tap textformfield email");
                                                setState(() {
                                                  isTapInputEmail =
                                                      !isTapInputEmail;

                                                  isTapInputTelp = false;
                                                  isTapInputInstagram = false;
                                                  isTapInputNama = false;
                                                });
                                              },
                                              style: TextStyle(
                                                fontSize: width * 0.012,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                icon: Padding(
                                                  padding: EdgeInsets.all(
                                                    width * 0.025,
                                                  ),
                                                  child: Icon(
                                                    Icons.mail,
                                                    size: width * 0.025,
                                                  ),
                                                ),
                                                hintText: 'Email kamu ?',
                                                labelText: 'E-mail',
                                                hintStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                labelStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                  width * 0.015,
                                                ),
                                              ),
                                              onSaved: (String? value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                              },
                                              onChanged: (value) {
                                                // ...
                                                setState(() {
                                                  email_user = value;
                                                });
                                              },
                                              validator: (String? value) {
                                                return (value != null &&
                                                        value.contains('@'))
                                                    ? 'Do not use the @ char.'
                                                    : null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Container(
                                  // width: width * 0.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        child: Card(
                                          elevation: 12,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: TextFormField(
                                              controller: txtIg,
                                              onTap: () {
                                                print("tap textformfield ig");
                                                setState(() {
                                                  isTapInputInstagram =
                                                      !isTapInputInstagram;

                                                  isTapInputEmail = false;
                                                  isTapInputTelp = false;
                                                  isTapInputNama = false;
                                                });
                                              },
                                              style: TextStyle(
                                                fontSize: width * 0.012,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                icon: Padding(
                                                  padding: EdgeInsets.all(
                                                    width * 0.025,
                                                  ),
                                                  child: Icon(
                                                    Icons.image_aspect_ratio,
                                                    size: width * 0.025,
                                                  ),
                                                ),
                                                hintText: 'IG kamu ?',
                                                hintStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                labelStyle: TextStyle(
                                                  fontSize: width * 0.012,
                                                ),
                                                labelText: 'Instagram',
                                                contentPadding: EdgeInsets.all(
                                                  width * 0.015,
                                                ),
                                              ),
                                              onSaved: (String? value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                                print("value onsave : $value");
                                              },
                                              onChanged: (value) {
                                                // ...
                                                setState(() {
                                                  ig = value;
                                                });
                                                print("ig : $ig");
                                              },
                                              validator: (String? value) {
                                                return (value != null &&
                                                        value.contains('@'))
                                                    ? 'Do not use the @ char.'
                                                    : null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: width * 0.055,
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
                                                //         OrderWidget(),
                                                //   ),
                                                // );
                                                // Navigator.of(context).push(
                                                //     _routeAnimate(
                                                //         OrderWidget()));

                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: OrderWidget(
                                                        backgrounds: bgImg,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_circle_left_outlined,
                                                          color: const Color
                                                              .fromARGB(
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
                                                            "Kembali"
                                                                .toUpperCase(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.016,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      96,
                                                                      96,
                                                                      96),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                        height: isTapInputNama == true ||
                                                isTapInputTelp == true ||
                                                isTapInputEmail == true ||
                                                isTapInputInstagram == true
                                            ? height * 0.135
                                            : 0,
                                        width: isTapInputNama == true ||
                                                isTapInputTelp == true ||
                                                isTapInputEmail == true ||
                                                isTapInputInstagram == true
                                            ? width * 0.35
                                            : 0,
                                        // width: width * 1,
                                        color: Colors.black,
                                        child: VirtualKeyboard(
                                          reverseLayout: false,
                                          // Default height is 300
                                          height: height * 0.135,
                                          // Default height is will screen width
                                          width: width * 0.35,
                                          // Default is black
                                          textColor: Colors.white,
                                          // Default 14
                                          fontSize: width * 0.01,
                                          // the layouts supported
                                          onKeyPress:
                                              _onKeyPressKeyboardVirutal,
                                          // [A-Z, 0-9]
                                          type:
                                              VirtualKeyboardType.Alphanumeric,
                                          // Callback for key press event
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.grey,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.025),
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
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: PilihPembayaran(
                                                        backgrounds:
                                                            backgrounds,
                                                      ),
                                                      inheritTheme: true,
                                                      ctx: context),
                                                );
                                                _saveStorage();
                                              },
                                              child: Container(
                                                // color: Colors.transparent,
                                                width: width * 0.15,
                                                // height: height * 0.012,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 45,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Lanjut"
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.016,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    96,
                                                                    96,
                                                                    96),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_circle_right_outlined,
                                                          color: const Color
                                                              .fromARGB(
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
                      ),
                    ),
                  ),
                  // ),r
                  // ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //});
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
