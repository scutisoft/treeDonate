import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/innerShadowTBContainer.dart';

class DonatePage extends StatefulWidget {
  VoidCallback voidCallback;
  DonatePage({required this.voidCallback});

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{



  int selectedTreeCount=0;
  int selectedTreeImg=1;
  List<dynamic> Trees=[
    {"Text":"01 Trees","Value":1},
    {"Text":"10 Trees","Value":10},
    {"Text":"100 Trees","Value":100},
    {"Text":"Custom Trees",},
  ];

  List<Widget> widgets=[];

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              children:[

                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: widgets[0],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child:  widgets[1]
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 20),
                          child: Text('Doner Details',style: TextStyle(fontSize: 14,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                        ),
                        widgets[2],
                        widgets[3],
                        widgets[4],
                        widgets[5],

                        // Container(
                        //   height: 52,
                        //   width:150,
                        //   padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                        //   child: TextField(
                        //     maxLines: 1,
                        //     textAlignVertical: TextAlignVertical.bottom,
                        //     cursorColor:ColorUtil.text4,
                        //     style: TextStyle(fontSize: 16, fontFamily: "RR"),
                        //     decoration: InputDecoration(
                        //       filled: true,
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(25)),
                        //         borderSide: BorderSide(
                        //           width: 0.2,
                        //           color:ColorUtil.primary,
                        //         ),
                        //       ),
                        //       focusColor: ColorUtil.text4,
                        //       hintText: "Custom Tree",
                        //       fillColor: Color(0xffF8F8FA),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(25)),
                        //         borderSide: BorderSide(
                        //           width: 0.2,
                        //           color: ColorUtil.text4,
                        //         ),
                        //       ),
                        //
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 20),
                          child: Text('Donate trees',style: TextStyle(fontSize: 14,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                        ),
                        Container(
                            width: SizeConfig.screenWidth,
                            height: 60,
                            //  padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: Trees.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx,i){
                                return  GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedTreeCount=i;
                                      selectedTreeImg=Trees[i]['Value'];
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                    decoration:i==selectedTreeCount? BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:ColorUtil.primary.withOpacity(0.5),
                                          blurRadius: 5.0, // soften the shadow
                                          spreadRadius: 2, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            2.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      color:ColorUtil.primary,
                                    ):BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                      color:Color(0xffF8F8FA),
                                    ) ,
                                    margin: EdgeInsets.only(right: 10,top: 10,bottom: 10,left: i==0?10:0),
                                    padding: EdgeInsets.only(right: 15,top: 10,bottom: 10,left:15),
                                    alignment: Alignment.center,
                                    child:  Text(Trees[i]['Text'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==selectedTreeCount? Colors.white:Color(0xff959595))),
                                  ),
                                );
                              },
                            )
                        ),
                        Container(
                          height: 200,
                          alignment: Alignment.center,
                         // color: ColorUtil.red,
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('₹23',style: TextStyle(fontSize: 24,color: ColorUtil.themeBlack,fontFamily: 'RB'),),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Container(
                                        decoration:BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:ColorUtil.primary,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(Icons.location_on_outlined,color: ColorUtil.themeWhite,),
                                      ),
                                      SizedBox(width: 5,),
                                      Text('Select Location',style: TextStyle(fontSize: 14,color: ColorUtil.primary,fontFamily: 'RB'),)
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  GestureDetector(
                                    onTap: () async{
                                      fadeRoute(PlantingVillagePlace());
                                      //console( jsonEncode(await getFrmCollection(widgets)));
                                    },
                                    child: Container(
                                      decoration:BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:ColorUtil.primary.withOpacity(0.5),
                                            blurRadius: 5.0, // soften the shadow
                                            spreadRadius: 2, //extend the shadow
                                            offset: Offset(
                                              2.0, // Move to right 10  horizontally
                                              2.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                        color:ColorUtil.primary,
                                      ),
                                      padding: EdgeInsets.only(right: 15,top: 10,bottom: 10,left:15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.wallet,color: ColorUtil.themeWhite,),
                                          SizedBox(width: 5,),
                                          Text('Donate Now',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset('assets/trees/tree-$selectedTreeImg.png',fit: BoxFit.cover,width: 170,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  color: ColorUtil.primary,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          assignWidgets();
                          widget.voidCallback();
                        },
                            icon: Icon(Icons.grid_view_rounded,color:ColorUtil.themeWhite)
                          //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 15.0),
                            child:   Text('Donate',style: TextStyle(fontSize: 18,color: ColorUtil.themeWhite,fontFamily: 'RB'),)
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    widgets.add(HE_Text(dataname: "PageTitle", contentTextStyle: ts18(ColorUtil.primary,fontfamily: 'RB',fontsize: 18),content: "Hello",));
    widgets.add(HE_Text(dataname: "PageSubTitle", contentTextStyle: ts14(ColorUtil.text4)));
    widgets.add(SearchDrp2(map: const {"dataName":"Occasion","hintText":"Select Occasion"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "Name",
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "Mobile Number",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Email',
      hasInput: true,
      required: true,
      labelText: "Email",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
