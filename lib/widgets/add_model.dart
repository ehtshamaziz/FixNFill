import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../station/shop.dart';

class AddItemDialog extends StatefulWidget {
  bool isFuel;
  bool shop;

   AddItemDialog({super.key,required this.isFuel, required this.shop});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String itemName = '';
  double price = 0.0;
  int quantity = 1;
  String selectedOption1 = 'Diesel';
  List<String> dropdownOptions1 = ['Diesel', 'Petrol',];

  String selectedOption2 = 'Tyre';
  List<String> dropdownOptions2 = ['Tyre', 'Oil', 'Key',];

  String selectedOption3 = 'AC Filter';
  List<String> dropdownOptions3 = ['AC Filter', 'Fan Repair', 'Lockmaker',];
  late String selectedOption;
  late List<String> dropdownOptions;

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

  }
  final _formkey=GlobalKey<FormState>();
  final controller= Get.put(ShopController());
  static ShopController get instance => Get.find();

  Widget w() {
    if (widget.isFuel) {
      /// any other task
      return TextFormField(
            decoration: InputDecoration(labelText: 'Add Quantity'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              quantity = int.tryParse(value) ?? 1;
            },
          );
    }
    else{
      return Text("");
    }
  }
  @override
  Widget build(BuildContext context) {


    return Dialog(
      backgroundColor: Colors.white, // Set the background color to white

      child: Container(
        // width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        padding: EdgeInsets.all(50.0.h),
          child:Form(
            key: _formkey,
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (widget.shop)?(
            Text("Add New Service")
            ):(
                Text("Add New Fuel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0.sp)
        )
            // const
            ),
            DropdownButton<String>(

                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption= newValue!;
                  });
                },
                style: TextStyle(
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
              decoration: InputDecoration(labelText: 'Add Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                quantity = int.tryParse(value) ?? 1;
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

            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 30.w,),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // Close the dialog
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_formkey.currentState!.validate()) {


                      ShopController.instance.add(widget.isFuel,price,quantity, selectedOption, widget.shop);
                      Navigator.of(context).pop();


                    }
                  },

                  child: Text('Add'),
                ),
              ],
            )

          ],
        ),)),
    );
  }
}
