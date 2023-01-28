import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';


class NurseryForm extends StatefulWidget {
  @override
  _NurseryFormState createState() => _NurseryFormState();
}

class _NurseryFormState extends State<NurseryForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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
                          Text('Nursery',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
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
                  widgets[6],
                  widgets[7],
                  widgets[8],
                  widgets[9],
                  widgets[10],
                  widgets[11],
                  widgets[12],
                  widgets[13],
                  widgets[14],
                  widgets[15],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 60,
                          width: SizeConfig.screenWidth!-117,
                          child: widgets[16],),
                      Container(
                        height: 45,
                        width:100,
                        margin: EdgeInsets.only(top:10,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: ColorUtil.primary),
                          color: ColorUtil.primary.withOpacity(0.3),
                        ),
                        child:Center(child: Text('+ Add',style: TextStyle(fontSize: 16,color: ColorUtil.themeWhite,fontFamily:'RR'), )) ,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Table(
                      // defaultColumnWidth: FixedColumnWidth(80.0),
                      border: TableBorder.all(
                          color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                      children: [
                        TableRow(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Planting Name',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No of Plants',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Action',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                            ]
                        ),
                        tableView('veembu','13',ColorUtil.greyBorder,ColorUtil.themeBlack),
                      ],
                    ),
                  ),
                  Container(
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
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "Nursery Name",
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
      labelText: "Nursery Incharge",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
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
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "Email",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "Address",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select District"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Taluk"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Village"},));
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
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select Electricity"},));
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select Fencing"},));
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select  Facility"},));
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select Land Ownership"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "No of Targets",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "No of Stocks",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select Plant"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'No of trees',
      hasInput: true,
      required: true,
      labelText: "No of Plant",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));





    setState(() {});
    await parseJson(widgets, General.addVolunteerIdentifier);
  }
  TableRow tableView(String tabelHead,String tablevalue,Color textcolor1,Color textcolor2 ){
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tabelHead,style: TextStyle(fontSize: 15,fontFamily: 'RR',color: textcolor1),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tablevalue,style: TextStyle(fontSize: 15,fontFamily: 'RM',color: textcolor1),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline,color: ColorUtil.red,),
              ],
            ),
          ),
        ]
    );
  }
}
