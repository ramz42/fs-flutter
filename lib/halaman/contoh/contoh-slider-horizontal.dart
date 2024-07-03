// ignore_for_file: unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final themeMode = ValueNotifier(2);

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          routes: {
            '/manual': (ctx) => ManuallyControlledSlider(),
          },
        );
      },
      valueListenable: themeMode,
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item,
                        fit: BoxFit.cover, width: 700.0, height: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(title: Text('Manually controlled slider')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.transparent,
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   // textStyle:
                //   //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                // ),
                onTap: () => _controller.previousPage(),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: width * 0.08,
                    height: height * 0.08,
                    child: Image(
                      image: AssetImage(
                        "assets/icons/left-arrow.png",
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.75,
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 500,
                ),
                carouselController: _controller,
              ),
            ),
            Flexible(
              child: GestureDetector(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.transparent,
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   // textStyle:
                //   //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                // ),
                onTap: () => _controller.nextPage(),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Container(
                    width: width * 0.08,
                    height: height * 0.08,
                    child: Image(
                      image: AssetImage(
                        "assets/icons/right-arrow.png",
                      ),
                    ),
                    color: Colors.transparent,
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

// multiple item demo
class MultipleItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Container(
        child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: false,
            viewportFraction: 1,
          ),
          itemCount: 4,
          itemBuilder: (context, index, realIdx) {
            final int first = 1;
            final int second = 2;
            final int third = 3;
            final int fourth = 4;
            final int fifth = 5;
            final int sixth = 6;
            final int seventh = 7;
            return Row(
              children: [first, second, third, fourth].map((idx) {
                // return Expanded(
                //   flex: 1,
                // child: Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 35),
                return Container(
                  width: width * 0.3,
                  height: height * 0.7,
                  child: Card(
                    color: Colors.black,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                      onTap: () {
                        // _saveStorage(
                        //     "Photo Booth Collage A",
                        //     '8 x Shoot Print 1 pcs, Paper Photo (4 x 6)',
                        //     1200);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         const ReviewPaymentWidget(),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Card(
                              child: Image(
                                image: NetworkImage(
                                  "http://127.0.0.1:8000/storage/background-image/sub/1710411480_1.jpg",
                                  scale: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Text(
                              "Judul $idx".toString(),
                              style: TextStyle(
                                fontSize: width * 0.02,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Text(
                              "Deskripsi",
                              style: TextStyle(
                                fontSize: width * 0.016,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Harga".toString(),
                              style: TextStyle(
                                fontSize: width * 0.016,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Waktu",
                              style: TextStyle(
                                fontSize: width * 0.016,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                // ),
                // );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
