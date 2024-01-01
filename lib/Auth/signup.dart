import 'package:fix_fill/Auth/start1.dart';
import 'package:fix_fill/Controller/signup_controller.dart';
import 'package:fix_fill/Auth//Welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
    late String error="";

  String selectedOption = 'User';


  List<String> dropdownOptions = ['User', 'Station','Shop','Rider'];

  final controller=Get.put(SignupController());
  final _formkey=GlobalKey<FormState>();
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
                    Image.asset('assets/Car_Pic.png',width: 200.w,height: 100.h,),
                    Padding(padding: EdgeInsets.only(top:20.h)),
                    Text('Signup',style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(
                      'FixNFill',
                      style: GoogleFonts.oswald(textStyle:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color: Theme.of(context).primaryColor),
                      )),

                    DropdownButton<String>(
                        // initialSelection: dropdownOptions.first,
                        value: selectedOption,
                        dropdownColor: Colors.white,
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
                      controller: controller.name,
                        decoration:InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),

                            labelText:"Name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),

                            ),focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        )

                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null; // Return null if the input is valid
                      },

                    ),
                    SizedBox(height: 20.h),

                    TextFormField(
                      controller: controller.email,
                        decoration:InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                            labelText:"Email",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),

                            ),  focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0.w),
                          borderRadius: BorderRadius.circular(5.0),
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
                        // obscureText: true,
                        decoration:InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                          labelText:"Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        final minLengthRegExp = RegExp(r'^.{8,}$');
                        final maxLengthRegExp = RegExp(r'^.{1,15}$');
                        final capitalLetterRegExp = RegExp(r'^(?=.*[A-Z])');
                        final digitRegExp = RegExp(r'^(?=.*\d)');

                        final emailRegExp = RegExp( r'^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,15}$');
                        if (!minLengthRegExp.hasMatch(value)) {
                          return 'Password should be min of 8 ';
                        }
                        else if (!maxLengthRegExp.hasMatch(value)) {
                          return 'Password should be max of 15';
                        }
                        else if (!capitalLetterRegExp.hasMatch(value)) {
                          return 'Password should contain atleast One Capital letter';
                        }

                        else if (!digitRegExp.hasMatch(value)) {
                          return 'Password should contain One digit';
                        }


                        return null; // Return null if the input is valid
                      },


                    ),
                    SizedBox(height: 30.h),
                    MaterialButton(
                      onPressed: () async{
                        if(_formkey.currentState!.validate()){
                          print(controller.email.text);
                         String? err= await SignupController.instance.registerUser(controller.name.text.trim(),controller.email.text.trim(), controller.password.text.trim(), controller.roles.text.trim(),selectedOption);
print('Errorrr: ${err}');
                          setState(() {

                            error = err!;
                          });
                        }


                      },
                      minWidth: double.infinity,
                      height: 50,

                      child: Text('Sign up'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,

                    ),
                    if(error != "")
                      Text(
                        error! as String,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ,
                    //
            SizedBox(height: 20),

            Text('OR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            // SizedBox(height: ),
            Row(
                children: [

                  Padding(padding: EdgeInsets.only(left:90)),
                  Text('Have an account?',style:TextStyle(


                  )),
                  Padding(
                    padding: EdgeInsets.only(left: 0), // Adjust the padding as needed
                  ),
                    MaterialButton(
                      onPressed: () {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome(),)
                          ,);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>main(),)
                        //   ,);
                      },
                      height: 50.h,
                      child: Text('Login',style: TextStyle(
                        fontSize: 18,
                      )),
                      textColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(left:10),
                      minWidth: 50,
                    ),
                  // MaterialButton(
                  //   onPressed: () {
                  //
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Start1()),
                  //     );
                  //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>main(),)
                  //     //   ,);
                  //   },
                  //   height: 50.h,
                  //   child: Text('Get',style: TextStyle(
                  //     fontSize: 18,
                  //   )),
                  //   textColor: Theme.of(context).primaryColor,
                  //   padding: EdgeInsets.only(left:10),
                  //   minWidth: 50,
                  // ),


                  ]
            )],),

            ),
            ),
          ),
        )

    );

  }}