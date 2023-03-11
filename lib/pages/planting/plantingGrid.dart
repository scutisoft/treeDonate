import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/planting/plantingAmountDetails.dart';
import '../../helper/language.dart';
import '../../widgets/treeDonateWidgets.dart';
import 'plantingForm.dart';
import 'plantingViewPage.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../utils/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';


class PlantingGrid extends StatefulWidget {
  VoidCallback voidCallback;
  PlantingGrid({required this.voidCallback});
  @override
  _PlantingGridState createState() => _PlantingGridState();
}

class _PlantingGridState extends State<PlantingGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController silverController= ScrollController();
  TextEditingController textController = TextEditingController();

  late HE_ListViewBody he_listViewBody;
  RxDouble silverBodyTopMargin=RxDouble(0.0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      silverBodyTopMargin.value = 0.0;
      silverController!.addListener(() {
        if (silverController!.offset > triggerOffset) {
          silverBodyTopMargin.value = toolBarHeight -
              (-(silverController!.offset - flexibleSpaceBarHeight));
          if (silverBodyTopMargin.value < 0) {
            silverBodyTopMargin.value = 0;
          }
        }
        else if (silverController!.offset < triggerEndOffset) {
          silverBodyTopMargin.value = 0;
        }
      });
    });
    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_PlantationViewContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "PlantationId",dataJson: dataJson);
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
  List<dynamic> PlantationList=[];
  var node;

  double cardWidth=SizeConfig.screenWidth!-(30+15+25);
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            controller: silverController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: false,
                  snap: false,
                  pinned: true,
                  leading: NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text(Language.plantation,style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
                    //background: FlutterLogo(),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Container(
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
                              //fadeRoute(FilterItems());
                            },
                          ),
                          const SizedBox(width: 5,),
                          GridAddIcon(
                            onTap: (){
                              fadeRoute(PlantingForm(closeCb: (e){
                                he_listViewBody.addData(e['Table'][0]);
                              },));
                            },
                          ),
                          const SizedBox(width: 15,),
                        ],
                      ),
                      Flexible(child:he_listViewBody),
                    ],
                  ),
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
    await parseJson(widgets, getPageIdentifier());
    try{

      List<dynamic >PlantationGird=valueArray.where((element) => element['key']=="PlantationList").toList()[0]['value'];
      he_listViewBody.assignWidget(PlantationGird);
    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.PlantationGirdPageViewIdentifier;
  }
}


class HE_PlantationViewContent extends StatelessWidget {
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_PlantationViewContent({Key? key,required this.data,this.onEdit,required this.cardWidth,this.onDelete,required this.globalKey}) : super(key: key){
    dataListener.value=data;
  }

  var dataListener={}.obs;
  var separatorHeight = 50.0.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      separatorHeight.value=parseDouble(globalKey.currentContext!.size!.height)-30;
    });
    return Obx(
        ()=>Container(
          key: globalKey,
          margin: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),

          width: SizeConfig.screenWidth!*1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFffffff),
          ),
          clipBehavior:Clip.antiAlias,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: cardWidth*0.6,
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                alignment: Alignment.topLeft  ,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    gridCardText(Language.date, dataListener['Date'],isBold: true),
                    gridCardText(Language.plant, dataListener['PlantName']),
                    gridCardText(Language.location, dataListener['PlantLocation']),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${Language.status}  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        //  Spacer(),
                        Flexible(child: Text("${dataListener['ApproveStatus']}",style: TextStyle(color: getStatusClr(dataListener['ApproveStatus']),fontSize: 14,fontFamily: 'RM'),)),
                      ],
                    ),

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
                width: cardWidth*0.4,
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                alignment:Alignment.center,
                // color:Colors.red,
                child:  Column(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: [
                    EGFEmblem(
                      isGov: dataListener['IsGov'],
                      companyId: dataListener['UserRoleTypeId'],
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    Text(Language.noPlant,style: ts14(ColorUtil.themeBlack),textAlign: TextAlign.right,),
                    Text("${dataListener['NumberOfPlants']}",style: ts18(ColorUtil.themeBlack,fontfamily: 'USB')),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            fadeRoute(PlantingView(dataJson:getDataJsonForGrid(dataListener['DataJson']),
                              closeCb: (e){
                                updateDataListener(e['Table'][0]);
                                if(onEdit!=null){
                                  onEdit!(e['Table'][0]);
                                }
                              },
                            ));

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorUtil.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.primary,size: 20,),
                            //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                          ),
                        ),
                       // const SizedBox(width: 10,),
                        GridEditIcon(
                          hasAccess: isHasAccess(accessId["LandParcelEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                          margin: actionIconMargin,
                          onTap: (){
                            fadeRoute(PlantingForm(dataJson:getDataJsonForGrid(dataListener['DataJson']),isEdit: true,
                              closeCb: (e){
                                updateDataListener(e['Table'][0]);
                                if(onEdit!=null){
                                  onEdit!(e['Table'][0]);
                                }
                              },
                            ));
                          },
                        ),
                       // const SizedBox(width: 10,),
                        GridDeleteIcon(
                          hasAccess: isHasAccess(accessId["LandParcelDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
                          margin: actionIconMargin,
                          onTap: (){
                            if(onDelete!=null){
                              onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        fadeRoute(PlantingAmountDetails(
                          plantationId: dataListener['PlantationId'].toString(),
                          dataJson: getDataJsonForGrid(dataListener['DataJson']),
                        ));
                      },
                      child: Container(
                            width: 30,
                            height: 30,
                            alignment:Alignment.center,
                            margin: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                                color: ColorUtil.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Icon(Icons.person_outline_outlined,color: ColorUtil.primary,)
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
