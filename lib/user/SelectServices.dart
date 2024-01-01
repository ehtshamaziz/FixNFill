import 'package:fix_fill/Controller/cart_controller.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/CartData.dart';
import 'package:fix_fill/model/ListItemModel.dart';
import 'package:fix_fill/widgets/navbar.dart';
import 'package:fix_fill/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../model/ListedStationModel.dart';

class SideServices extends StatefulWidget {

  String id;
  bool shop;
  SideServices({required this.id, required this.shop});

  @override
  State<SideServices> createState() => _SideServicesState();
}

class _SideServicesState extends State<SideServices> {
  final controller=Get.put(CartController());
  String itemName = '';
  double price = 0.0;
  int quantity = 1;

  double totalPrice=0.0;
  String id="11";
  String category="";
  TextEditingController priceController = TextEditingController(text: "");

  bool abc=false;
  TextEditingController quantityController = TextEditingController(text: "");
  TextEditingController categoryController = TextEditingController(text: "");
  final Controller= Get.put(ShopController());
// 'Petrol' is selected by defaul
  List<Service> filteredItems = [];
  // ShopController.instance.getListUser();
  @override
  void initState() {

    super.initState();
    executeLogic();

  }

  void executeLogic() {


    ShopController.instance.getListUser(widget.id,widget.shop).then((shopData) {
      setState(() {

        filteredItems = shopData.where((item) => item.fuel == false).toList();

      });
    });
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(margin: EdgeInsets.all(4.0.w),

          padding: EdgeInsets.fromLTRB(25.w,20.h,25.w,25.h),
          child: Center(
            child: Column(
                children: <Widget>[
                  SizedBox(height:20.h),
                  Text("Services", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23.sp),),
                  Container(
                height: 400.h,
                width: 500.w,

                child:
                ListView.builder(
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
    final item = filteredItems[index];
    late String imagePath;
    if(item.category=="AC Filter"){
      imagePath='assets/AC filter.jpg';
    }else if(item.category=="Fan Repair"){
      imagePath='assets/Fan Repair.jpg';

    }else if(item.category=="Lockmaker"){
      imagePath='assets/lockmaker.jpg';

    }else if(item.category=="Tyre"){
      imagePath='assets/ChangeWheel.jpg';

    }
    else if(item.category=="Oil"){
      imagePath='assets/OilChange.jpg';

    }
    else if(item.category=="Key"){
      imagePath='assets/Keys.jpg';

    }
    int _counter=CartController.instance.getQuantity(item.id);
    return Container(
      margin: EdgeInsets.all(8.0.w),
      padding: EdgeInsets.all(8.0.h),
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
        children: <Widget>[
          Container(

            width: 70.0.w, // Set your desired width
            height: 70.0.h, // Set your desired height
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15.0.w), // Adjust the radius here for your desired curve



              image: DecorationImage(
                image: AssetImage(imagePath), // Your image asset
                fit: BoxFit.cover,
              ),

            ),
          ),
          Expanded(child:

          ListTile(

            title: Text(item.category),
            subtitle: Container(child: Row(
              children: [

                Text('Rs ${item.price}',style: TextStyle(fontSize: 11.sp)),
                SizedBox(width: 10.w,),
                Text('Quantity: ${item.quantity}',style: TextStyle(fontSize: 10.sp),),
              ],
            ),),

          )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
      setState(() {
      if (_counter > 0) {

        abc=false;
        item.inNotAvailable = false;
        _counter--;}
      CartController.instance.updateItemQuantity(item.id, _counter);
      });
      },style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(4.h), // Adjust padding to reduce the size
                  minimumSize: Size(20, 20),  // Adjust minimum size of the button
                ),
                  child: Icon(Icons.remove),

                ),
                Text(
               // ;
                  '${_counter}',
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed:(){
                    setState(() {
                      print(_counter);
                      print(item.quantity);
                      if(_counter<item.quantity) {
                        if (_counter == 0) {
                          _counter++;
                          item.inNotAvailable = false;
                          CartController.instance.addItem(CartItem(
                            id: item.id,
                            category: item.category,
                            price: item.price,
                            quantity: item.counter,
                            shopID: widget.id,
                            shop:widget.shop// or some selected quantity
                          ));
                          CartController.instance.updateItemQuantity(
                              item.id, _counter);
                        }

                        else {

                          _counter++;
                          abc=false;
                          CartController.instance.updateItemQuantity(
                              item.id, _counter);
                        }
                      }
                      else {
                        setState(() {
                          abc=true;

                        });
                        item.inNotAvailable = true;
                      }



                        // setState(() {
                        //   abc=true;
                        //
                        // });
                      // }
                    });

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(4.h), // Adjust padding to reduce the size
                    minimumSize: Size(20, 20),  // Adjust minimum size of the button
                  ),
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 10.h),
                item.inNotAvailable
                    ?

                Text(
                  "Max Reached",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontSize: 8.sp,
                  ),
                ):
                Container(),
                SizedBox(height: 10.h),
                // abc
                //     ?Text("Not ",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.red, fontSize: 10.sp),):
                // Container(),
              ]),

        ]));
    })),






                      ],

                    ),
                  )

            ),









    );

  }
}
