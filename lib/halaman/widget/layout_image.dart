import 'package:flutter/material.dart';
import 'package:fs_dart/src/variables.g.dart';

class LayoutImageWidget extends StatefulWidget {
  const LayoutImageWidget({
    super.key,
    required this.nama_kotak,
    required this.url_image,
    required this.tinggi,
    required this.lebar,
  });

  final nama_kotak;
  final url_image;
  final tinggi;
  final lebar;

  @override
  State<LayoutImageWidget> createState() => _LayoutImageWidgetState(
        this.nama_kotak,
        this.url_image,
        this.tinggi,
        this.lebar,
      );
}

class _LayoutImageWidgetState extends State<LayoutImageWidget> {
  final nama_kotak;
  final url_image;
  final tinggi;
  final lebar;

  _LayoutImageWidgetState(
    this.nama_kotak,
    this.url_image,
    this.tinggi,
    this.lebar,
  );

  @override
  void initState() {
    // TODO: implement initState

    print("tinggi : $tinggi");
    print("lebar : $lebar");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: url_image != ""
                ? BoxDecoration(
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: NetworkImage(
                        "${Variables.ipv4_local}/storage/${url_image.toString()}",
                      ),
                      fit: BoxFit.contain,
                    ),
                  )
                : BoxDecoration(
                    color: Colors.grey[300],
                  ),
            width: lebar,
            height: tinggi,
          ),
        ),
      ),
    );
  }
}
