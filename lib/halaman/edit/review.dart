// ignore_for_file: unused_field, override_on_non_overriding_member, unused_local_variable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    super.key,
    required this.nama,
    required this.title,
    required this.nama_filter,
    required this.choose_layout,
    required this.drag_item,
    required this.choose_background,
    required this.image,
  });

  final nama;
  final title;
  final nama_filter;
  final choose_layout;
  final drag_item;
  final choose_background;
  final image;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState(
        this.nama,
        this.title,
        this.nama_filter,
        this.choose_layout,
        this.drag_item,
        this.choose_background,
        this.image,
      );
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final nama;
  final title;
  final nama_filter;
  final choose_layout;
  final drag_item;
  final choose_background;
  final image;
  // ...
  String deskripsi = "";
  String nama_user = "";
  int no_telp = 0;
  String email_user = "";
  String ig = "";
  int harga = 0;

  _ReviewWidgetState(
    this.nama,
    this.title,
    this.nama_filter,
    this.choose_layout,
    this.drag_item,
    this.choose_background,
    this.image,
  );

  @override
  void initState() {
    // TODO: implement initState
    // _saveStorage(title, deskripsi, nama, telp, email, ig, harga);
    super.initState();
  }

  // ...
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
  // end statements color waves

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100.0);
  Widget build(BuildContext context) {
    // ...
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title, image, width, height),
        ),
      ),
    );
  }
}

Future<Uint8List> _generatePdf(PdfPageFormat format, String title, String image,
    double width, double height) async {
  final pdf = pw.Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );

  // ...
  final font = await PdfGoogleFonts.nunitoExtraLight();

  final provider = await flutterImageProvider(
      NetworkImage("192.168.137.1/storage/uploads/print/$image"));

  // final image_ = await imageFromAssetBundle('assets/image.png');
  // var _image = MemoryImage(image);

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Flexible(
          child: pw.Center(
            child: pw.Image(
              provider,
              width: width * 1,
              // height: 5,
            ),
          ),
        );
      },
    ),
  );

  return pdf.save();
}
