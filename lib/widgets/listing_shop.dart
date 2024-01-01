import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/constants.dart';
import 'package:fix_fill/station/shop.dart';
import 'package:fix_fill/widgets/bottom_nav_bar.dart';
import 'package:fix_fill/widgets/update_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/ListItemModel.dart';

import 'package:ionicons/ionicons.dart';
class ListedShop extends StatelessWidget {
  // const Listed({Key? key}) : super(key: key);

  final ListItemModel item;
final bool isFuel;
bool shop;
  ListedShop({required this.item,required this.isFuel, required this.shop});


  Widget w(){
    if(isFuel==true){

      return Text((item.quantity).toString(), // Replace with item details
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      );
    }
    else{
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {

    // print(item.price);
    return GestureDetector(
        onTap: () {
          print('Tapped!');
        },
        child:Container(
          margin: EdgeInsets.all(8.0.w),
          padding: EdgeInsets.all(16.0.h),
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
          child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  width: 70.0.w, // Set your desired width
                  height: 70.0.h, // Set your desired height
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15.0.w), // Adjust the radius here for your desired curve
                    image: DecorationImage(
                      image:isFuel
                          ?AssetImage('assets/petrol.jpg'):AssetImage('assets/service.jpg'), // Your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                 SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((item.category).toString(), // Replace with item name
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(("${item.price} Rs").toString(), // Replace with item details
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      item.quantity==0
                          ?Text("Quantity is 0, please update",style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]))
                      :Text(("${item.quantity} qty").toString(), // Replace with item details
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),

                     // w(),

                      // Add more widgets here if you need
                    ],

                  ),

                ),
                IconButton(
                  icon:const Icon(Ionicons.pencil),
                  color: Colors.blue,
                  onPressed: () {
                   // ShopController.instance.getItem(item.id);
                    _showUpdateItemModal(context,items: item.id,isFuel:isFuel,shop:shop);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Shop(isFuel:isFuel, shop:shop,)));

                    // (UpdateItemDialog( items: item.id));
                  },
                ),
                IconButton(
                  icon:const Icon(Ionicons.trash_bin),
                  color: Colors.red,
                  onPressed: () {

                    ShopController.instance.delete(item.id,shop);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Shop(isFuel:isFuel,shop: false,)));



                  },
                ),


              ]),

        ));
  }
}
void _showUpdateItemModal(BuildContext context, {required bool isFuel, required String items, required bool shop}) {
  // showModalBottomSheet
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UpdateItemDialog(items:items,isFuel:isFuel, shop:shop);
    },
  );
}
