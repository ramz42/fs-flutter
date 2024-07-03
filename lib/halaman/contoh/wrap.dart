import 'package:flutter/material.dart';

class WrapWidget extends StatefulWidget {
  const WrapWidget({super.key});

  @override
  State<WrapWidget> createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  // ...
  final ScrollController controller = ScrollController();

  // ...
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Container(
            width: width * 1,
            height: height * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.08,
                  height: width * 0.08,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/left-arrow.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.75,
                  height: width * 0.85,
                  // color: Colors.green,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        // verticalDirection: VerticalDirection.,
                        // hor
                        spacing: width * 0.035,
                        runSpacing: width * 0.15,
                        children: [
                          for (var i = 0; i < 10; i++)
                            Container(
                              width: width * 0.25,
                              height: width * 0.35,
                              color: Colors.white,
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  onTap: () {
                                    // ...
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.blueGrey,
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
                Container(
                  width: width * 0.08,
                  height: width * 0.08,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/right-arrow.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
