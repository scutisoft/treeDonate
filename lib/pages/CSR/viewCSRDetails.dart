
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/extensionUtils.dart';
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
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
import '../Filter/FilterItems.dart';
import 'CSRForm.dart';
import 'csrAddAmount.dart';




class ViewCSRGrid extends StatefulWidget {
  String dataJson;
  ViewCSRGrid({this.dataJson=""});
  @override
  _ViewCSRGridState createState() => _ViewCSRGridState();
}

class _ViewCSRGridState extends State<ViewCSRGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController silverController=ScrollController();
  TextEditingController textController = TextEditingController();
  late HE_ListViewBody he_listViewBody;
  double cardWidth=SizeConfig.screenWidth!-(20+20+25);


  RxDouble silverBodyTopMargin=RxDouble(0.0);

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
        return HE_ViewCSRGridContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "CSRId",dataJson: dataJson,
              traditionalParam: TraditionalParam(executableSp: Sp.deleteNewsFeedDetail),
              developmentMode: DevelopmentMode.traditional
            );
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("CSRId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );

    assignWidgets();
    super.initState();
  }

  var node;
  var counter={"TotalDonation": 0, "TotalAmount": 0.0, "AmountWords": "",  "TotalConsumption": "", "CSRId": ""}.obs;


  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    //cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body:ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth!-170,
                      child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ArrowBack(
                            iconColor: ColorUtil.themeBlack,
                            onTap: (){
                              Get.back();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Total Donate',style: ts18(ColorUtil.themeBlack,fontfamily: 'RB',fontsize: 24),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('${counter['TotalDonation']}',style: ts18(ColorUtil.themeBlack,fontfamily: 'RB',fontsize: 24),),
                          ),
                          const SizedBox(height: 2,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Total Amount',style: ts18(ColorUtil.text4,fontfamily: 'RB',fontsize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('${MyConstants.rupeeString} ${formatCurrency.format(parseDouble(counter['TotalAmount']))}',style: ts18(ColorUtil.text4,fontfamily: 'RB',fontsize: 15),),
                          ),
                          const SizedBox(height: 2,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('C02 ${counter['TotalConsumption']} %',style: ts18(ColorUtil.primary,fontfamily: 'RB',fontsize: 24),),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width: 170,
                      child: Image.asset('assets/Slice/volunteers.png',fit:BoxFit.cover),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Container(
                // height: SizeConfig.screenHeight,
                padding: const EdgeInsets.only(right: 5.0,),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => SizedBox(height: silverBodyTopMargin.value,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimSearchBar(
                          width: SizeConfig.screenWidth!-80,
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
                        AccessWidget(
                          hasAccess: isHasAccess(accessId["NewsFeedAdd"]),
                          needToHide: true,
                          widget: GridAddIcon(
                            onTap: (){
                              fadeRoute(CSRAddAmount(
                                csrId:counter['CSRId'] ,
                                closeCb: (e){
                                he_listViewBody.addData(e['Table'][0]);
                              },));
                            },
                          ),
                        ),
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
        )
    );
  }

  @override
  void assignWidgets() async{
    await parseJson(widgets, getPageIdentifier(),
        developmentMode: DevelopmentMode.traditional,
        dataJson: widget.dataJson,
        needToSetValue: false,
        traditionalParam: TraditionalParam(getByIdSp: "USP_CSR_GetCSRDonationView"),
        resCb: (res){
          console(res);
          List<dynamic> ViewCSRList=res['Table'];
          he_listViewBody.assignWidget(ViewCSRList);
          if(res['Table1']!=null)
          {
            counter.forEach((key, value) {
              counter[key]=res['Table1'][0][key]??"";
            });
          }
        });

    return;
   // console("valueArr $valueArray");
    try{
      //he_listViewBody.assignWidget(valueArray);
      List<dynamic> ViewCSRList=valueArray.where((element) => element['key']=="ViewCSRList").toList()[0]['value'];
      he_listViewBody.assignWidget(ViewCSRList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.ViewCSRGridIdentifier;
  }
}

class HE_ViewCSRGridContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_ViewCSRGridContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey}) : super(key: key){
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
                    width: cardWidth-120,
                    alignment: Alignment.topLeft  ,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        gridCardText(Language.date ,dataListener['DonationDate']??"",isBold: true),
                        gridCardText(Language.noTrees, dataListener['NoOfTree'],),
                        gridCardText('Age', dataListener['Age'],),
                        gridCardText(Language.location, dataListener['Location'],),
                        //gridCardText(Language.role, dataListener['Role']??"",textOverflow: TextOverflow.ellipsis),
                        gridCardText('Payment Type', dataListener['PaymentType']??""),
                        gridCardText('Consumption', dataListener['Consumption']??""),
                        gridCardText('Carban Sequestration', dataListener['CarbonSequestration']??""),
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
                    width: 120,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Amount',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: Language.regularFF),),
                        Text("${MyConstants.rupeeString} ${formatCurrency.format(parseDouble(dataListener['DonationTotalAmount']??0))}",style: ColorUtil.textStyle18),
                        // const SizedBox(height: 10,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     EyeIcon(
                        //       onTap: (){
                        //         // fadeRoute(EventViewPage(dataJson: getDataJsonForGrid(dataListener['DataJson']),closeCb: (e){
                        //         //   updateDataListener(e['Table'][0]);
                        //         //   if(onEdit!=null){
                        //         //     onEdit!(e['Table'][0]);
                        //         //   }
                        //         // },));
                        //       },
                        //     ),
                        //    const SizedBox(width: 10,),
                        //     GridEditIcon(
                        //       hasAccess: isHasAccess(accessId["NewsFeedEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                        //       margin: actionIconMargin,
                        //       onTap: (){
                        //
                        //         fadeRoute(CSRForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                        //           updateDataListener(e['Table'][0]);
                        //           if(onEdit!=null){
                        //             onEdit!(e['Table'][0]);
                        //           }
                        //         },));
                        //       },
                        //     ),
                        //   //  const SizedBox(width: 10,),
                        //     GridDeleteIcon(
                        //       hasAccess: isHasAccess(accessId["NewsFeedDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
                        //       margin: actionIconMargin,
                        //       onTap: (){
                        //         if(onDelete!=null){
                        //           onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                        //         }
                        //       },
                        //     ),
                        //
                        //   ],
                        // ),
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
}