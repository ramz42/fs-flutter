import 'package:flutter/material.dart';

class ScrollWidget extends StatefulWidget {
  const ScrollWidget({super.key});

  @override
  State<ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 1,
      height: height * 1,
      color: Colors.grey,
      // child: Container(
      //   color: Colors.white,
      //   width: 150,
      //   height: 200,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          // ...
          child: Container(
            color: Colors.black,
            width: 150,
            height: 200,
            child: Wrap(
              verticalDirection: VerticalDirection.down,
              alignment: WrapAlignment.center,
              spacing: width * 0.01,
              runSpacing: width * 0.01,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    color: Colors.cyan,
                    width: 70,
                    height: 70,
                  ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
