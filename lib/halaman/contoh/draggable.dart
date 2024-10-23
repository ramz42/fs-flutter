import 'package:flutter/material.dart';

class ContohDraggable extends StatefulWidget {
  const ContohDraggable({super.key});

  @override
  State<ContohDraggable> createState() => _ContohDraggableState();
}

class _ContohDraggableState extends State<ContohDraggable> {
  var dataDrag;

  @override
  void initState() {
    // TODO: implement initState

    print("dataDrag : $dataDrag");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ...
            Padding(
              padding: EdgeInsets.only(),
              child: DragTarget<String>(
                onAccept: (data) {
                  // setstate sebelum add data
                  setState(() {
                    // ...
                    dataDrag = data;
                  });
                  print("is accept data : $dataDrag");
                  if (dataDrag != null) {
                    print("true, color : brown");
                  } else {
                    print("false, color : not brown");
                  }
                },
                builder: (
                  BuildContext context,
                  List<Object?> candidateData,
                  List<dynamic> rejectedData,
                ) {
                  return dataDrag != null
                      ? Container(
                          color: Colors.brown,
                          width: 100,
                          height: 100,
                        )
                      : Container(
                          color: Color.fromARGB(
                            255,
                            163,
                            152,
                            119,
                          ),
                          width: 100,
                          height: 100,
                        );
                },
              ),
            ),
            Container(
              child: Draggable<String>(
                data: 'drag',
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.brown,
                ),
                feedback: Container(
                  width: 100,
                  height: 100,
                  color: Colors.brown,
                ),
                childWhenDragging: Container(
                  width: 100,
                  height: 100,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
