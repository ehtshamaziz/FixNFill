import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_fill/Auth//signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/login_controller.dart';


class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


  String selectedOption = 'User';
  List<String> dropdownOptions = ['User','Admin','Station','Shop','Rider'];
  final controller=Get.put(LoginController());
  final _formkey=GlobalKey<FormState>();
  String error="";

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(25.w,50.h,25.w,25.h),
            child: Center(
              child:Form(
                key: _formkey,
              child: Column(
                  children: <Widget>[
                    Image.asset('assets/Car_Pic.png',width: 250.w, height:100.h),
                    const Padding(padding: EdgeInsets.only(top:50)),
                    Text('Login',style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(
                        'FixNFill',
                        style: GoogleFonts.oswald(textStyle:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38.sp,
                            color: Theme.of(context).primaryColor),
                        )),
                    SizedBox(height:20.h),
                    DropdownButton<String>(
                      // initialSelection: dropdownOptions.first,
                        dropdownColor: Colors.white,
                        value: selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue!;
                          });
                        },
                        items: dropdownOptions.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    TextFormField(
                        controller: controller.email,
                      decoration:InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                        labelText:"Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),

                          ),focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0.w),
                        borderRadius: BorderRadius.circular(5.0.w),
                      )

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        final emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null; // Return null if the input is valid
                      },

                    ),
                     SizedBox(height: 20.h),
                    TextFormField(
                        controller: controller.password,
                      obscureText: _obscurePassword,
                        decoration:InputDecoration(
                          contentPadding:  EdgeInsets.fromLTRB(20.0.w,15.0.h, 20.0.w,15.0.h),
                            labelText:"Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0.h),

                            ),focusedBorder: OutlineInputBorder(
                          borderSide:
                           BorderSide(color: Colors.lightBlueAccent, width: 2.0.w),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                           suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),



                        ),


                    ),
                    SizedBox(height: 20.h),
                    if(error != "")
                      Text(
                        error as String,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ,
                    SizedBox(height: 10.h),

                    MaterialButton(
                      onPressed: () async {
    if (_formkey.currentState!.validate()) {


      String? err= await LoginController.instance.login(controller.email.text.trim(), controller
          .password.text.trim(), selectedOption);
      setState(() {

        error = err!;
      });
    }
                      },
                      minWidth: double.infinity,
                      height: 50.h,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,

                      child: Text('Login'.toUpperCase(),
                      style:  TextStyle(
                        fontSize: 20.sp,
                      )),


                    ),

                     SizedBox(height: 20.h),

                     Text('OR',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),

                    Row(
                      children: [

                         Padding(padding: EdgeInsets.only(left:70.w)),
                         Text('Dont have an account?',style:TextStyle(


                        )),
                         Padding(
                          padding: EdgeInsets.only(left: 0), // Adjust the padding as needed
                        ),
                        MaterialButton(
                          onPressed: () {

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup(),)
                              ,);

                          },
                          height: 10.h,
                          textColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.only(left:10.w),
                          minWidth: 50.w,
                          child:  Text('Sign up',style: TextStyle(
                            fontSize: 18.sp,
                          )),
                        )],
                    )


                  ]
              ),
              ),
            ),
          ),
        )

    );
  }
}
