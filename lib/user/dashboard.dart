// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_fill/Controller/notification_controller.dart';
import 'package:fix_fill/model/CartData.dart';
import 'package:fix_fill/model/ListUpdateModel.dart';
import 'package:fix_fill/model/ListedStationModel.dart';
import 'package:fix_fill/user/cart.dart';
import 'package:fix_fill/user/notification_user.dart';
import 'package:fix_fill/user/user_select_location.dart';
import 'package:fix_fill/widgets//navbar.dart';
import 'package:fix_fill/widgets/notification_icon.dart';
import 'package:fix_fill/widgets/search.dart';
import 'package:fix_fill/widgets/station_listing.dart';
import 'package:fix_fill/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Controller/shop_controller.dart';
import '../model/ListItemModel.dart';



class dashboard extends StatefulWidget {
   bool shop;
   dashboard({required this.shop});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final TextEditingController _searchController = TextEditingController();


  var controller= Get.put(ShopController());

   late LatLng selectedLocation;
  late Future<List<ListStationModel>> items;
@override
void initState(){
  super.initState();
  items=ShopController.instance.getStation(widget.shop);
}
  // Future<List<ListStationModel>> items =ShopController.instance.getStation(widget.shop);
  void _navigateAndPickLocation() async {
    // Future<List<ListStationModel>> items =ShopController.instance.getStation(widget.shop);
    //
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserGetScreen()),
    );

    if (pickedLocation != null) {
      print("Location existed");
      Future.delayed(Duration(milliseconds: 1000), ()
      {
        setState(() {
          selectedLocation = pickedLocation;
          items = ShopController.instance.getStation(widget.shop).then((
              stations) {
            for (var station in stations) {
              print("Station: ${station.name}, Lat: ${station
                  .latitude}, Lng: ${station.longitude}");
              station.distance = station.distanceTo(pickedLocation);
            }
            // Sort stations by distance
            stations.sort((a, b) => a.distance!.compareTo(b.distance as num));
            print("Helppp ${stations}");
            return stations;
          });
        });
      });
    }
  }
  final List<String> images = [
    'https://img.freepik.com/free-vector/auto-repair-online-advice-isometric-concept-with-spare-parts-pieces-vector-illustration_1284-30008.jpg?w=826&t=st=1703953283~exp=1703953883~hmac=3220cb9cd809da91054b3b00cdaa68d70f6b7ebc79dee505dcbf3af1c3777e14',
    'https://img.freepik.com/free-vector/hand-drawn-biofuel-infographic_23-2149416892.jpg?w=996&t=st=1703953326~exp=1703953926~hmac=3aa0af843a522a6c31abfabe826ec79b19bb3d38b1a436689c79840a6b4d9a57',
    'https://img.freepik.com/free-vector/car-help-isometric-concept-with-equipment-tools-vector-illustration_1284-30006.jpg?w=740&t=st=1703953383~exp=1703953983~hmac=de66efa1565ae1d29be4ba5d47135a31627c429f4f2fab1069b25ccff539b9f3',
    // Add more image URLs as needed
  ];
  @override
  Widget build(BuildContext context) {




    // notificationController.updateUser();
    final notificationController = Get.put(FirebaseNotificationController());
    return Scaffold(
      appBar: AppBar(
        title:  Text("FixNFill",
            style: GoogleFonts.oswald(
                textStyle:TextStyle(
                  fontSize: 24.0.sp, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                  // fontFamily: 'YourFontFamily', // Replace 'YourFontFamily' with the desired font family

            ))),
        actions: <Widget>[
          IconButton(
            icon: NotificationIcon(
              notificationCount: notificationController.notificationCount.value,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),

        ],
      ),
      drawer: NavBar(name:"user"),
        backgroundColor: Colors.white,
        body:CustomScrollView(
            slivers: [
        SliverToBoxAdapter( child:Container(
            padding: EdgeInsets.fromLTRB(25,5,25,25),
            child: Center(

                child: Column(
                    children: <Widget>[
                      Center(
                        child: CarouselSlider(
                          items: images.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
SizedBox(height: 20.h,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.start,


                children: <Widget>[
                      ElevatedButton(onPressed: (){

                        _navigateAndPickLocation();

                      },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h), // Adjust the padding as needed
                            ),
                              shape: MaterialStateProperty.all( ContinuousRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                              ))
                          ),
                          child: Icon(Icons.pin_drop, size: 30.0, )),


                      Expanded(
                          child: Container(
                              width: 200.0.w, // Adjust the width as needed
                              height:39.0.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.0.h),

                          child: SearchBar(
                              elevation: MaterialStateProperty.all<double>(1.0), // Wrap with MaterialStateProperty.all
                        hintText: "Search",
                              shape: MaterialStateProperty.all( ContinuousRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                              )),
                        controller: _searchController,
                        // controller: controller,
                        padding: MaterialStateProperty.all<EdgeInsets>(
                             EdgeInsets.symmetric(horizontal: 15.h)),

                        leading: const Icon(Icons.search),
                          onChanged: (value) {
                            setState(() {});
                          }
                      ))),
                      ]),

                      SizedBox(height:20.h),

                      FutureBuilder<List<ListStationModel>>(
                        future: items,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child:Text("No Station/Shop found"));
                          } else if(_searchController.text!=""){
                            String query = _searchController.text.toLowerCase();
                            List<ListStationModel> filteredStations = snapshot.data!
                                .where((station) => station.name.toLowerCase().contains(query))
                                .toList();
                            return
                              // SingleChildScrollView(
                                  Container(
                                      height: 500.h, // Adjusted height
                                      width:400.w,

                                      child: _buildStationList(filteredStations)
                                      );
    }else{
                            return
                              SingleChildScrollView(
                                  child:Container(
                                      height: 500.h, // Adjusted height
                                      width:400.w,
                                      child: ListView.builder(

                                        itemCount: snapshot.data!.length,

                                        itemBuilder: (context, index) {
                                          print("disssssssssssssssssss  ${snapshot.data![index].distance}");
                                          return
                                            ListedStation(item: snapshot.data![index],shop:widget.shop);

                                        },
                                      ),
                                  )
                              ,
                              );
                          }
                        },
                      ),









                    ]
                ),

              ),
            ),
          )
    ]),

    );



  }


}
Widget _buildStationList(List<ListStationModel> stations) {
  print("Builderr");
  return ListView.builder(
    itemCount: stations.length,
    itemBuilder: (context, index) {
      final station = stations[index];
      return GestureDetector(

          onTap: () {
            print(station);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TabBars(id:station.id)),
            );
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabBars(id:item.id)),);
          },
          child:Container(


            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
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

                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius here for your desired curve
                      image: DecorationImage(
                        image: AssetImage('assets/GasStation.jpg'), // Your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                   SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text((station.name).toString(), // Replace with item name
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (station.distance != null)
                          Text("${station.distance!.toStringAsFixed(2)} km away"),
                        SizedBox(height: 4.h),

                        // Add more widgets here if you need
                      ],

                    ),

                  ),



                ]),

          ));;
    },
  );
}