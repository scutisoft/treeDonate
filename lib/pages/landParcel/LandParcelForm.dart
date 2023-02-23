import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/language.dart';
import '../../widgets/calculation.dart';
import '../../widgets/loader.dart';
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
  bool isEdit;
  String dataJson;
  Function? closeCb;
  LandParcelForm({this.closeCb,this.dataJson="",this.isEdit=false});

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
  String page="LandDetails";
  var node;
  var isKeyboardVisible=false.obs;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
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
                  pinned: false,
                  leading: ArrowBack(
                    iconColor: ColorUtil.themeBlack,
                    onTap: (){
                      Get.back();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    //expandedTitleScale: 1.8,
                    title: Container(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Language.landParcel,style: TextStyle(color:ColorUtil.themeBlack,fontFamily: Language.boldFF,fontSize: 18,),textAlign: TextAlign.left,),
                          Text(Language.form,style: TextStyle(color:ColorUtil.themeBlack,fontFamily: Language.regularFF,fontSize: 12,),textAlign: TextAlign.left,)
                        ],
                      ),
                    ),
                    background: Image.asset('assets/trees/green-pasture-with-mountain.jpg',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  child:  ListView(
                    shrinkWrap: true,
                    //  physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 10,),
                      widgets[0],
                      widgets[1],
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5],
                      Row(
                        children: [
                          Container(
                              //height: 60,
                              width: SizeConfig.screenWidth!*0.5,
                              child: widgets[6]),
                          Container(
                              //height: 60,
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
                      const SizedBox(height: 15,),
                      widgets[14],

                      const SizedBox(height: 80,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Obx(() => Container(
                    margin: const EdgeInsets.only(top: 0,bottom: 0),
                    height: isKeyboardVisible.value?0:70,
                    width: SizeConfig.screenWidth,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: ColorUtil.primary),
                              color: ColorUtil.primary.withOpacity(0.3),
                            ),
                            child:Center(child: Text(Language.cancel,style: ts16(ColorUtil.primary,), )) ,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            sysSubmit(widgets,
                                isEdit: widget.isEdit,
                                successCallback: (e){
                                  console("sysSubmit $e");
                                  if(widget.closeCb!=null){
                                    widget.closeCb!(e);
                                  }
                                }
                            );
                          },
                          child: Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: ColorUtil.primary,
                            ),
                            child:Center(child: Text(Language.save,style: ts16(ColorUtil.themeWhite,), )) ,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                ShimmerLoader()
              ],
            ),
          ),
        )
    );
  }

  double scrollPadding=10;

  @override
  void assignWidgets() async{
    widgets.add(SearchDrp2(map:  {"dataName":"LandTypeId","hintText":Language.selLandType,"labelText":Language.landType},hasInput: true,required: true,));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: Language.ownerStaff,
      scrollPadding: scrollPadding,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: Language.phoneNo,
      scrollPadding: scrollPadding,
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
      required: false,
      labelText: Language.email,
      scrollPadding: scrollPadding,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//3
    widgets.add(SearchDrp2(map:  {"dataName":"TypeOfSoilId","hintText":Language.selSoilType,"labelText":Language.soilType},required: false,));//4
    widgets.add(AddNewLabelTextField(
      dataname: 'SurveyNo',
      hasInput: true,
      required: false,
      labelText: Language.surveyNo,
      scrollPadding: scrollPadding,
      regExp: MyConstants.addressRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//5
    widgets.add(AddNewLabelTextField(
      dataname: 'Hectare',
      hasInput: true,
      required: true,
      labelText: Language.hectare,
      textInputType: TextInputType.number,
      regExp: MyConstants.digitDecimalRegEx,
      scrollPadding: scrollPadding,
      onChange: (v){
        double hectare=parseDouble(v);
        double acre=Calculation().mul(hectare, 2.471);
        foundWidgetByKey(widgets, "Acre",needSetValue: true,value: acre);
      },
      onEditComplete: (){
        node.unfocus();
      },
    ));//6
    widgets.add(AddNewLabelTextField(
      dataname: 'Acre',
      hasInput: true,
      required: true,
      labelText: Language.acre,
      scrollPadding: scrollPadding,
      textInputType: TextInputType.number,
      regExp: MyConstants.digitDecimalRegEx,
      onChange: (v){
        double acre=parseDouble(v);
        double hectare=(acre/2.471);
        foundWidgetByKey(widgets, "Hectare",needSetValue: true,value: hectare);
      },
      onEditComplete: (){
        node.unfocus();
      },
    ));//7
    widgets.add(SearchDrp2(map:  {"dataName":"DistrictId","hintText":Language.selDistrict,"labelText":Language.district,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":const EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
        }
    ));//8
    widgets.add(SearchDrp2(map:  {"dataName":"TalukId","hintText":Language.selTaluk,"labelText":Language.taluk,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":const EdgeInsets.all(0.0)},
        onchange: (e){
      fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id'],toggleRequired: true);
    })); //9
    widgets.add(SearchDrp2(map:  {"dataName":"VillageId","hintText":Language.selVillage,"labelText":Language.village,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":const EdgeInsets.all(0.0)},));//10
    widgets.add(AddNewLabelTextField(
      dataname: 'LandAddress',
      hasInput: true,
      required: false,
      labelText: Language.landAddress,
      scrollPadding: 300,
      regExp: MyConstants.addressRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//11
    widgets.add(
        HE_LocationPicker(
          dataname: "AddressDetail",
          contentTextStyle: ts15(addNewTextFieldText),
          content: Language.address,
          hasInput: true,
          required: false,
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
    );//12
    widgets.add(SearchDrp2(map:  {"dataName":"PlantingYearId","hintText":Language.selPlantingYr,"labelText":Language.plantingYr,"mode":Mode.DIALOG,"dialogMargin":const EdgeInsets.all(0.0)},));//13

    widgets.add( MultiImagePicker(
      dataname: "LandImagesList",
      hasInput: true,
      required: false,
      folder: "Land",
    ));//14

    widgets.add(HiddenController(dataname: "LandParcelId"));


    setState(() {});
    await parseJson(widgets, getPageIdentifier(),dataJson: widget.dataJson);
    console(valueArray);
  }

  @override
  String getPageIdentifier(){
    return General.addLandParcelIdentifier;
  }
}
