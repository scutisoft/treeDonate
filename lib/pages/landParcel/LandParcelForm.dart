import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';


class LandParcelForm extends StatefulWidget {
  @override
  _LandParcelFormState createState() => _LandParcelFormState();
}

class _LandParcelFormState extends State<LandParcelForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  List<Widget> widgets=[];
  ScrollController? silverController;
  @override
  void initState(){
    silverController= ScrollController();
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
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: true,
                  snap: true,
                  pinned: true,
                  leading: ArrowBack(
                    iconColor: ColorUtil.themeBlack,
                    onTap: (){
                      Get.back();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    //expandedTitleScale: 1.8,
                    title: Container(
                      height: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Land Parcel',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                          Text('Form',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'R',fontSize: 12,),textAlign: TextAlign.left,)
                        ],
                      ),
                    ),
                    background: Image.asset('assets/trees/green-pasture-with-mountain.jpg',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body:Container(
              height: SizeConfig.screenHeight,
              child:  ListView(
                children: [
                  widgets[0],
                  widgets[1],
                  widgets[2],
                  widgets[3],
                  widgets[4],
                  widgets[5],
                  Row(
                    children: [
                      Container(
                          height: 60,
                          width: SizeConfig.screenWidth!*0.5,
                          child: widgets[6]),
                      Container(
                          height: 60,
                          width: SizeConfig.screenWidth!*0.5,
                          child: widgets[7]),
                    ],
                  ),
                  widgets[8],
                  widgets[9],
                  widgets[10],
                  widgets[11],
                  widgets[12],
                  widgets[13],
                  GestureDetector(
                    onTap: ()async{
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15,left: 15,top: 10),
                      width: SizeConfig.screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: ColorUtil.primary),
                        color: ColorUtil.primary.withOpacity(0.3),
                      ),
                      child:Center(child: Text('Upload Image',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.primary,fontFamily:'RR'), )) ,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth!*0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: ColorUtil.primary),
                            color: ColorUtil.primary.withOpacity(0.3),
                          ),
                          child:Center(child: Text('Cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.primary,fontFamily:'RR'), )) ,
                        ),
                        Container(
                          width: SizeConfig.screenWidth!*0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ColorUtil.primary,
                          ),
                          child:Center(child: Text('Done',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select Land Type"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "Owner / Staff",
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
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Soil Type"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Zipcode',
      hasInput: true,
      required: true,
      labelText: "Enter Survey Number",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Enter OTP',
      hasInput: true,
      required: true,
      labelText: "Acer",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Enter OTP',
      hasInput: true,
      required: true,
      labelText: "Hectare",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Enter OTP',
      hasInput: true,
      required: true,
      labelText: "Planting Scheme",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Planting Year"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select District"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Village"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Taluk"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Enter OTP',
      hasInput: true,
      required: true,
      labelText: "Location",
      suffixIcon: Icon(Icons.location_searching,color: ColorUtil.primary,),
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    setState(() {});
    await parseJson(widgets, General.addVolunteerIdentifier);
  }
}
