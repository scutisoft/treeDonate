import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treedonate/widgets/calculation.dart';

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


class NurseryForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  NurseryForm({this.closeCb,this.dataJson="",this.isEdit=false});
  @override
  _NurseryFormState createState() => _NurseryFormState();
}

class _NurseryFormState extends State<NurseryForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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


  String page="NurseryDetails";
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
            body:Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  child:  ListView(
                    shrinkWrap: true,
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


                      formGridContainer(
                        [
                          widgets[15],
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: SizeConfig.screenWidth!-125,
                                child: widgets[16],
                              ),
                              GestureDetector(
                                onTap: (){
                                  onPlantCollectionAdd();
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
                            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Obx(() => Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(1),
                              },
                              // defaultColumnWidth: FixedColumnWidth(80.0),
                              border: TableBorder.all(
                                  color: ColorUtil.formTableBorder, style: BorderStyle.solid, width: 1),
                              children: [
                                TableRow(
                                    children: [
                                      formTableHeader('Planting Name'),
                                      formTableHeader('No of Plants'),
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
                                              const SizedBox(height: 8,),
                                              Text("${seedTreeList[i]['TreeDate']}",style: ColorUtil.formTableBodyTSB,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${seedTreeList[i]['Quantity']}",style: ColorUtil.formTableBodyTSB,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GridDeleteIcon(hasAccess: true,onTap: (){seedTreeList.removeAt(i);stockCalc();},),
                                            ],
                                          ),
                                        ),
                                      ]
                                  ),
                              ],
                            )),
                          ),
                          Obx(() => NoData(topPadding: 15,show: seedTreeList.isEmpty,)),
                        ],
                      ),
                      widgets[17],
                      const SizedBox(height: 100,)
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
                                  foundWidgetByKey(widgets, "SeedTreeList",needSetValue: true,value: seedTreeList);
                                  /*if(seedTreeList.isEmpty){
                                    CustomAlert().cupertinoAlert("Select Plant...");
                                    return false;
                                  }
                                  else{
                                    foundWidgetByKey(widgets, "SeedTreeList",needSetValue: true,value: seedTreeList);
                                  }*/
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
    widgets.add(AddNewLabelTextField(
      dataname: 'NurseryName',
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
      dataname: 'NurseryIncharge',
      hasInput: true,
      required: true,
      labelText: "Nursery Incharge",
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'NurseryInchargeContactNumber',
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
      dataname: 'NurseryInchargeEmail',
      hasInput: true,
      required: false,
      labelText: "Email",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'RangeName',
      hasInput: true,
      required: false,
      labelText: "Address",
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(
        HE_LocationPicker(
          dataname: "AddressDetail",
          contentTextStyle: ts15(addNewTextFieldText),
          content: "Pick Location",
          hasInput: true,
          required: false,
          //isEnabled: !isView,
          locationPickCallback: (addressDetail){
            console("locationPickCallback $addressDetail");
          },
        )
    );
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
    widgets.add(SearchDrp2(map: const {"dataName":"IsElectricityAvailable","hintText":"Select Electricity","labelText":"Electricity"},required: false,));
    widgets.add(SearchDrp2(map: const {"dataName":"FencingId","hintText":"Select Fencing","labelText":"Fencing"},required: false));
    widgets.add(SearchDrp2(map: const {"dataName":"WaterFacilityId","hintText":"Select Facility","labelText":"Facility"},required: false));
    widgets.add(SearchDrp2(map: const {"dataName":"LandOwnershipId","hintText":"Select Land Ownership","labelText":"Land Ownership"},required: false));
    widgets.add(AddNewLabelTextField(
      dataname: 'NoOfStocks',
      hasInput: true,
      required: false,
      isEnabled: false,
      labelText: "No of Stocks",
      textInputType: TextInputType.number,
      textLength: 6,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'NoOfTargets',
      hasInput: true,
      required: false,
      labelText: "No of Targets",
      textInputType: TextInputType.number,
      textLength: 6,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"SeedMasterList","hintText":"Select Plant","labelText":"Plant","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
      hasInput: false,
      required: false,
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'NoOfPlant',
      hasInput: false,
      required: false,
      textInputType: TextInputType.number,
      textLength: 6,
      regExp: MyConstants.digitRegEx,
      labelText: "No of Plant",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    widgets.add( MultiImagePicker(
      dataname: "ImagesList",
      hasInput: true,
      required: false,
      folder: "Nursery",
    ));

    widgets.add(HiddenController(dataname: "NurseryId"));
    widgets.add(HiddenController(dataname: "SeedTreeList"));

    await parseJson(widgets, getPageIdentifier(),dataJson: widget.dataJson);
    try{
      seedTreeList.value=valueArray.where((element) => element['key']=="SeedTreeList").toList()[0]['value'];
    }
    catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.addNurseryFormIdentifier;
  }

  void onPlantCollectionAdd(){
    var seedDrpDetail=widgets[15].getValueMap();
    var seedQty=widgets[16].getValue();

    String treeDate=DateFormat("dd-MM-yyyy").format(DateTime.now());

    if(seedDrpDetail.isEmpty){
      CustomAlert().cupertinoAlert("Select Plant");
      return;
    }

    if(seedTreeList.any((element) => element["SeedTreeMasterId"] == seedDrpDetail['Id'] && element["TreeDate"]==treeDate)){
      CustomAlert().cupertinoAlert("Plant Name Already Exists...");
      return;
    }
    seedTreeList.add({
      "SeedTreeMasterId": seedDrpDetail['Id'],
      "TreeName": seedDrpDetail['Text'],
      "Quantity": seedQty,
      "TreeDate":treeDate
    });
    seedTreeList.refresh();
    widgets[15].clearValues();
    widgets[16].clearValues();
    node.unfocus();
    stockCalc();
  }
  
  void stockCalc(){
    double stock=0;
    seedTreeList.forEach((element) { 
      stock=Calculation().add(stock, element['Quantity']);
    });
    foundWidgetByKey(widgets, "NoOfStocks",needSetValue: true,value: stock.toString());
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
