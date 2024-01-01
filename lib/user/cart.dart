import 'package:fix_fill/Controller/cart_controller.dart';
import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/CartData.dart';
import 'package:fix_fill/user/checkout.dart';
import 'package:fix_fill/widgets/navbar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_reactive_widget/flutter_reactive_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {

  @override
  void initState(){
    super.initState();
    CartController.instance.groupedItems;
  }

  var controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
        drawer: NavBar(name:"users"),
        backgroundColor: Colors.white,
        body:
        GetBuilder<CartController>(
          builder: (controller) {
            final groupedItems = CartController.instance.groupedItems;
            CartController.instance.reloadFlag;

            if (groupedItems.isEmpty) {

              return  Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18.0.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              );
            }
            return ListView.builder(

              itemCount: CartController.instance.groupedItems.keys.length,
              itemBuilder: (context, index) {
                String stationId = CartController.instance.groupedItems.keys
                    .elementAt(index);
                List<CartItem> stationItems = CartController.instance
                    .groupedItems[stationId]!;
                bool isShop = stationItems.isNotEmpty
                    ? stationItems.first.shop
                    : false;



                double stationTotal = stationItems.fold(0, (sum, item) {
                  sum = sum + (item.price * item.quantity);
                  return sum;
                });

                return ExpansionTile(
                  title: FutureBuilder<String>(
                    future: ShopController.instance.getStationName(
                        stationId, isShop),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                            'Loading...'); // or any other placeholder you prefer
                      }

                      else {
                        return Text(
                          'Station/Shop: ${snapshot.data}',

                        );

                      }
                    },
                  ),
                  children: <Widget>[
                    ...stationItems.map((item) =>
                        ListTile(
                          title: Text(item.category),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Text('${item.price}'),
                        )).toList(),
                    ListTile(
                      // stationTotal.toString()
                      title: Text("Station Total = ${stationTotal.toString()}"),
                      trailing: ElevatedButton(
                          onPressed: () {
                            // Handle checkout logic for this station
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Checkout(total: stationTotal,
                                      stationId: stationId,
                                      isShop: isShop)),
                            );
                          },
                          child: Text("Proceed To Checkout")
                      ),
                    ),
                  ],


                );
                // });


              },


            );
            // )


          }
          )
    );
  }}
  //   }
  //   );
  // }













