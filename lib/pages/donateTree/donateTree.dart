import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/widgets/customAppBar.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../navHomeScreen.dart';
import '../ourEvents/events.dart';

class DonateTreePage extends StatefulWidget {
  VoidCallback voidCallback;
  DonateTreePage({required this.voidCallback});

  @override
  _DonateTreePageState createState() => _DonateTreePageState();
}

class _DonateTreePageState extends State<DonateTreePage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{



  int selectedTreeCount=0;
  int selectedTreeImg=1;
  List<dynamic> Trees=[
    {"Text":"01 Trees",},
    {"Text":"10 Trees",},
    {"Text":"100 Trees",},
  ];

  List<Widget> widgets=[];

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }
  FocusNode _focusNode = FocusNode();
  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: ColorUtil.primary,
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/Slice/Donate-bg.jpg'),fit:BoxFit.cover,)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom:-70,
                          // right: 0,
                            left: -20,
                           child: Image.asset('assets/Slice/tree-animation.gif',fit: BoxFit.cover,height: 400,)),
                        Positioned(
                          top: 230,
                            left: 20,
                            child:Image.asset('assets/Slice/falling-leaves.gif',fit: BoxFit.cover,height: 100,)
                        ),
                        Positioned(
                            top: 230,
                            right: 20,
                            child:Transform.scale(
                                scaleX: -1,
                                child: Image.asset('assets/Slice/falling-leaves.gif',fit: BoxFit.cover,height: 100,)
                            ),
                        ),
                        Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ArrowBack(
                                iconColor: ColorUtil.themeBlack,
                                onTap: (){
                                  widget.voidCallback();
                                },
                              ),
                              Image.asset('assets/logo.png',width: 180,fit: BoxFit.cover,),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    fadeRoute(PlantingVillagePlace());
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorUtil.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset('assets/Slice/tree-location.png',width: 30,fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight!-350,
                   // margin: EdgeInsets.only(top: 350),
                    decoration: BoxDecoration(
                        color: ColorUtil.themeWhite,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          color: ColorUtil.primary,
                          margin: EdgeInsets.only(left: 20,right: 20),
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5, bottom: 5),
                          child: Text('நம் மரம் நம் கடமை',style: TextStyle(fontSize: 14,color: ColorUtil.themeWhite,fontFamily: 'RM'),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Text('Someone Setting in the shade today because someone planted a tree a long time ago',style: TextStyle(fontSize: 18,color: ColorUtil.themeBlack,fontFamily: 'RB'),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            width: SizeConfig.screenWidth,
                            height: 80,
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
                                      color:ColorUtil.greyLite,
                                    ) ,
                                    margin: EdgeInsets.only(right: 10,top: 10,bottom: 10,left: i==0?15:0),
                                    padding: EdgeInsets.only(right: 20,top: 15,bottom: 15,left:20),
                                    alignment: Alignment.center,
                                    child:  Text(Trees[i]['Text'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==selectedTreeCount? Colors.white:Color(0xff959595))),
                                  ),
                                );
                              },
                            )
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: ColorUtil.greyLite,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                                 Container(
                                   width: 60,
                                   height: 60,
                                   alignment: Alignment.center,
                                   child: Text('₹',style: TextStyle(fontSize: 24,color: ColorUtil.primary,fontFamily: 'RB'),),
                                 ),
                              Container(
                                width: 1,
                                height: 50,
                                margin: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xffE3E4E8),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth!-117,
                                height: 60,
                                padding: EdgeInsets.only(left: 10),
                                child: TextField (
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Custom Number of Tree',
                                      labelStyle: TextStyle(
                                        color: _focusNode.hasFocus ? ColorUtil.primary : ColorUtil.text4,
                                      ),
                                      hintText: 'Custom Number of Tree'
                                  ),
                                ),
                              )
                          ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  setPageNumber(5);
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ColorUtil.primary.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Image.asset('assets/Slice/tree-event.png',fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth!-110,
                                height: 60,
                                  margin: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorUtil.primary,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                padding: EdgeInsets.only(left: 10),
                                child: Text('PAY ₹ 750.00',style: TextStyle(fontSize: 18,color: ColorUtil.themeWhite,fontFamily: 'RB'),)
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();

    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
