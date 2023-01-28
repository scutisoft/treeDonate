import 'dart:convert';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/pages/landParcel/LandParcelForm.dart';
import 'package:treedonate/pages/landParcel/LandParcelViewPage.dart';
import 'package:treedonate/pages/planting/plantingForm.dart';
import 'package:treedonate/pages/planting/plantingViewPage.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../Filter/FilterItems.dart';
import 'seedingForm.dart';
import 'seedingViewPage.dart';


class SeedingGrid extends StatefulWidget {
  VoidCallback voidCallback;
  SeedingGrid({required this.voidCallback});
  @override
  _SeedingGridState createState() => _SeedingGridState();
}

class _SeedingGridState extends State<SeedingGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();
  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }

  var node;

  double cardWidth=0.0;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: true,
                  snap: true,
                  pinned: false,
                  leading: GestureDetector(
                      onTap: (){
                        widget.voidCallback();
                      },
                      child: Icon(Icons.arrow_back_ios_new_sharp,color: ColorUtil.themeBlack,size: 25,)
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('Seeding',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                    //background: FlutterLogo(),
                  ),
                ),
              ];
            },
            body:Container(
             // height: SizeConfig.screenHeight,
              padding: EdgeInsets.only(left: 10.0, right: 10.0,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimSearchBar(
                        width: SizeConfig.screenWidth!-130,
                        color: ColorUtil.primary,
                        boxShadow: false,
                        textController: textController,
                        onSubmitted: (a){},
                        onSuffixTap: () {
                          setState(() {
                            textController.clear();
                          });
                        },
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          fadeRoute(FilterItems());
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtil.primary,
                          ),
                          child: Icon(Icons.filter_alt_outlined,color:ColorUtil.themeBlack,),
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                                  onTap: (){
                                    fadeRoute(SeedingForm());
                                  },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtil.primary,
                          ),
                          child: Icon(Icons.add,color:ColorUtil.themeBlack),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                   // height: SizeConfig.screenHeight,
                   // width: cardWidth,
                    child: ListView.builder(
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx,i){
                        return GestureDetector(
                          onTap: (){
                            // Get.to(CertificateView());
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: i==9?50:2,left: 0,right: 0,top:i==0? 0:1),
                            padding: EdgeInsets.only(left: 15.0,right: 10.0),
                            width: cardWidth+25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFffffff),
                            ),
                            clipBehavior:Clip.antiAlias,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: cardWidth*0.6,
                                  alignment: Alignment.topLeft  ,
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start ,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 3.0),
                                        child: Text('EarLeaf Acacia,Rusuty Acacia',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Name : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                         // Spacer(),
                                          Text('Bala',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Mobile No  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        //  Spacer(),
                                          Text('8695650493',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Status : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                          // Spacer(),
                                          Flexible(child: Text('Approved',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 15,
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
                                    width: cardWidth*0.4,
                                    alignment:Alignment.center,
                                    // color:Colors.red,
                                    child:  Column(
                                      crossAxisAlignment:CrossAxisAlignment.end,
                                      children: [
                                        Text('Seed Qty ',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                                        Text('50.00',style: ColorUtil.textStyle18),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                fadeRoute(SeedingView());
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                alignment:Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorUtil.primary.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.primary,size: 20,),
                                                //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){

                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                alignment:Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorUtil.primary.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Icon(Icons.edit,color: ColorUtil.themeBlack,size: 20,),
                                                //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){

                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                alignment:Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorUtil.primary.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Icon(Icons.delete_outline,color: ColorUtil.red,size: 20,),
                                                //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
        )
    );
  }

  @override
  void assignWidgets() async{

    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
