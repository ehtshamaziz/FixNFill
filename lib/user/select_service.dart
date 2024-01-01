
import 'package:fix_fill/Controller/cart_controller.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/CartData.dart';
import 'package:fix_fill/user/cart.dart';
import 'package:fix_fill/widgets/navbar.dart';
import 'package:fix_fill/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SelectService extends StatefulWidget {

  String id;
  SelectService({required this.id});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  final controller=Get.put(CartController());
  String itemName = '';
  double price = 0.0;
  int quantity = 1;
  int _counter = 0;
  double totalPrice=0.0;
  String id="11";
String category="";
  TextEditingController priceController = TextEditingController(text: "");

  TextEditingController quantityController = TextEditingController(text: "");
  TextEditingController categoryController = TextEditingController(text: "");
  final Controller= Get.put(ShopController());
  List<bool> isSelected = [true, false]; // 'Petrol' is selected by defaul
 bool abc=false;
  @override
  void initState() {

    super.initState();
    executeLogic();

  }

  void executeLogic() {

    ShopController.instance.getListUser(widget.id,false).then((shopData) {
      setState(() {
        for(int i=0;i<shopData.length;i++) {
          if(isSelected[0] && shopData[i].category=="Petrol"){
            _counter=0;
            totalPrice=0.0;
            print("uop");
            // if(shopData[i].category=="Petrol") {
            category=shopData[i].category;
            id=shopData[i].id;
            price = shopData[i].price;
            quantity=shopData[i].quantity;
            // quantityController=  TextEditingController(text: shopData[i].quantity.toString());

            // }
          }

          else if(isSelected[1] && shopData[i].category=="Diesel"){
            _counter=0;
            totalPrice=0.0;

            // if() {
            category=shopData[i].category;

            id=shopData[i].id;
            price = shopData[i].price;
            quantity=shopData[i].quantity;
            // quantityController=  TextEditingController(text: shopData[i].quantity.toString());

            // }
          }
          // quantityController = TextEditingController(text: shopData[0].quantity.toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
print("Hellooo ${id}");

    void _incrementCounter() {
      if(_counter<quantity && quantity>0){
        abc=false;
        setState(() {

          _counter++;
          print(price);
          totalPrice=price.toDouble()*_counter.toDouble();
          print(totalPrice);
          print(_counter);
          });
      }
      else{
        setState(() {
          abc=true;
        });


        print("This service is not available now");
      }
    }

    void _decrementCounter() {
      if(_counter>0){
        abc=false;
        setState(() {
          totalPrice=totalPrice-price.toDouble();
          _counter--;
        });
      }

    }



    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.fromLTRB(50.w,20.h,50.w,25.h),
        child: Center(
          child: Column(
              children: <Widget>[

                Container(

                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(10.0.w),
                    border: Border.all(
                    color: Colors.black, // Specify the color of the border
                    width: 1.0, // Specify the width of the border
                  ),


                  ),
                  child:Column(

              children: <Widget>[
                SizedBox(height: 30.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    ToggleButtons(
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                          executeLogic();
                          // Handle your logic based on the selected index here
                        });
                      },
                      color: Colors.blue,
                      selectedColor: Colors.white,
                      fillColor: Colors.blue,
                      borderRadius: BorderRadius.circular(4.0.w),
                      children:  <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Ionicons.water, size: 24), // Smaller icon
                              Text('Petrol'),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Ionicons.water, size: 36.sp), // Larger icon
                              Text('Diesel'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Other widgets...
                  ],
                ),

                SizedBox(height: 30.h,),


                Text('Price is: $price'),
                Text("Select Your Quantity"),
                SizedBox(height: 10.h),
Container(
    decoration: BoxDecoration(
      // shape: BoxShape.circle,
      borderRadius: BorderRadius.circular(10.0.w),
      border: Border.all(
        color: Colors.black, // Specify the color of the border
        width: 0.5.w, // Specify the width of the border
      ),),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // Text('$price'),
      ElevatedButton(
        onPressed: _decrementCounter,
        child: Icon(Icons.remove),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(4), // Adjust padding to reduce the size
          minimumSize: Size(20, 20),  // Adjust minimum size of the button
        ),
      ),
      SizedBox(width: 10.w),
      Text(
        '$_counter',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 10.w),

      ElevatedButton(
        onPressed: _incrementCounter,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(4), // Adjust padding to reduce the size
            minimumSize: Size(20, 20),  // Adjust minimum size of the button
          ),
        child: Icon(Icons.add),
      )]) ,)


              ],
          )
                  ,),

                SizedBox(height: 30.h),

                Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      abc
                  ?Text("Max quantity reached",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.red, fontSize: 15),):
                    Container(),
                      // ===========================
                      SizedBox(height: 10.h),
                      Container(

                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.black, // Specify the color of the border
                    width: 0.5.w, // Specify the width of the border
                  ),),
                        child: Row(

                          children: [

                            SizedBox(width: 60.w,),
                             Text(
                              'Total:',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            SizedBox(width: 50.w),
                            Text(
                              ' $totalPrice Rs',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ],
                        ),
                      ),

SizedBox(height: 20.h,),
                      ElevatedButton.icon(
                        onPressed: () {

                            // CartItem product={id: id, category:"fad", price: price, quantity: quantity} as CartItem;
                            // ... more products
                          // ];
if(totalPrice>0){
  CartController.instance.addItem(CartItem(
    id: id,
    category: category,
    price: price,
    quantity:  _counter,
    shopID:widget.id,
    shop:false
    // or some selected quantity
  ));
  setState(() {
    totalPrice=0.0;
    _counter=0;
    // CartScreen();
    CartController.instance.groupedItems;
    // CartScreen();
  });


}

                        },
                        icon: Icon(Ionicons.cart), // The icon you want on your button
                        label: Text('Add'), // The text label for your button
                        style: ElevatedButton.styleFrom(

                          primary: Colors.blue, // Button color
                          onPrimary: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 80.0.w, vertical: 10.0.h),
                        ),
                      ),



                    ],

                  ),
                )]

          ),



      )


      ),


      );

  }
}
