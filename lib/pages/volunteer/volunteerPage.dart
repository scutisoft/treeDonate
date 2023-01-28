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
import 'addvolunteer.dart';

class VolunteerPage extends StatefulWidget {
  VoidCallback voidCallback;
  VolunteerPage({required this.voidCallback});

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

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
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Container(
                    height: 250,
                    child: Container(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(onPressed: (){
                                  assignWidgets();
                                  widget.voidCallback();
                                  //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                                },
                                    icon: Icon(Icons.arrow_back_ios_new_sharp,color:ColorUtil.themeBlack)
                                  //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0,),
                                  child: Text('+ Add \n Volunteer',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0,),
                                  child: Text('By  which you will have the privilege of planting many saplings.......',style: TextStyle(color:ColorUtil.text5,fontFamily: 'RR',fontSize: 14,height: 1.4),),
                                ),
                              ],
                            ),
                          ),
                          Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,width: SizeConfig.screenWidth!-140,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: SizeConfig.screenHeight!-250,
                    width: SizeConfig.screenWidth!*1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx,i){
                        return GestureDetector(
                          onTap: (){
                            Get.to(AddVolunteer());
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2,left: 15,right: 15,top:i==0? 0:1),
                            padding: EdgeInsets.only(left: 15.0,right: 10.0),
                            width: SizeConfig.screenWidth!*1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFffffff),
                            ),
                            clipBehavior:Clip.antiAlias,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: SizeConfig.screenWidth!*0.40,
                                        alignment: Alignment.topLeft  ,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start ,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 3.0),
                                              child: Text('Save trees 10,00,000',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                            ),
                                            Row(
                                              children: [
                                                Text('Date :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                                Spacer(),
                                                Text('12-Dec-2022',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Plant :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                                Spacer(),
                                                Text('10,000',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Location :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                                Spacer(),
                                                Text('Chennai',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                 width: SizeConfig.screenWidth!*0.10,
                                  alignment:Alignment.topRight,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 15,
                                        height:10,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                                          color: Color(0xFFF2F3F7),
                                        ),
                                      ),
                                      Container(width: 1,height:90,color: Color(0xFFF2F3F7),),
                                      Container(
                                        width: 15,
                                        height:10,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                                          color: Color(0xFFF2F3F7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                   width: SizeConfig.screenWidth!*0.25,
                                  height: 100,
                                  alignment:Alignment.center,
                                  // color:Colors.red,
                                  child: Image.asset('assets/Slice/book.png',)
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
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
