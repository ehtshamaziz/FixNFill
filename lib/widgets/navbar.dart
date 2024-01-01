import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_fill/Auth/Welcome.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/ListedUsersModel.dart';

import 'package:fix_fill/user/notification_user.dart';
import 'package:fix_fill/user/userdetail.dart';
import 'package:fix_fill/widgets/privacy_policy.dart';
import 'package:fix_fill/widgets/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';





class NavBar extends StatefulWidget {
String name;
   NavBar({required this.name});


  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late String email="";
  late bool images=false;
  late String? path;
  late String imagePath;

  // final controller = Get.put(FirebaseNotificationController());
  var controller= Get.put(ShopController());

  @override
  void initState() {

    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email ?? '';
      user.email ?? ''; // Set the email in the text field
      // _passwordController.text=user.password??'';
      int indexOfUnderscore = email.indexOf("_");

      // Check if "_" is found
      if (indexOfUnderscore != -1) {
        // Use substring to get the part of the string after "_"
        String result = email.substring(indexOfUnderscore + 1);

        email = result;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<ListUserModel?> items =ShopController.instance.getUserDetail().then((data){
      if(data?.imageProfileURL != null){
        images=true;
        path=data?.imageProfileURL.toString();

      }
    });
    if(images==true){
      imagePath=path!;
    }
    else{
      imagePath='assets/user.jpg';
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
      child:Padding(
          padding: EdgeInsets.only(left: 10.0.w),
            child:Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  'User Info',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height:5.h),

                Container(
// margin: EdgeInsets.fromLTRB(10, 0, 0, 0),

                  width: 50.0.w, // Set your desired width
                  height: 50.0.h, // Set your desired height
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15.0.w), // Adjust the radius here for your desired curve



                    image: DecorationImage(
                      image: AssetImage(imagePath), // Your image asset
                      fit: BoxFit.cover,
                    ),

                  ),
                ),
                SizedBox(height:8.h),

                Text(

                  "${email}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 5.h,)
              ],
            ))

          ),
          ListTile(
            title: Text('Notifications'),
            leading: Icon(Ionicons.notifications),

            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationPage()));

              // Navigate to the Home Page
              // Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(

            title: Text('Settings'),
            leading: Icon(Ionicons.settings_outline),

            onTap: () {
              // Navigate to the Settings Page (You can replace it with your own route)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailsScreen(name:widget.name)),
              );// Close the drawer
            },
          ),
          ListTile(
            title: Text('Terms and Condition'),
            leading: Icon(Ionicons.list),

            onTap: () {
              // Navigate to the Settings Page (You can replace it with your own route)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Terms(name:widget.name)),
              );// Close the drawer
            },
          ),
          ListTile(
            title: Text('Our Privacy Policy'),
            leading: Icon(Ionicons.lock_closed),

            onTap: () {
              // Navigate to the Settings Page (You can replace it with your own route)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy(name:widget.name)),
              );// Close the drawer
            },
          ),

          ListTile(
            title: Text('Logout'),
            leading: Icon(Ionicons.log_out),

            onTap: () {

              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
              // final notificationController = Get.put(FirebaseNotificationController());
              // notificationController.updateUser();
              // notificationController.updateUser();

              // Navigate to the Settings Page (You can replace it with your own route)
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
  }

