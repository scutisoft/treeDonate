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

class AddVolunteer extends StatefulWidget {
  @override
  _AddVolunteerState createState() => _AddVolunteerState();
}

class _AddVolunteerState extends State<AddVolunteer> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    height: 250,
                    child: Container(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:140,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(onPressed: (){
                                    assignWidgets();
                                       Get.back();
                                  },
                                      icon: Icon(Icons.arrow_back_ios_new_sharp,color:ColorUtil.themeBlack)
                                    //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Save Trees \n10,00,000',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
                                        Text('31-Dec-2022 \n09:30 Am',style: TextStyle(color:ColorUtil.text5,fontFamily: 'RR',fontSize: 14,height: 1.4),),
                                        SizedBox(height: 10,),
                                        Text('Chennai',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 24),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,width: SizeConfig.screenWidth!-140,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                    child: Text('Volunteer Information',style: TextStyle(fontSize: 14,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: SizeConfig.screenHeight!-350,
                    width: SizeConfig.screenWidth!*1,
                    child:  ListView(
                      children: [
                        widgets[0],
                        widgets[1],
                        widgets[2],
                        widgets[3],
                        widgets[4],
                        widgets[5],
                        widgets[6],

                       Padding(
                         padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10,bottom: 10),
                         child: Row(
                           children: [
                             Row(
                               children: [
                                 Container(
                                   width: 20,
                                   height: 20,
                                   decoration: BoxDecoration(
                                       border:Border.all(color: ColorUtil.primary,width: 1.0),
                                       borderRadius: BorderRadius.circular(50)
                                   ),
                                   child: Container(
                                     padding: EdgeInsets.all(10),
                                     width: 10,
                                     height: 10,
                                     decoration: BoxDecoration(
                                       shape:BoxShape.circle,
                                       color: ColorUtil.primary,
                                       border:Border.all(color:Colors.white,width: 3.0),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 10,),

                                 Text('NGO',style: TextStyle(fontSize: 15,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                               ],
                             ),
                             SizedBox(width: 30,),
                             Row(
                               children: [
                                 Container(
                                   width: 20,
                                   height: 20,
                                   decoration: BoxDecoration(
                                       border:Border.all(color: ColorUtil.primary.withOpacity(0.5),width: 1.0),
                                       borderRadius: BorderRadius.circular(50)
                                   ),
                                   child: Container(
                                     padding: EdgeInsets.all(10),
                                     width: 10,
                                     height: 10,
                                     decoration: BoxDecoration(
                                       shape:BoxShape.circle,
                                       color: ColorUtil.primary.withOpacity(0.5),
                                       border:Border.all(color:Colors.white,width: 3.0),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Text('Individual',style: TextStyle(fontSize: 15,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                               ],
                             )
                           ],
                         ),
                       ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left:15,right: 15),
                      decoration: BoxDecoration(
                          color: ColorUtil.secondary,
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      alignment: Alignment.center,
                      child: Text('Submit',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
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
    widgets.add(AddNewLabelTextField(
      dataname: 'Address',
      hasInput: true,
      required: true,
      labelText: "Address",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select District"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Zipcode',
      hasInput: true,
      required: true,
      labelText: "Zipcode",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Interest"},));
    setState(() {

    });
    await parseJson(widgets, General.addVolunteerIdentifier);
  }
}
