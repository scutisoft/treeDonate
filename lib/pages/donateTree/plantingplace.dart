import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treedonate/utils/sizeLocal.dart';

import '../../utils/colorUtil.dart';
import '../../widgets/searchDropdown/search2.dart';
import '../navHomeScreen.dart';


class PlantingVillagePlace extends StatefulWidget {
  const PlantingVillagePlace({Key? key}) : super(key: key);
  @override
  _PlantingVillagePlaceState createState() => _PlantingVillagePlaceState();
}

class _PlantingVillagePlaceState extends State<PlantingVillagePlace> {
  Search2 bHFloorDrp=Search2(
    dataName: "BHFloorId",
    width: SizeConfig.screenWidth,
    dialogWidth: SizeConfig.screenWidth!,
    selectWidgetHeight: 50,
    hinttext: "Select Planting Place",
    data: [
      {"Id":1,"Text":"Govt Hospital"},
      {"Id":2,"Text":"Public Place"},
      {"Id":3,"Text":"Govt Quaters"},
      {"Id":4,"Text":"Govt School"},
      {"Id":5,"Text":"Govt College"},
    ],
    showSearch: false,
    onitemTap: (i){},
    selectedValueFunc: (e){

    },
    scrollTap: (){},
    isToJson: true,
    margin: EdgeInsets.only(left: 15,right: 15,top:25,bottom: 0),
    dialogMargin: EdgeInsets.only(left: 15,right: 15,top: 5),
    selectWidgetBoxDecoration: BoxDecoration(
        border: Border.all(color: Color(0xffEBEBEB)),
            color: ColorUtil.themeWhite
    ),
  );
  late  double width,height,width2,height2;
  List<dynamic> CateringTimeSlot=[
    {"Reason":"Call not pickup",},
    {"Reason":"Customer not available",},
    {"Reason":"Customer mistake for order raised",},
  ];
  @override

  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: SizeConfig.screenHeight,
            child: Stack(
              children: [
                Container(
                    child: Image.asset('assets/login/maps.png',fit:BoxFit.contain,)
                ),
                bHFloorDrp,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            height: 120,
                            width: 100,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color:ColorUtil.primary,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/Slice/hand-leaf.png',fit:BoxFit.contain,width: 50,),
                                Text('₹10000',style: TextStyle(fontSize: 13,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                                Text('trees Donate',style: TextStyle(fontSize: 10,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _showMyDialog();
                          },
                          child: Container(
                            height: 120,
                            width: 100,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color:ColorUtil.primary,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/Slice/hand-leaf.png',fit:BoxFit.contain,width: 50,),
                                Text('Select',style: TextStyle(fontSize: 13,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                                Text('Village',style: TextStyle(fontSize: 10,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            height: 120,
                            width: 100,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color:ColorUtil.primary,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/Slice/hand-leaf.png',fit:BoxFit.contain,width: 50,),
                                Text('Select',style: TextStyle(fontSize: 13,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                                Text('Taluk',style: TextStyle(fontSize: 10,color: ColorUtil.themeWhite,fontFamily: 'RB'),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child:IconButton(
                      icon:Icon(Icons.cancel,color: Colors.red,size: 25,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text('Select Village',style: TextStyle(fontSize: 20,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 5,),
                Text('55 Village Available',style: TextStyle(fontSize: 13,color: ColorUtil.primary,fontFamily: 'RR'),),
                SizedBox(height: 20,),
                Text('Ariyalur',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Chennai',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Coimbatore',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Chennai',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Theni',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color:ColorUtil.primary,
                    ),
                    padding: EdgeInsets.only(right: 15,top: 10,bottom: 10,left:15),
                    child: Text('Done',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}