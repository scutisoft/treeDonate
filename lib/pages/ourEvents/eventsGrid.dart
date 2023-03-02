import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/widgets/accessWidget.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
import '../Filter/FilterItems.dart';
import 'eventForm.dart';
import 'eventViewPage.dart';
import 'eventsInterestedGrid.dart';



class EventsGrid extends StatefulWidget {
  VoidCallback voidCallback;
  EventsGrid({required this.voidCallback});
  @override
  _EventsGridState createState() => _EventsGridState();
}

class _EventsGridState extends State<EventsGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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
        return HE_EventContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "EventId",dataJson: dataJson,developmentMode: DevelopmentMode.traditional,
            traditionalParam: TraditionalParam(executableSp: "USP_Events_DeleteEventDetails"));
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("EventId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );

    assignWidgets();
    super.initState();
  }

  var node;



  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    //cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            controller: silverController,
            //floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFf3f3f3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leading: NavBarIcon(
                      onTap: (){
                        widget.voidCallback();
                      },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text(Language.ourEvents,style: TextStyle(color:ColorUtil.themeBlack,fontFamily: Language.boldFF,fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
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
                              hasAccess: isHasAccess(accessId["EventsAdd"]),
                              needToHide: true,
                              widget: GridAddIcon(
                                onTap: (){
                                  fadeRoute(EventsForm(closeCb: (e){
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
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    await parseJson(widgets, getPageIdentifier(),developmentMode: DevelopmentMode.traditional,traditionalParam: TraditionalParam(executableSp: "USP_Events_GetEventDetails"),
    resCb: (e){
      console(e);
      if(e['Table']!=null){
        he_listViewBody.assignWidget(e['Table']);
      }
    });

    try{
      //List<dynamic> EventList=valueArray.where((element) => element['key']=="EventList").toList()[0]['value'];
      //he_listViewBody.assignWidget(EventList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.EventsGridViewIdentifier;
  }
}

class HE_EventContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_EventContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey}) : super(key: key){
    dataListener.value=data;
    dataListener['DataJson']={"EventId":data['EventId']};
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
                    width: cardWidth*0.7,
                    alignment: Alignment.topLeft  ,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        gridCardText(Language.date, dataListener['EventDate'],isBold: true),
                        gridCardText2(Language.eventName, dataListener['EventName']??"",),
                        gridCardText2(Language.eventPlace, dataListener['Place']??""),
                        gridCardText(Language.location ,dataListener['EventLocation']??""),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${Language.status} : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text(dataListener['ApproveStatus']??"",style: TextStyle(color: getStatusClr(dataListener['ApproveStatus']??""),fontSize: 14,fontFamily: 'RR'),)),
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
                    width: cardWidth*0.3,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No of Plants',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: Language.regularFF),),
                        Text("${dataListener['NoOfPlants']??0}",style: ColorUtil.textStyle18),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EyeIcon(
                              onTap: (){
                                fadeRoute(EventViewPage(dataJson: getDataJsonForGrid(dataListener['DataJson']),closeCb: (e){
                                  updateDataListener(e['Table'][0]);
                                  if(onEdit!=null){
                                    onEdit!(e['Table'][0]);
                                  }
                                },));
                              },
                            ),
                           // const SizedBox(width: 10,),
                            GridEditIcon(
                              hasAccess: isHasAccess(accessId["EventsEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                              margin: actionIconMargin,
                              onTap: (){
                                fadeRoute(EventsForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                  updateDataListener(e['Table'][0]);
                                  if(onEdit!=null){
                                    onEdit!(e['Table'][0]);
                                  }
                                },));
                              },
                            ),
                          //  const SizedBox(width: 10,),
                            GridDeleteIcon(
                              hasAccess: isHasAccess(accessId["EventsDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
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
                        AccessWidget(
                          needToHide: true,
                            hasAccess: isHasAccess(accessId["EventsInterestedView"]) ,
                            widget: Image.asset('assets/like.png',width: 30,),
                          onTap: (){
                            fadeRoute(EventInterestedView(dataJson: getDataJsonForGrid(dataListener['DataJson']),));
                          },
                        ),

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