import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_fill/Controller/notification_controller.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String userrUid = FirebaseAuth.instance.currentUser!.uid;
    print(userrUid);

    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<NotificationModel>>(
        future: ShopController.instance.fetchUserNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No notifications!!",style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.5)),));
          }

          List<NotificationModel> notifications = snapshot.data!;

          if (notifications.isEmpty) {
            return Center(child: Text("No notifications"));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index];
              return Column(children: [
              ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.description),
              // Trailing with formatted dateTime
              ),
              Divider(),

              ],);
            },
          );
        },
      ),
    );
  }
}




