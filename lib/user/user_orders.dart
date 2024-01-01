import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  State<UserOrders> createState() => _UserOrdersState();
}


var controller =Get.put(ShopController());
String formatTimestamp(Timestamp timestamp) {
  var format = DateFormat('yyyy-MM-dd – kk:mm');
  return format.format(timestamp.toDate());
}


class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      backgroundColor: Colors.white,
      drawer: NavBar(name:"users"),
      body:GetBuilder<ShopController>(
        builder: (controller) {

  ShopController.instance.reloadFlags.value;
      return FutureBuilder<List<Map<String, dynamic>>>(
        future:  ShopController.instance.UserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No orders found",  style: TextStyle(fontSize: 18.0.sp,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            )));
          }

          List<Map<String, dynamic>> orders = snapshot.data!;



          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> order = orders[index];
              // String formattedDate = formatTimestamp(order['timestamp']);
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0,3),
                        )
                      ]

                  ),
                // elevation: 2,
                margin: EdgeInsets.all(30.w),
                child: Padding(
                  padding: EdgeInsets.all(40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Order Detail:",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.green),
                          SizedBox(width: 8.w),
                          Text("Status: ${order['Status']}", style: TextStyle(fontSize: 16.sp)),
                        ],
                      ),
                      Divider(height: 10.h, thickness: 1),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.blue),
                          SizedBox(width: 8.w),
                          Text("Total Price: ${order['totalPrice']} Rs", style: TextStyle(fontSize: 16.sp)),
                        ],
                      ),
                      Divider(height: 10.h, thickness: 1),
                      SizedBox(height: 20.h,),

                      Row(
                        children: [
                          Icon(Icons.delivery_dining, color: Colors.orange),
                          SizedBox(width: 8.w),
                          Text("Rider Status: ${order['RiderStatus']}", style: TextStyle(fontSize: 16.sp)),
                        ],
                      ),
                      Divider(height: 10.h, thickness: 1),
                      SizedBox(height: 20.h,),

                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.red),
                          SizedBox(width: 8.w),
                          Expanded(child: Text("Address: ${order['Address']}", style: TextStyle(fontSize: 16.sp))),
                        ],
                      ),
                      Divider(height: 10.h, thickness: 1),
                      SizedBox(height: 20.h,),


                    ],
                  ),
                ),
              );

            },
          );
        },
      );}),
    );
  }
}