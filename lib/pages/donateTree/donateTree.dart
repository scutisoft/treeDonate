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
                Container(
                  width: SizeConfig.screenWidth,
                  height: 350,
                  color: ColorUtil.primary.withOpacity(0.3),
                  child: Container(
                      child: Column(
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ArrowBack(
                              iconColor: ColorUtil.themeBlack,
                              onTap: (){
                                widget.voidCallback();
                              },
                            ),
                            Image.asset('assets/logo.png',width: 180,fit: BoxFit.cover,),
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorUtil.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/Slice/tree-location.png',width: 30,fit: BoxFit.cover,),
                            ),
                          ],
                        ),
                        ],
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 360),
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


                    ],
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

    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
