import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/loader.dart';
import '../../widgets/logoPicker.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


class PlantingForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  PlantingForm({this.closeCb,this.dataJson="",this.isEdit=false});
  @override
  _PlantingFormState createState() => _PlantingFormState();
}

class _PlantingFormState extends State<PlantingForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }
  RxList<dynamic> SeedTreeMasterList = RxList<dynamic>();
  var node;

  String page="PlantationDetails";
  var isKeyboardVisible=false.obs;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
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
                          Text('Plantation',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                          Text('Form',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'R',fontSize: 12,),textAlign: TextAlign.left,)
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
                  child: ListView(
                    children: [
                      widgets[0],
                      widgets[1],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 60,
                              width: SizeConfig.screenWidth!-98,
                              child: widgets[2]
                          ),
                          GestureDetector(
                            onTap: (){
                              onPlantCollectionAdd();
                            },
                            child: Container(
                              width:80,
                              height: 45,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: ColorUtil.primary),
                                color: ColorUtil.primary.withOpacity(0.3),
                              ),
                              child:Center(child: Text('+ Add',style: TextStyle(fontSize: 16,color: ColorUtil.primary,fontFamily:'RR'), )) ,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Obx(() => Table(
                          defaultColumnWidth: FixedColumnWidth(80.0),
                          border: TableBorder.all(
                              color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                          children: [
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('S.No',style: TextStyle(fontSize: 15,fontFamily: 'RR',color:ColorUtil.themeBlack ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Tree Name',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('No of Trees',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Action',style: TextStyle(fontSize: 15,fontFamily: 'RM',color:ColorUtil.themeBlack ),),
                                  ),
                                ]
                            ),
                            for(int i=0;i<SeedTreeMasterList.length;i++)
                              TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all( 8.0),
                                      child: Text("${i+1}",style: TextStyle(fontSize: 15,fontFamily: 'RM',color: ColorUtil.greyBorder ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${SeedTreeMasterList[i]['TreeName']}",style: TextStyle(fontSize: 15,fontFamily: 'RR',color: ColorUtil.greyBorder),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${SeedTreeMasterList[i]['Quantity']}",style: TextStyle(fontSize: 15,fontFamily: 'RM',color: ColorUtil.greyBorder),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          GridDeleteIcon(hasAccess: true,onTap: (){SeedTreeMasterList.removeAt(i);},),
                                        ],
                                      ),
                                    ),
                                  ]
                              ),
                          ],
                        )),
                      ),Obx(() => NoData(topPadding: 15,show: SeedTreeMasterList.isEmpty,)),

                      widgets[3],
                      widgets[4],
                      widgets[5],
                      widgets[6],
                      widgets[7],
                      widgets[8],
                      widgets[9],
                      widgets[10],

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
                            child:Center(child: Text('Cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.primary,fontFamily:'RR'), )) ,
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
                                },
                                needCustomValidation: true,
                                onCustomValidation: (){
                                  if(SeedTreeMasterList.isEmpty){
                                    CustomAlert().cupertinoAlert("Select Plant...");
                                    return false;
                                  }
                                  else{
                                    foundWidgetByKey(widgets, "SeedTreeMasterList",needSetValue: true,value: SeedTreeMasterList);
                                  }
                                  return true;
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
                            child:Center(child: Text('Save',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
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

  @override
  void assignWidgets() async{
    widgets.add(SearchDrp2(map: const {"dataName":"SourceId","hintText":"Select Source","labelText":"Source","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "SeedTreeMasterId",page: page,refId: e['Id']);
        },
      hasInput: false,required: false,
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"SeedTreeMasterId","hintText":"Select Plant","labelText":"Plant","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},hasInput: false,required: false,));

   // widgets.add(SearchDrp2(map: const {"dataName":"ProjectId","hintText":"Select Plant"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'No of trees',
      hasInput: false,
      required: false,
      labelText: "No of Plants",
      textInputType: TextInputType.number,
      regExp: MyConstants.digitRegEx,
      textLength: 10,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    widgets.add(SearchDrp2(map: const {"dataName":"DistrictId","hintText":"Select District","labelText":"District","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
        }
    ));//8
    widgets.add(SearchDrp2(map: const {"dataName":"TalukId","hintText":"Select Taluk","labelText":"Taluk","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id'],toggleRequired: true);
        })); //9
    widgets.add(SearchDrp2(map: const {"dataName":"VillageId","hintText":"Select Village","labelText":"Village","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//10
    widgets.add(SearchDrp2(map: const {"dataName":"LandOwnershipId","hintText":"Land Ownership","labelText":"Land Ownership",},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Place',
      hasInput: true,
      required: true,
      labelText: "Place",
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(
        HE_LocationPicker(
          dataname: "AddressDetail",
          contentTextStyle: ts15(addNewTextFieldText),
          hasInput: true,
          required: true,
          //isEnabled: !isView,
          locationPickCallback: (addressDetail){
          },
        )
    );
    widgets.add(SearchDrp2(map: const {"dataName":"BagMaterialSize","hintText":"Bag Material & Size","labelText":"Bag Material & Size",},));


    widgets.add( MultiImagePicker(
      dataname: "ImagesList",
      hasInput: true,
      required: false,
      folder: "Plantation",
    ));
    widgets.add(HiddenController(dataname: "PlantationId"));
    widgets.add(HiddenController(dataname: "ProjectId"));
    widgets.add(HiddenController(dataname: "SeedTreeMasterList"));


    await parseJson(widgets,getPageIdentifier(),dataJson: widget.dataJson);
    try{
      SeedTreeMasterList.value=valueArray.where((element) => element['key']=="SeedTreeMasterList").toList()[0]['value'];
    }
    catch(e,t){ assignWidgetErrorToast(e, t); }
  }

  @override
  String getPageIdentifier(){
    return General.PlantationAddFormPageViewIdentifier;
  }

  void onPlantCollectionAdd(){
    var sourceDrpDetail=widgets[0].getValueMap();
    var plant=widgets[1].getValueMap();
    var plantQty=widgets[2].getValue();

    String treeDate=DateFormat("dd-MM-yyyy").format(DateTime.now());

    if(sourceDrpDetail.isEmpty){
      CustomAlert().cupertinoAlert("Select Source");
      return;
    }
    if(plant.isEmpty){
      CustomAlert().cupertinoAlert("Select Plant");
      return;
    }
    if(parseDouble(plantQty)<=0){
      CustomAlert().cupertinoAlert("Enter Quantity");
      return;
    }

    if(SeedTreeMasterList.any((element) => element["SeedTreeMasterId"] == plant['Id'] && element["TreeDate"]==treeDate && element["SourceId"]==sourceDrpDetail["Id"])){
      CustomAlert().cupertinoAlert("Plant Name Already Exists...");
      return;
    }

    SeedTreeMasterList.add({
      "SeedTreeMasterId": plant["Id"],
      "SourceId": sourceDrpDetail["Id"],
      "NurseryName": sourceDrpDetail["Text"],
      "TreeName": plant["Text"],
      "Quantity": plantQty,
      "TreeDate": treeDate,
      "PlantationTreeMappingId": null
    });
    SeedTreeMasterList.refresh();
    widgets[0].clearValues();
    widgets[1].clearValues();
    widgets[2].clearValues();
    node.unfocus();
  }
}
