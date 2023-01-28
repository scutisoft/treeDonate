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

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

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
          backgroundColor: Color(0XFFFAFAF8),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Stack(
                children:[
                  Column(
                    children: [
                      Container(
                        height: 250,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(onPressed: (){
                                      assignWidgets();
                                      Get.back();
                                      //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                                    },
                                        icon: Icon(Icons.arrow_back_ios_new_sharp,color:ColorUtil.themeBlack)
                                      //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(width: SizeConfig.screenWidth!-170,

                                      padding: const EdgeInsets.only(left: 10.0,),
                                      child: Text('HCL 25th\nAnniversary',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10.0,),
                                      width: SizeConfig.screenWidth!-170,
                                      child: Row(
                                        children: [
                                          Image.asset('assets/Slice/potplant.png',width: 20,),
                                          Text('10000  / ',style: TextStyle(color:ColorUtil.primary.withOpacity(0.5),fontFamily: 'RB',fontSize: 16,),),
                                          Image.asset('assets/Slice/rupees.png',width: 20,),
                                          Text('10000',style: TextStyle(color:ColorUtil.primary.withOpacity(0.5),fontFamily: 'RB',fontSize: 16,),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10.0,),
                                      width: SizeConfig.screenWidth!-130,
                                      child: Row(
                                        children: [
                                          Image.asset('assets/Slice/leaficon.png',width: 30,),
                                          Text('Growth 95% ',style: TextStyle(color:ColorUtil.primary.withOpacity(0.5),fontFamily: 'RB',fontSize: 14,),),
                                          Image.asset('assets/Slice/heart.png',width: 30,),
                                          Text('Health 100%',style: TextStyle(color:ColorUtil.primary.withOpacity(0.5),fontFamily: 'RB',fontSize: 14,),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 250,
                                  width:SizeConfig.screenWidth!-240,
                                  child:   Image.asset('assets/Slice/tree.png',fit: BoxFit.cover,)
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        height: SizeConfig.screenHeight!-265,
                        width: SizeConfig.screenWidth!*1,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: (){
                                // Get.back();
                              },
                              child: Container(
                                width: SizeConfig.screenWidth,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(left:15,right: 15),
                                decoration: BoxDecoration(
                                    color: ColorUtil.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                alignment: Alignment.center,
                                child: Text('a living thing that grows in the ground and usually has leaves, a long thin green central part (a stem) and roots.',style: TextStyle(fontFamily: 'RR',color: ColorUtil.primary,fontSize: 14),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset('assets/Slice/certificate.png'),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -10,
                    child: Container(
                      height: 70,
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: ColorUtil.primary,
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.share_outlined,color: ColorUtil.themeWhite,),
                              SizedBox(width: 5,),
                              Text('Share',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                            ],
                          ),
                          Container(
                            width: 1,
                            color: ColorUtil.themeWhite,
                          ),
                          Row(
                            children: [
                              Icon(Icons.save_alt_outlined,color: ColorUtil.themeWhite,),
                              SizedBox(width: 5,),
                              Text('Download',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                            ],
                          ),
                        ],
                      ),
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
