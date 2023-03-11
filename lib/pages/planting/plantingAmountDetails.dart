
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../api/sp.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../widgets/accessWidget.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';
import '../Filter/FilterItems.dart';





class PlantingAmountDetails extends StatefulWidget {
  @override

  _PlantingAmountDetailsState createState() => _PlantingAmountDetailsState();
}

class _PlantingAmountDetailsState extends State<PlantingAmountDetails> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController silverController=ScrollController();
  TextEditingController textController = TextEditingController();
  late HE_ListViewBody he_listViewBody;
  double cardWidth=SizeConfig.screenWidth!-(20+20+25);


  RxDouble silverBodyTopMargin=RxDouble(0.0);
  String page="";

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_){

      silverBodyTopMargin.value=0.0;
      silverController.addListener(() {
        if(silverController.offset>triggerOffset){
          silverBodyTopMargin.value=toolBarHeight-(-(silverController.offset-flexibleSpaceBarHeight));
          if(silverBodyTopMargin.value<0){
            silverBodyTopMargin.value=0;
          }
        }
        else if(silverController.offset<triggerEndOffset){
          silverBodyTopMargin.value=0;
        }
      });
    });

    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_PlantingAmountGridContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "PlantationId",dataJson: dataJson,
              traditionalParam: TraditionalParam(executableSp: Sp.deleteNewsFeedDetail),
              developmentMode: DevelopmentMode.traditional
            );
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("PlantationId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );

    assignWidgets();
    super.initState();
  }

  var node;
  var isKeyboardVisible=false.obs;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
    //cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body:NestedScrollView(
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(Language.plantation,style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
                        Text(Language.form,style: ts12(ColorUtil.themeBlack,fontfamily: 'Med'),textAlign: TextAlign.left,)
                      ],
                    ),
                    background: Image.asset('assets/trees/green-pasture-with-mountain.jpg',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 5,),
                    Container(
                      // height: SizeConfig.screenHeight,
                      padding: const EdgeInsets.only(right: 5.0,),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => SizedBox(height: silverBodyTopMargin.value,)),
                          formGridContainer(
                              [
                                Row(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[0]
                                    ),
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[1]
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[2]
                                    ),
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[3]
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[4]
                                    ),
                                    Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.45,
                                        child: widgets[5]
                                    ),
                                  ],
                                ),
                                // Container(
                                //   width:SizeConfig.screenWidth,
                                //   child: Wrap(
                                //     runSpacing: 5,
                                //     spacing: 5,
                                //     runAlignment: WrapAlignment.spaceAround,
                                //     children: [
                                //
                                //       Container(
                                //           height: 60,
                                //           // width: SizeConfig.screenWidth!*0.43,
                                //           child: widgets[2]
                                //       ),
                                //       Container(
                                //           height: 60,
                                //           // width: SizeConfig.screenWidth!*0.43,
                                //           child: widgets[3]
                                //       ),
                                //       Container(
                                //           height: 60,
                                //           // width: SizeConfig.screenWidth!*0.45,
                                //           child: widgets[4]
                                //       ),
                                //       Container(
                                //           height: 60,
                                //           // width: SizeConfig.screenWidth!*0.45,
                                //           child: widgets[5]
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    // onPlantingAmountAdd();
                                  },
                                  child: Container(
                                    width:80,
                                    height: 47,
                                    margin: const EdgeInsets.only(top: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: ColorUtil.primary),
                                      color: ColorUtil.primary.withOpacity(0.3),
                                    ),
                                    child:Center(child: Text('${Language.save}',style: TextStyle(fontSize: 16,color: ColorUtil.primary,fontFamily:'RR'), )) ,
                                  ),
                                ),
                              ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimSearchBar(
                                width: SizeConfig.screenWidth!-40,
                                color: ColorUtil.asbColor,
                                boxShadow: ColorUtil.asbBoxShadow,
                                textController: textController,
                                closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                                searchIconColor: ColorUtil.asbSearchIconColor,
                                suffixIcon: ColorUtil.getASBSuffix(),
                                onSubmitted: (a){
                                },
                                onChange: (a){
                                  he_listViewBody.searchHandler(a);
                                },
                                onSuffixTap: (clear) {
                                  if(clear){
                                    he_listViewBody.searchHandler("");
                                  }
                                },
                              ),
                              const SizedBox(width: 5,),
                              FilterIcon(
                                onTap: (){
                                  fadeRoute(FilterItems());
                                },
                              ),
                              const SizedBox(width: 5,),
                              // AccessWidget(
                              //   hasAccess: isHasAccess(accessId["NewsFeedAdd"]),
                              //   needToHide: true,
                              //   widget: GridAddIcon(
                              //     onTap: (){
                              //       fadeRoute(CSRForm(closeCb: (e){
                              //         he_listViewBody.addData(e['Table'][0]);
                              //       },));
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                          Flexible(child: he_listViewBody),
                          Obx(() => NoData(show: he_listViewBody.widgetList.isEmpty,topPadding: 20,)),
                        ],
                      ),
                    ),

                    ShimmerLoader()
                  ],
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
                                // isEdit: widget.isEdit,
                                // successCallback: (e){
                                //   if(widget.closeCb!=null){
                                //     widget.closeCb!(e);
                                //   }
                                // },
                                developmentMode: DevelopmentMode.traditional,
                                traditionalParam: TraditionalParam(
                                    getByIdSp: Sp.getByIdNewsFeedDetail,
                                    insertSp: Sp.insertNewsFeedDetail,
                                    updateSp: Sp.updateNewsFeedDetail
                                )
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
                ShimmerLoader(),
              ],
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    widgets.add(SearchDrp2(map:  {"dataName":"DonorTypeId","hintText":"Select","labelText": 'Select',"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
      onchange: (e){
        fillTreeDrp(widgets, "SeedTreeMasterId",);
      },
      hasInput: false,required: false,
    ));
    widgets.add(SearchDrp2(map:  {"dataName":"SelectCSR","hintText":'Select CSR',"labelText":'Select CSR',"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},hasInput: false,required: false,
      onchange: (e){
        console("$e");
      },));

    // widgets.add(SearchDrp2(map: const {"dataName":"ProjectId","hintText":"Select Plant"},));
    widgets.add(SearchDrp2(map:  {"dataName":"DonationId","hintText":'Donation',"labelText":'Donation',"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},hasInput: false,required: false,
      onchange: (e){
        console("$e");
      },));
    widgets.add(AddNewLabelTextField(
      dataname: 'TreeCount',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Tree Count',
      textInputType: TextInputType.number,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'Amount',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Amount',
      textInputType: TextInputType.number,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'C02',
      hasInput: true,
      required: true,
      maxlines: 1,
      suffixIcon: Icon(Icons.percent_outlined),
      labelText: 'C02',
      textInputType: TextInputType.number,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
  /*  await parseJson(widgets, getPageIdentifier(),
        developmentMode: DevelopmentMode.traditional,
        resCb: (res){
          console(res);
          List<dynamic> PlantingAmtList=res['Table'];
          he_listViewBody.assignWidget(PlantingAmtList);
    });*/
    fillTreeDrp(widgets, "DonorTypeId",page: page);
    return;
   // console("valueArr $valueArray");
    try{
      //he_listViewBody.assignWidget(valueArray);
      List<dynamic> PlantingAmtList=valueArray.where((element) => element['key']=="PlantingAmtList").toList()[0]['value'];
      he_listViewBody.assignWidget(PlantingAmtList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.PlantingAmtGridIdentifier;
  }
}

class HE_PlantingAmountGridContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_PlantingAmountGridContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey}) : super(key: key){
    dataListener.value=data;
   // dataListener['DataJson']={"NewsFeedId":data['NewsFeedId']};
  }
  var dataListener={}.obs;
  var separatorHeight = 50.0.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(globalKey.currentContext!=null){
        separatorHeight.value=parseDouble(globalKey.currentContext!.size!.height)-30;
      }
    });
    return Obx(
            ()=> Container(
              key: globalKey,
              margin: const EdgeInsets.only(bottom: 10,left: 15,right: 10),
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              width: cardWidth+25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorUtil.themeWhite,
              ),
              clipBehavior:Clip.antiAlias,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: cardWidth-40,
                    alignment: Alignment.topLeft  ,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        gridCardText( 'Name',dataListener['Name'],isBold: true),
                        gridCardText(Language.date ,dataListener['Date']??""),
                        gridCardText('Type', dataListener['Type'],),
                        gridCardText('Tree Count', dataListener['TreeCount'],),
                        gridCardText('Total Amount', dataListener['TotalAmount'],),
                        gridCardText('Taken Amount', dataListener['TakenAmount'],),
                        gridCardText('BalanceA mount', dataListener['BalanceAmount'],),
                        gridCardText('Carbon sequestration', dataListener['CarbonSeq'],),
                        //gridCardText(Language.role, dataListener['Role']??"",textOverflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Container(
                    width: 15,
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
                        Obx(() => Container(width: 1,height:separatorHeight.value,color: const Color(0xFFF2F3F7),)),
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
                    width: 40,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('No of Plants',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: Language.regularFF),),
                        // Text("${dataListener['PlantsQty']??0}",style: ColorUtil.textStyle18),
                        const SizedBox(height: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           const SizedBox(height: 10,),
                            GridEditIcon(
                              hasAccess: isHasAccess(accessId["NewsFeedEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                              margin: actionIconMargin,
                              onTap: (){

                                // fadeRoute(CSRForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                //   updateDataListener(e['Table'][0]);
                                //   if(onEdit!=null){
                                //     onEdit!(e['Table'][0]);
                                //   }
                                // },));
                              },
                            ),
                          //  const SizedBox(width: 10,),
                            const SizedBox(height: 10,),
                            GridDeleteIcon(
                              hasAccess: isHasAccess(accessId["NewsFeedDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
                              margin: actionIconMargin,
                              onTap: (){
                                if(onDelete!=null){
                                  onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                                }
                              },
                            ),

                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }

  @override
  updateDataListener(Map data) {
    data.forEach((key, value) {
      if(dataListener.containsKey(key)){
        dataListener[key]=value;
      }
    });
  }

  // void onPlantingAmountAdd(){
  //   var seedDrpDetail=widgets[0].getValueMap();
  //   var seedOtherName=widgets[1].getValue();
  //   var seedQty=widgets[2].getValue();
  //
  //   bool isOthers=seedDrpDetail['Id']=="Others";
  //   if(seedDrpDetail.isEmpty){
  //     CustomAlert().cupertinoAlert("Select Seed");
  //     return;
  //   }
  //   if(isOthers && (seedOtherName==null || seedOtherName=="")){
  //     CustomAlert().cupertinoAlert("Enter Seed Name");
  //     return;
  //   }
  //   if(isOthers){
  //     if(seedTreeList.any((element) => element["TreeName"].toString().replaceAll(' ', '') == seedOtherName.toString().replaceAll(' ', ''))){
  //       CustomAlert().cupertinoAlert("Seed Name Already Exists...");
  //       return;
  //     }
  //   }
  //   else{
  //     if(seedTreeList.any((element) => element["SeedTreeMasterId"] == seedDrpDetail['Id'])){
  //       CustomAlert().cupertinoAlert("Seed Name Already Exists...");
  //       return;
  //     }
  //   }
  //   seedTreeList.add({
  //     "SeedTreeMasterId": isOthers ? null:seedDrpDetail['Id'],
  //     "TreeName": isOthers ? seedOtherName:seedDrpDetail['Text'],
  //     "Quantity": seedQty
  //   });
  //   console("$seedDrpDetail $seedOtherName $seedQty");
  //   seedTreeList.refresh();
  //   widgets[0].clearValues();
  //   widgets[1].clearValues();
  //   widgets[10].clearValues();
  //   node.unfocus();
  // }
}