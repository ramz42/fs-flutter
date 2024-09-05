import 'package:flutter/material.dart';
import 'package:fs_dart/src/variables.g.dart';

import 'layout_image.dart';

class LayoutFrameWidget extends StatefulWidget {
  const LayoutFrameWidget({
    super.key,
    required this.tinggi,
    required this.lebar,
    required this.jumlah_row,
    required this.jumlah_kolom,
    required this.jumlah_kotak_sisi_kiri,
    required this.jumlah_kotak_sisi_kanan,
    required this.url_frame,
    required this.type,
    required this.onTap,
  });

  final tinggi;
  final lebar;
  final jumlah_row;
  final jumlah_kolom;
  final jumlah_kotak_sisi_kiri;
  final jumlah_kotak_sisi_kanan;
  final url_frame;
  final type;
  final void onTap;

  @override
  State<LayoutFrameWidget> createState() => _LayoutFrameWidgetState(
        this.tinggi,
        this.lebar,
        this.jumlah_row,
        this.jumlah_kolom,
        this.jumlah_kotak_sisi_kiri,
        this.jumlah_kotak_sisi_kanan,
        this.url_frame,
        this.type,
        this.onTap,
      );
}

class _LayoutFrameWidgetState extends State<LayoutFrameWidget> {
  final tinggi;
  final lebar;
  final jumlah_row;
  final jumlah_kolom;
  final jumlah_kotak_sisi_kiri;
  final jumlah_kotak_sisi_kanan;
  final url_frame;
  final type;
  final void onTap;

  _LayoutFrameWidgetState(
    this.tinggi,
    this.lebar,
    this.jumlah_row,
    this.jumlah_kolom,
    this.jumlah_kotak_sisi_kiri,
    this.jumlah_kotak_sisi_kanan,
    this.url_frame,
    this.type,
    this.onTap,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          onTap;
        },
        child: Center(
          child: Container(
            width: lebar, // pixel tinggi, lebar
            height: tinggi,

            decoration: url_frame != ""
                ? BoxDecoration(
                    color: Colors.grey[200],
                    image: DecorationImage(
                      // last visit code here
                      image: NetworkImage(
                          "${Variables.ipv4_local}/storage/background-image/edit-photo/${url_frame.toString()}"), // frame
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  )
                : BoxDecoration(
                    color: Colors.grey[200],
                  ),
            child: (jumlah_kolom == 1 && jumlah_row == 1)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: LayoutImageWidget(
                              lebar: type == "kanvas_kecil"
                                  ? (384 / 4) - 45
                                  : type == "main"
                                      ? (384 / 2) - 40
                                      : (384 / 4) - 45,
                              tinggi: type == "kanvas_kecil"
                                  ? (576 / 4) - 45
                                  : type == "main"
                                      ? (576 / 2) - 40
                                      : (576 / 4) - 45,
                              nama_kotak: "kolom 1 row 1",
                              url_image: "",
                            ),
                          ),
                          Container(
                            child: LayoutImageWidget(
                              lebar: type == "kanvas_kecil"
                                  ? (384 / 4) - 45
                                  : type == "main"
                                      ? (384 / 2) - 40
                                      : (384 / 4) - 45,
                              tinggi: type == "kanvas_kecil"
                                  ? (576 / 4) - 45
                                  : type == "main"
                                      ? (576 / 2) - 40
                                      : (576 / 4) - 45,
                              nama_kotak: "kolom 2 row 2",
                              url_image: "",
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : (jumlah_kolom == 2 && jumlah_row == 2)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: LayoutImageWidget(
                                  lebar: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  tinggi: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  nama_kotak: "kolom 1 row 1",
                                  url_image: "",
                                ),
                              ),
                              Container(
                                child: LayoutImageWidget(
                                  lebar: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  tinggi: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  nama_kotak: "kolom 2 row 2",
                                  url_image: "",
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: LayoutImageWidget(
                                  lebar: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  tinggi: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  nama_kotak: "kolom 1 row 1",
                                  url_image: "",
                                ),
                              ),
                              Container(
                                child: LayoutImageWidget(
                                  lebar: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  tinggi: type == "kanvas_kecil"
                                      ? (384 / 4) - 45
                                      : type == "main"
                                          ? (384 / 2) - 40
                                          : (384 / 4) - 45,
                                  nama_kotak: "kolom 2 row 2",
                                  url_image: "",
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    : Container(),
          ),
        ),
      ),
    );
  }
}
