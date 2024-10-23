// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../src/variables.g.dart';
import 'dart:convert';

class KostumLayout extends StatefulWidget {
  const KostumLayout({super.key});

  @override
  State<KostumLayout> createState() => _KostumLayoutState();
}

class _KostumLayoutState extends State<KostumLayout> {
  List<dynamic> layouts = [];

  @override
  void initState() {
    // TODO: implement initState
    getLayout();
    super.initState();
  }

  // get layout
  getLayout() async {
    var request = http.Request(
        'GET', Uri.parse('${Variables.ipv4_local}/api/layout-kostum'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;
      layouts.addAll(result);
      for (var element in layouts) {
        if (element['status'] == 'Aktif') {
          print("object : ${element['nama']}");
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  // ...

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      // ...
                      for (var element in layouts)
                        if (element['status'] == 'Aktif')
                          Container(
                            // ...
                            width: 600 / 1.7,
                            height: 900 / 1.7,
                            color: Color.fromARGB(255, 202, 145, 74),
                            child: Center(
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: int.parse(element['kotak1_top']
                                                .toString())
                                            .toDouble() /
                                        1.7,
                                    left: int.parse(element['kotak1_left']
                                                .toString())
                                            .toDouble() /
                                        1.7,
                                    child: Container(
                                      color: Color.fromARGB(255, 234, 197, 167),
                                      width: int.parse(element['kotak1_width']
                                                  .toString())
                                              .toDouble() /
                                          1.7,
                                      height: int.parse(element['kotak1_height']
                                                  .toString())
                                              .toDouble() /
                                          1.7,
                                      // ...
                                    ),
                                  ),

                                  // ...
                                  Positioned(
                                    top: int.parse(element['kotak2_top']
                                                .toString())
                                            .toDouble() /
                                        1.7,
                                    left: int.parse(element['kotak2_left']
                                                .toString())
                                            .toDouble() /
                                        1.7,
                                    child: Container(
                                      color: Color.fromARGB(255, 234, 197, 167),
                                      width: int.parse(element['kotak2_width']
                                                  .toString())
                                              .toDouble() /
                                          1.7,
                                      height: int.parse(element['kotak2_height']
                                                  .toString())
                                              .toDouble() /
                                          1.7,
                                      // ...
                                    ),
                                  ),
                                  // ...

                                  // ...
                                  element['kotak3_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak3_top']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          left: int.parse(element['kotak3_left']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                        element['kotak3_width']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            height: int.parse(
                                                        element['kotak3_height']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak4_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak4_top']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          left: int.parse(element['kotak4_left']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                        element['kotak4_width']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            height: int.parse(
                                                        element['kotak4_height']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak5_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak5_top']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          left: int.parse(element['kotak5_left']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                        element['kotak5_width']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            height: int.parse(
                                                        element['kotak5_height']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak6_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak6_top']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          left: int.parse(element['kotak6_left']
                                                      .toString())
                                                  .toDouble() /
                                              1.7,
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                        element['kotak6_width']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            height: int.parse(
                                                        element['kotak6_height']
                                                            .toString())
                                                    .toDouble() /
                                                1.7,
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak7_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak7_top']
                                                  .toString())
                                              .toDouble(),
                                          left: int.parse(element['kotak7_left']
                                                  .toString())
                                              .toDouble(),
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                    element['kotak7_width']
                                                        .toString())
                                                .toDouble(),
                                            height: int.parse(
                                                    element['kotak7_height']
                                                        .toString())
                                                .toDouble(),
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak8_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak8_top']
                                                  .toString())
                                              .toDouble(),
                                          left: int.parse(element['kotak8_left']
                                                  .toString())
                                              .toDouble(),
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                    element['kotak8_width']
                                                        .toString())
                                                .toDouble(),
                                            height: int.parse(
                                                    element['kotak8_height']
                                                        .toString())
                                                .toDouble(),
                                            // ...
                                          ),
                                        )
                                      : Container(),
                                  // ...

                                  // ...
                                  element['kotak9_top'] != null
                                      ? Positioned(
                                          top: int.parse(element['kotak9_top']
                                                  .toString())
                                              .toDouble(),
                                          left: int.parse(element['kotak9_left']
                                                  .toString())
                                              .toDouble(),
                                          child: Container(
                                            color: Color.fromARGB(
                                                255, 234, 197, 167),
                                            width: int.parse(
                                                    element['kotak9_width']
                                                        .toString())
                                                .toDouble(),
                                            height: int.parse(
                                                    element['kotak9_height']
                                                        .toString())
                                                .toDouble(),
                                            // ...
                                          ),
                                        )
                                      : Container(),
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
        ),
      ),
    );
  }
}
