
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/rider/orderDetail_screen.dart';
import 'package:fix_fill/widgets//navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class RiderMyOrders extends StatefulWidget {
  const RiderMyOrders({Key? key}) : super(key: key);

  @override
  State<RiderMyOrders> createState() => _RiderMyOrdersState();
}


class _RiderMyOrdersState extends State<RiderMyOrders> {
  var controller =Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order's"),
      ),
      drawer: NavBar(name:"rider"),
      body: GetBuilder<ShopController>(
        builder: (controller) {
          ShopController.instance.reloadFlags.value;
          return FutureBuilder<List<Map<String, dynamic>>>(
        future: ShopController.instance.fetchRiderMyOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No orders found", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))));
          }

          List<Map<String, dynamic>> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> order = orders[index];
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

                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Order:",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.green),
                          SizedBox(width: 8.w),
                          Text("Status: ${order['Status']}", style: TextStyle(fontSize: 16)),

                          SizedBox(width: 45.w,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order)));
                            },
                            style: ButtonStyle(
                              // Change the background color
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold), // Change the text style
                              ),
                              elevation: MaterialStateProperty.all<double>(4.0), // Change the elevation
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0.w), // Change the border radius
                                ),
                              ),
                            ),
                            child: Text("Show Detail"),
                          ),
                        ],
                      ),
                      // Divider(height: 10, thickness: 1),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.blue),
                          SizedBox(width: 8.w),
                          Text("Total Price: ${order['totalPrice']} Rs", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 35.w,),





                        ],
                      ),
                      // Divider(height: 10, thickness: 1),
                      SizedBox(height: 20.h,),


                    ],
                  ),
                ),
              );
            },

          );

        },
      );
        }),
    );
  }
}
