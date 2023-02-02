import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/volunteer/viewVolunteer.dart';
import 'package:treedonate/utils/utils.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/loader.dart';
import '../../widgets/recase.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/navigationBarIcon.dart';
import '../landParcel/LandParcelViewPage.dart';
import 'addvolunteer.dart';

class VolunteerPage extends StatefulWidget {
  VoidCallback voidCallback;
  VolunteerPage({super.key, required this.voidCallback});

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

  List<Widget> widgets=[];

  List<dynamic> volunteerList=[];
  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  var node;

  double cardWith=0.0;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWith=SizeConfig.screenWidth!-(55+30);
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
                                NavBarIcon(
                                  onTap:  (){
                                    //assignWidgets();
                                    widget.voidCallback();
                                  },
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0,),
                                  child: Text('Volunteer',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
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
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: volunteerList.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx,i){
                            return GestureDetector(
                              onTap: null,
                              child: Container(
                                margin: EdgeInsets.only(bottom: i==volunteerList.length-1? 30:3,left: 15,right: 15),
                                padding: const EdgeInsets.only(left: 15.0,right: 10.0),
                                width: SizeConfig.screenWidth!*1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0XFFffffff),
                                ),
                                clipBehavior:Clip.antiAlias,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: cardWith*0.65,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start ,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(child: Text('${volunteerList[i]['VolunteerName']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                                          const SizedBox(height: 3,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Date :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                              Text('${volunteerList[i]['JoinedDate']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Phone No :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                              Text('${volunteerList[i]['VolunteerContactNo']}',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Location :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                              Text(volunteerList[i]['DistrictName'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Spacer(),
                                    Container(
                                      width: 30,
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
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: cardWith*0.35,
                                            height: 50,
                                            alignment:Alignment.center,
                                            // color:Colors.red,
                                            child: Image.asset('assets/Slice/DefaultVolunteer.png',)
                                        ),
                                        const SizedBox(height: 5,),
                                        EyeIcon(
                                          onTap: (){
                                            fadeRoute(VolunteerView());
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        NoData(show: volunteerList.isEmpty,)
                      ],
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
    getData({});
  }

  void getData(dataJson) async{
    await parseJson(widgets, General.volunteerDetailIdentifier,dataJson: jsonEncode(dataJson));
    volunteerList=valueArray.where((element) => element['key']=="VolunteerList").toList()[0]['value'];
    setState(() {});
  }
}
