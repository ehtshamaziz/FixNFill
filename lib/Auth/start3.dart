import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Welcome.dart';

class Start3 extends StatefulWidget {
  @override
  _Start3State createState() => _Start3State();
}

class _Start3State extends State<Start3> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                KeepAlivePage(
                  imagePath: 'assets/petrol-del.jpg',
                  title: "Best Quality Fuel",
                  description: "Don't worry we are at your service. \n We will deliver fuel whenever you wish.",
                  currentPage: _currentPage,
                  pageController: _pageController,
                ),
                KeepAlivePage(
                  imagePath: 'assets/repair.jpg',
                  title: "We will fix it as well.",
                  description: "We will fix it fast and make it last. \n So take a chill pill & let us Fix N Fill.",
                  currentPage: _currentPage,
                  pageController: _pageController,
                ),
                KeepAlivePage(
                  imagePath: 'assets/pay2.jpg',
                  title: "Online Payment.",
                  description: "Short on time? Pay with a click. \n Anytime, anywhere!",
                  currentPage: _currentPage,
                  pageController: _pageController,
                ),
              ],
            ),
          ),
          Container(
            height: 80.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: _currentPage == 0 ? Colors.blue : Colors.grey,
                  radius: 8.0.w,
                ),
                SizedBox(width: 16.0.w), // Adjust the spacing between circles as needed
                CircleAvatar(
                  backgroundColor: _currentPage == 1 ? Colors.blue : Colors.grey,
                  radius: 8.0.w,
                ),
                SizedBox(width: 16.0.w),
                CircleAvatar(
                  backgroundColor: _currentPage == 2 ? Colors.blue : Colors.grey,
                  radius: 8.0.w,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0.h),



        ],
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final int currentPage;
  final PageController pageController;

  KeepAlivePage({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.pageController,
  });

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.white24.withOpacity(0.7),
      padding: EdgeInsets.fromLTRB(5.w, 50.h, 5.w, 25.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "FixNFill",
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Column(
            //   children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.0.h),
                Align(
                    alignment: Alignment.center,
                    child:Text(
                  widget.title,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xFF22BCEF),
                      fontSize: 30.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                SizedBox(height: 10.0.h),
                Center(
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0.sp,

                      ),
                    ),
                  ),
                ),
              // ],
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.currentPage < 2) {
                    widget.pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome()), // Replace SignUpPage with your actual signup page class
                    );
                    // Navigate to the next screen or perform any action
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 14.0.h),
                  ),
                ),
                child: Text(
                  widget.currentPage == 2 ? "Get Started".toUpperCase(): "Next".toUpperCase(),
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w400,
                    ),
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
