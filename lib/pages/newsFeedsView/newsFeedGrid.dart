import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/utils.dart';
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
import 'newsFeedForm.dart';




class NewsFeedGrid extends StatefulWidget {
  VoidCallback voidCallback;
  NewsFeedGrid({required this.voidCallback});
  @override
  _NewsFeedGridState createState() => _NewsFeedGridState();
}

class _NewsFeedGridState extends State<NewsFeedGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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
        return HE_NewsFeedContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "NewsFeedId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("NewsFeedId", updatedMap);
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
                    title: Text(Language.newsFeedTitle,style: TextStyle(color:ColorUtil.themeBlack,fontFamily: Language.boldFF,fontSize: 18,),textAlign: TextAlign.left,),
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
                          GridAddIcon(
                            onTap: (){
                              fadeRoute(NewsFeedForm(closeCb: (e){
                                he_listViewBody.addData(e['Table'][0]);
                              },));
                            },
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
    await parseJson(widgets, getPageIdentifier());
    try{
      List<dynamic> NewsFeedList=valueArray.where((element) => element['key']=="NewsFeedList").toList()[0]['value'];
      he_listViewBody.assignWidget(NewsFeedList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.NewsFeedGridViewIdentifier;
  }
}

class HE_NewsFeedContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_NewsFeedContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey}) : super(key: key){
    dataListener.value=data;
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
                    width: cardWidth*0.6,
                    alignment: Alignment.topLeft  ,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        gridCardText(Language.date ,dataListener['Date']??"",isBold: true),
                        gridCardText(Language.name, dataListener['Name'],),
                        gridCardText(Language.role, dataListener['Role']??"",textOverflow: TextOverflow.ellipsis),
                        gridCardText('Description', dataListener['Description']??""),
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
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('No of Plants',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: Language.regularFF),),
                        // Text("${dataListener['PlantsQty']??0}",style: ColorUtil.textStyle18),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           //  EyeIcon(
                           //    onTap: (){
                           //      fadeRoute(EventViewPage(dataJson: getDataJsonForGrid(dataListener['DataJson']),closeCb: (e){
                           //        updateDataListener(e['Table'][0]);
                           //        if(onEdit!=null){
                           //          onEdit!(e['Table'][0]);
                           //        }
                           //      },));
                           //    },
                           //  ),
                           // const SizedBox(width: 10,),
                            GridEditIcon(
                              hasAccess: isHasAccess(accessId["SeedCollectionEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                              margin: actionIconMargin,
                              onTap: (){
                                fadeRoute(NewsFeedForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                  updateDataListener(e['Table'][0]);
                                  if(onEdit!=null){
                                    onEdit!(e['Table'][0]);
                                  }
                                },));
                              },
                            ),
                          //  const SizedBox(width: 10,),
                            GridDeleteIcon(
                              hasAccess: isHasAccess(accessId["SeedCollectionDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
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
}