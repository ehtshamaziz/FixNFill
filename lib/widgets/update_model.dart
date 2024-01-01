import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/model/ListUpdateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../station/shop.dart';

class UpdateItemDialog extends StatefulWidget {
  // const UpdateItemDialog({super.key});

  String items;
  bool isFuel;
  bool shop;
  //
  UpdateItemDialog({required this.items, required this.isFuel, required this.shop});

  @override
  _UpdateItemDialogState createState() => _UpdateItemDialogState();
}

class _UpdateItemDialogState extends State<UpdateItemDialog> {
  String itemName = '';
  double price = 0.0;
  int quantity = 1;
  // List<String> dropdownOptions = ['Gas', 'Disel', 'Petrol',];
  final _formkey=GlobalKey<FormState>();
  final controller= Get.put(ShopController());
  static ShopController get instance => Get.find();

  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController quantityController = TextEditingController(text: "");
  TextEditingController categoryController = TextEditingController(text: "");
  // late String selectedOption="Gas";

  String selectedOption1 = 'Diesel';
  List<String> dropdownOptions1 = ['Diesel', 'Petrol',];

  String selectedOption2 = 'Tyre';
  List<String> dropdownOptions2 = ['Tyre', 'Oil', 'Key',];
  late String selectedOption;
  late List<String> dropdownOptions;
  String selectedOption3 = 'AC Filter';
  List<String> dropdownOptions3 = ['AC Filter', 'Fan Repair', 'Lockmaker',];
  @override
  void initState() {

    super.initState();
    if(widget.isFuel==true){
      selectedOption=selectedOption1;
      dropdownOptions = dropdownOptions1;
    }else if(widget.shop==true){
      selectedOption=selectedOption3;
      dropdownOptions = dropdownOptions3;


    }else if(widget.isFuel==false){
      selectedOption=selectedOption2;
      dropdownOptions = dropdownOptions2;
    }
    ShopController.instance.getItem(widget.isFuel,widget.items.toString(),widget.shop).then((shopData) {
      setState(() {
        priceController = TextEditingController(text: shopData.price.toString());
        quantityController = TextEditingController(text: shopData.quantity.toString());
        selectedOption = shopData.category.toString();
      });
    });
  }
  Widget w() {
    if(widget.isFuel){
    return TextFormField(
      controller: quantityController,
      decoration: InputDecoration(labelText: 'Add Quantity'),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        quantity = int.tryParse(value) ?? 1;
      },
    );}
    else{
      return Text("");
    }
  }
  @override
  Widget build(BuildContext context) {

    String abc= widget.isFuel? selectedOption1:selectedOption2;
    List<String> xyz=widget.isFuel? dropdownOptions1:dropdownOptions2;
    // ShopController.instance.getItem(item.id);

    return Dialog(
      backgroundColor: Colors.white, // Set the background color to white

      child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
          padding: EdgeInsets.all(50.0.h),
          child:Form(
            key: _formkey,
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Text("Update Fuel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0.sp)
                ),
                DropdownButton<String>(
                  // initialSelection: dropdownOptions.first,
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        abc = newValue!;
                      });
                    },
                    style:  TextStyle(
                      // You can customize the text style here
                      color: Colors.black,
                      fontSize: 16.0.sp,
                    ),
                    underline: Container(
                      // You can customize the underline (border) here
                      height: 2.h,
                      color: Colors.blueAccent,
                    ),
                    isExpanded: true,
                    items: dropdownOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
                TextFormField(
                  controller: priceController,
                    decoration: const InputDecoration(labelText: 'Add Price'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      price = double.tryParse(value) ?? 0.0;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      else{
                        return null;
                      }

                    }
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Add Quantity'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    quantity = int.tryParse(value) ?? 1;
                  },
                ),
                // w(),

                SizedBox(height: 20.h),
                Row(

                  children: [
                    SizedBox(width: 20.w),

                    TextButton(

                      onPressed: () => Navigator.of(context).pop(), // Close the dialog
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        if (_formkey.currentState!.validate()) {
                          // FirebaseAuth.instance.signInWithEmailAndPassword(
                          // email: controller.email.text.trim(),
                          // password: controller.password.text.trim(),
                          // selectedOption:selectedOption);
                          // }
                          // }

// bool isFuel=true;
                          ShopController.instance.updateList(widget.isFuel,widget.items,
                            double.parse(priceController.text),
                            int.parse(quantityController.text),
                            selectedOption,
                          widget.shop);
                          Navigator.of(context).pop();
                          // setState(() {
                          //   Shop(isFuel:isFuel);
                          // });

                        }
                      },
                      // onPressed: () {
                      //   // Logic to handle 'Add' action
                      // },
                      child: Text('Update'),
                    ),

                  ],
                )

              ],
            ),)),
    );
  }
}
