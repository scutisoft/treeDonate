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


class SeedingForm extends StatefulWidget {
  @override
  _SeedingFormState createState() => _SeedingFormState();
}

class _SeedingFormState extends State<SeedingForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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
                          Text('Seeding Details',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
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
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                      child: Text("Seed Collectin Details",style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:'RM'), )),
                  SizedBox(height: 10,),
                  widgets[0],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 60,
                          width: SizeConfig.screenWidth!-117,
                          child: widgets[1]),
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
                                child: Text('Seed Name',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Quantity',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Action',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                              ),
                            ]
                        ),
                        tableView('veembu Seed','13 Gm',ColorUtil.greyBorder,ColorUtil.themeBlack),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Seed Giver Info",style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:'RM'), )),
                  widgets[2],
                  widgets[3],
                  widgets[4],
                  widgets[5],
                  widgets[6],
                  widgets[7],
                  widgets[8],
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
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Seeds"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "Quantity",
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
      labelText: "Name",
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
      labelText: "Mobile No",
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
    widgets.add(SearchDrp2(map: const {"dataName":"District","hintText":"Select State"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select District"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Taluk"},));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Village"},));

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
