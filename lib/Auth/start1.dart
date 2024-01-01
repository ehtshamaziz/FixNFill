
import 'package:fix_fill/Auth/start3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Start1 extends StatelessWidget {
  const Start1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:
      Stack(
        children: [
        // Background image
        Image.asset(
        'assets/fixman.jpg', // Replace with the actual path to your image
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Container(
        color: Colors.white12.withOpacity(0.8),
        padding: EdgeInsets.fromLTRB(0.w,50.h,0.w,0.h),
        child: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("FixNFill",
                style: GoogleFonts.oswald(
                    textStyle:TextStyle(
                     color: Theme.of(context).primaryColor,
                      fontSize: 50.sp, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Adjust the font weight as needed
                      // fontFamily: 'YourFontFamily', // Replace 'YourFontFamily' with the desired font family

                    ))),
            // Center(
            Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),

            child: Text("Stuck, due to fuel?", style: GoogleFonts.oswald(
                textStyle:TextStyle(
                  color: Color(0xFF22BCEF),
                  fontSize: 37.0.sp, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                  // fontFamily: 'YourFontFamily', // Replace 'YourFontFamily' with the desired font family

                )))
                )
                ,
                SizedBox(height: 5.0.h,),


              ],
            )
           ,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),

                  width: double.infinity,
                  height: 200.0.h, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color:  Theme.of(context).primaryColor, // Set your desired color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0.w),
                      topRight: Radius.circular(20.0.w),
                    ),
                  ),
                  child: Center(
                    child:Column(
                      children: [
                     Text("Don't worry we are at your service. \n We will deliver fuel whenever you wish",
                            textAlign: TextAlign.center, // Center the text horizontally

                            style: GoogleFonts.oswald(

                                textStyle:TextStyle(
                                  color: Colors.white,

                                  fontSize: 18.0.sp, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                  // fontFamily: 'YourFontFamily', // Replace 'YourFontFamily' with the desired font family

                                ))) ,
                        SizedBox(height: 20.h,),

                            ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Start3()));
                              },
                              style:ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Theme.of(context).primaryColor),
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 14.0.h), // Adjust the padding as needed
                                  )
                              ),



                              child: Text("Get Your Fuel",
                                  style: GoogleFonts.oswald(
                                      color:Colors.white,
                                      textStyle:TextStyle(
                                        fontSize: 20.0.sp, // Adjust the font size as needed
                                        fontWeight: FontWeight.w400, // Adjust the font weight as needed
                                        // fontFamily: 'YourFontFamily', // Replace 'YourFontFamily' with the desired font family

                                      ))),
                            )
                      ],
                    )

                  ),
                ),
              ],
            ),

          ],
        )),
      ),
    ]));
  }
}
