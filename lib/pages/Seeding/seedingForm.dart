import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/alertDialog.dart';
import 'package:treedonate/widgets/loader.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/logoPicker.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


class SeedingForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  SeedingForm({this.closeCb,this.dataJson="",this.isEdit=false});

  @override
  _SeedingFormState createState() => _SeedingFormState();
}

class _SeedingFormState extends State<SeedingForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }

  RxList<dynamic> seedTreeList = RxList<dynamic>();
  var node;

  String page="Seeding";
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
                  leading: ArrowBack(
                    iconColor: ColorUtil.themeBlack,
                    onTap: (){
                      Get.back();
                    },
                  ),
                  pinned: true,
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
            body:Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  child:  ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text("Seed Collection Details",style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:'RM'), )),
                      const SizedBox(height: 10,),

                      formGridContainer(
                        [
                          widgets[0],
                          widgets[10],
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 60,
                                  width: SizeConfig.screenWidth!-125,
                                  child: widgets[1]
                              ),
                              GestureDetector(
                                onTap: (){
                                  onSeedCollectionAdd();
                                },
                                child: Container(
                                  height: 47,
                                  width: 80,
                                  margin: const EdgeInsets.only(top:8,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: ColorUtil.primary),
                                    color: ColorUtil.primary.withOpacity(0.3),
                                  ),
                                  child:Center(child: Text('+ Add',style: TextStyle(fontSize: 16,color: ColorUtil.themeWhite,fontFamily:'RR'), )) ,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Obx(() => Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(1),
                              },
                              // defaultColumnWidth: FixedColumnWidth(80.0),
                              border: TableBorder.all(color: ColorUtil.formTableBorder, style: BorderStyle.solid, width: 1),
                              children: [
                                TableRow(
                                    children: [
                                      formTableHeader('Seed Name'),
                                      formTableHeader('Quantity'),
                                      formTableHeader('Action',needFittedBox: true),
                                    ]
                                ),
                                for(int i=0;i<seedTreeList.length;i++)
                                  TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${seedTreeList[i]['TreeName']}",style: ColorUtil.formTableBodyTS,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${seedTreeList[i]['Quantity']}",style: ColorUtil.formTableBodyTS,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GridDeleteIcon(hasAccess: true,onTap: (){seedTreeList.removeAt(i);},),
                                              //Icon(Icons.delete_outline,color: ColorUtil.red,),
                                            ],
                                          ),
                                        ),
                                      ]
                                  ),
                                //tableView(SeedsGridView[i]['TreeName'],SeedsGridView[i]['Quantity'],ColorUtil.greyBorder,ColorUtil.themeBlack),
                              ],
                            )),
                          ),
                          Obx(() => NoData(topPadding: 15,show: seedTreeList.isEmpty,)),
                        ]
                      ),



                      const SizedBox(height: 10,),
                      Container(
                          padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                          child: Text("Seed Giver Info",style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:'RM'), )
                      ),
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5],
                      widgets[6],
                      widgets[7],
                      widgets[8],

                      const SizedBox(height: 100,),
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
                                if(seedTreeList.isEmpty){
                                  CustomAlert().cupertinoAlert("Select Seeds...");
                                  return false;
                                }
                                else{
                                  foundWidgetByKey(widgets, "SeedTreeList",needSetValue: true,value: seedTreeList);
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
                ShimmerLoader(),
              ],
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    widgets.add(SearchDrp2(map: const {"dataName":"SeedMasterList","hintText":"Select Seed","labelText":"Seed","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
      onchange: (e){
        onSeedDrpChg(e);
      },
      hasInput: false,
      required: false,
    ));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'Qty',
      hasInput: false,
      required: false,
      labelText: "Quantity",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.decimalReg,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1


    widgets.add(AddNewLabelTextField(
      dataname: 'SeedDonorName',
      hasInput: true,
      required: true,
      labelText: "Name",
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//2
    widgets.add(AddNewLabelTextField(
      dataname: 'SeedDonorContactNumber',
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
    ));//3
    widgets.add(AddNewLabelTextField(
      dataname: 'SeedDonorAddress',
      hasInput: true,
      required: false,
      labelText: "Address",
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//4
    widgets.add(SearchDrp2(map: const {"dataName":"DistrictId","hintText":"Select District","labelText":"District","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
        }
    ));//5
    widgets.add(SearchDrp2(map: const {"dataName":"TalukId","hintText":"Select Taluk","labelText":"Taluk","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id']);
        })); //6
    widgets.add(SearchDrp2(map: const {"dataName":"VillageId","hintText":"Select Village","labelText":"Village","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},)
    );//7

    widgets.add( MultiImagePicker(
      dataname: "ImagesList",
      hasInput: true,
      required: false,
      folder: "Seeding",
    ));//8

    widgets.add(HiddenController(dataname: "SeedId"));//9
    widgets.add(AddNewLabelTextField(
      dataname: 'SeedNameOthers',
      hasInput: false,
      required: false,
      isEnabled: false,
      labelText: "Other Seed Name",
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    )); //10

    widgets.add(HiddenController(dataname: "SeedTreeList"));//11

    await parseJson(widgets, General.addSeedCollectionFrmIdentifier,dataJson: widget.dataJson);
    try{

      seedTreeList.value=valueArray.where((element) => element['key']=="SeedTreeList").toList()[0]['value'];

    }catch(e){}
  }


  @override
  String getPageIdentifier(){
    return General.addSeedCollectionFrmIdentifier;
  }

  void onSeedDrpChg(e){
    console(e);
    if(e['Id']=="Others"){
      updateEnable(widgets,"SeedNameOthers",isEnabled: true);
    }
    else{
      updateEnable(widgets,"SeedNameOthers");
    }
  }

  void onSeedCollectionAdd(){
    var seedDrpDetail=widgets[0].getValueMap();
    var seedOtherName=widgets[10].getValue();
    var seedQty=widgets[1].getValue();

    bool isOthers=seedDrpDetail['Id']=="Others";
    if(seedDrpDetail.isEmpty){
      CustomAlert().cupertinoAlert("Select Seed");
      return;
    }
    if(isOthers && (seedOtherName==null || seedOtherName=="")){
      CustomAlert().cupertinoAlert("Enter Seed Name");
      return;
    }
    if(isOthers){
      if(seedTreeList.any((element) => element["TreeName"].toString().replaceAll(' ', '') == seedOtherName.toString().replaceAll(' ', ''))){
        CustomAlert().cupertinoAlert("Seed Name Already Exists...");
        return;
      }
    }
    else{
      if(seedTreeList.any((element) => element["SeedTreeMasterId"] == seedDrpDetail['Id'])){
        CustomAlert().cupertinoAlert("Seed Name Already Exists...");
        return;
      }
    }
    seedTreeList.add({
      "SeedTreeMasterId": isOthers ? null:seedDrpDetail['Id'],
      "TreeName": isOthers ? seedOtherName:seedDrpDetail['Text'],
      "Quantity": seedQty
    });
    console("$seedDrpDetail $seedOtherName $seedQty");
    seedTreeList.refresh();
    widgets[0].clearValues();
    widgets[1].clearValues();
    widgets[10].clearValues();
    node.unfocus();
  }

}
