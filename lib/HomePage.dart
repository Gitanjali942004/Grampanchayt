import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grampanchayat/AboutUs.dart';
import 'package:grampanchayat/CheckRequest.dart';
import 'package:grampanchayat/ContactUs.dart';
import 'package:grampanchayat/EditProfile.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/main.dart';
import 'package:grampanchayat/MyDrawer.dart';

class HomePage extends StatelessWidget {
  final String selectedRole;

  const HomePage({Key? key, required this.selectedRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Selected Role: $selectedRole"); // Print selectedRole
    return MaterialApp(
      home: ImageSlider(selectedRole: selectedRole),
      routes: {
        '/home':(context) => HomePage(selectedRole: selectedRole),
        '/request': (context) => RequestForm(selectedRole: selectedRole),
        '/checkrequest':(context) => CheckRequest(),
        '/aboutus':(context) => AboutUs(),
        '/contactus':(context) => ContactUs(),
        '/editprofile':(context) => EditProfile(selectedRole: selectedRole),

      },

    );

  }
}

class ImageSlider extends StatefulWidget {
  final String selectedRole;

  const ImageSlider({Key? key, required this.selectedRole}) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState(selectedRole: selectedRole);
}

class _ImageSliderState extends State<ImageSlider> {
  final String selectedRole;

  _ImageSliderState({required this.selectedRole});

  int _currentIndex = 0;
  CarouselController _controller = CarouselController();

  final List<String> images = [
    'assets/images/g1.jpg',
    'assets/images/g2.jpg',
    'assets/images/g3.jpg',
    'assets/images/g4.jpg',
    'assets/images/g5.jpg',
    'assets/images/g6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double aspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height - 100);

    return Scaffold(
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Grampanchayat App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "ग्रामपंचायत पोतले",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF0B2447),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Stack(
            children: [
              Center(
                child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height - 100,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    aspectRatio: aspectRatio,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1.0,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: images.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFA5D7E8),
                          ),
                          child: Image.asset(
                            item,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 20,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    _controller.previousPage();
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 20,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    _controller.nextPage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: MyDrawer(
      selectedRole: selectedRole,
      onNavigation: (route) {
        Navigator.pushNamed(context, route); // Navigate to selected route
      },
    ),
    );
  }
}
