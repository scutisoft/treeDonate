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

class MyTreesPage extends StatefulWidget {
  VoidCallback voidCallback;
  MyTreesPage({required this.voidCallback});

  @override
  _MyTreesPageState createState() => _MyTreesPageState();
}

class _MyTreesPageState extends State<MyTreesPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

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
                    height: 180,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left:50,
                              child: Image.asset('assets/Slice/pngwing1.png',width: 50,)
                          ),
                          Positioned(
                              top: 110,
                              left:50,
                              child: Image.asset('assets/Slice/pngwing.png',width: 50,)
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                 child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
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
                                    width: SizeConfig.screenWidth!,

                                    padding: const EdgeInsets.only(left: 10.0,),
                                    child: Text('My Donated\nTrees Status',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: SizeConfig.screenHeight!-200,
                    width: SizeConfig.screenWidth!*1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 6,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx,i){
                        return GestureDetector(
                          onTap: (){
                            // Get.to(CertificateView());
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
                                              child: Text('EGF 2th Anniversary',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
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
                                    child: Image.asset('assets/trees/tree-10.png',)
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
