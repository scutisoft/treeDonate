import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/logoPicker.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../utils/utils.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


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
          backgroundColor: const Color(0XFFF3F3F3),
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
                  widgets[14],

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
                        GestureDetector(
                          onTap: (){
                            sysSubmit(widgets);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: ColorUtil.primary,
                            ),
                            child:Center(child: Text('Done',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                          ),
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
    widgets.add(SearchDrp2(map: const {"dataName":"LandTypeId","hintText":"Select Land Type"},));//0
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
    ));//1
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
    ));//2
    widgets.add(AddNewLabelTextField(
      dataname: 'Email',
      hasInput: true,
      required: true,
      labelText: "Email",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//3
    widgets.add(SearchDrp2(map: const {"dataName":"TypeOfSoilId","hintText":"Select Soil Type"},));//4
    widgets.add(AddNewLabelTextField(
      dataname: 'SurveyNo',
      hasInput: true,
      required: true,
      labelText: "Enter Survey Number",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//5
    widgets.add(AddNewLabelTextField(
      dataname: 'Hectare',
      hasInput: true,
      required: true,
      labelText: "Hectare",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//6
    widgets.add(AddNewLabelTextField(
      dataname: 'Acre',
      hasInput: true,
      required: true,
      labelText: "Acer",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//7
    widgets.add(SearchDrp2(map: const {"dataName":"DistrictId","hintText":"Select District"},));//8
    widgets.add(SearchDrp2(map: const {"dataName":"TalukId","hintText":"Select Taluk"},)); //9
    widgets.add(SearchDrp2(map: const {"dataName":"VillageId","hintText":"Select Village"},));//10
    widgets.add(AddNewLabelTextField(
      dataname: 'LandAddress',
      hasInput: true,
      required: true,
      labelText: "Land Address",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//11
    widgets.add(
        HE_LocationPicker(
          dataname: "AddressDetail",
          contentTextStyle: ts15(addNewTextFieldText),
          hasInput: true,
          required: true,
          //isEnabled: !isView,
          locationPickCallback: (addressDetail){
            console("locationPickCallback $addressDetail");
           /* try{
              setFrmValues(widgets,
                  [
                    {
                      "key":"City",
                      "value":addressDetail['Locality']
                    },
                    {
                      "key":"State",
                      "value":addressDetail['State']
                    },
                    {
                      "key":"Zipcode",
                      "value":addressDetail['PostalCode']
                    }
                  ]
              );

            }catch(e){}*/
          },
        )
    );;//12
    widgets.add(SearchDrp2(map: const {"dataName":"PlantingYearId","hintText":"Select Planting Year","mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//13

    widgets.add( MultiImagePicker(
      dataname: "LandImagesList",
      hasInput: true,
      required: true,
      folder: "Land",
    ));//14

    widgets.add(HiddenController(dataname: "LandParcelId"));


    setState(() {});
    await parseJson(widgets, General.addLandParcelIdentifier);
  }
}
