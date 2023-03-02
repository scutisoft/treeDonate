import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/HappyExtension/extensionUtils.dart';
import 'package:treedonate/api/apiUtils.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
import 'treeView_2.dart';


class MyTreesPage extends StatefulWidget {
  VoidCallback voidCallback;
  MyTreesPage({required this.voidCallback});
  @override
  _MyTreesPageState createState() => _MyTreesPageState();
}

class _MyTreesPageState extends State<MyTreesPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  late HE_ListViewBody he_listViewBody;
  RxDouble silverBodyTopMargin=RxDouble(0.0);


  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      silverController=ScrollController();
      silverBodyTopMargin.value=0.0;
      silverController!.addListener(() {
        if(silverController!.offset>triggerOffset){
          silverBodyTopMargin.value=toolBarHeight-(-(silverController!.offset-flexibleSpaceBarHeight));
          if(silverBodyTopMargin.value<0){
            silverBodyTopMargin.value=0;
          }
        }
        else if(silverController!.offset<triggerEndOffset){
          silverBodyTopMargin.value=0;
        }
      });
    });

    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_OurTreeViewContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "TreeId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("TreeId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );
    assignWidgets();
    super.initState();
  }
  List<dynamic> OurTreeList=[];
  var node;

  double cardWidth=SizeConfig.screenWidth!-(30+15+25);
  var treeCount=0.obs;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    // cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: ColorUtil.primary,
                  expandedHeight: 160.0,
                  pinned: true,
                  leading:  NavBarIcon(
                    iconColor: ColorUtil.themeWhite,
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 50,bottom: 10),
                    expandedTitleScale: 1.8,
                    title: Obx(() => Text('${treeCount.value} ${Language.myTrees}',style: TextStyle(color:ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,),textAlign: TextAlign.left,)),
                    background: Image.asset('assets/trees/banner_5.jpg',fit:BoxFit.fill),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Container(
                      height: 50,
                      margin: EdgeInsets.only(top: (10+silverBodyTopMargin.value),bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimSearchBar(
                            width: SizeConfig.screenWidth!-30,
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
                          // const SizedBox(width: 5,),
                          // FilterIcon(
                          //   onTap: (){
                          //     //fadeRoute(FilterItems());
                          //   },
                          // ),
                          // const SizedBox(width: 5,),
                          // GridAddIcon(
                          //   onTap: (){
                          //     fadeRoute(NurseryForm(closeCb: (e){
                          //       he_listViewBody.addData(e);
                          //     },));
                          //   },
                          // ),
                          const SizedBox(width: 15,),
                        ],
                      ),
                    ),
                    ),
                    Flexible(child:he_listViewBody),
                  ],
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
      List<dynamic >ourTreeGird=valueArray.where((element) => element['key']=="OurTreeList").toList()[0]['value'];
      treeCount.value=ourTreeGird.length;
      he_listViewBody.assignWidget(ourTreeGird);
    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.OurTreePageViewIdentifier;
  }
}


class HE_OurTreeViewContent extends StatelessWidget implements HE_ListViewContentExtension {

  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_OurTreeViewContent({Key? key,required this.data,this.onEdit,required this.cardWidth,this.onDelete,required this.globalKey}) : super(key: key){
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
            ()=> Container(
            key: globalKey,
            margin: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
            padding: const EdgeInsets.only(left: 15.0,right: 10.0),

            width: SizeConfig.screenWidth!*1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFffffff),
            ),
            clipBehavior:Clip.antiAlias,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    fadeRoute(OurTreeView(dataJson: getDataJsonForGrid(dataListener['DataJson']),));
                  },
                  child: Container(
                    width: cardWidth*0.6,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                    alignment: Alignment.topLeft  ,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text('Tree Name   : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text("${dataListener['TreeName']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                            Icon(Icons.arrow_forward_ios_outlined,size: 15,color: ColorUtil.primary,)
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seeds   : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text("${dataListener['SeedQty']}",style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),)),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nursery   : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text("${dataListener['Nursery']}",style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),)),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Planting : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text("${dataListener['Planting']}",style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),)),
                          ],
                        ),
                        //SizedBox(height: 2,),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text('Status      : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        //     //  Spacer(),
                        //     Text("${dataListener['ApproveStatus']}",style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 15,
                  //  height: double.minPositive,
                  // color: Colors.green,
                  // constraints: BoxConstraints.tightForFinite(height:double.infinity),
                  alignment:Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                    padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                    alignment:Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: "${GetImageBaseUrl()}${dataListener['ImagePath']}",
                      fit: BoxFit.contain,
                      height: 100,
                      placeholder: (a,b){
                        return Container(height:30,width:30,alignment:Alignment.center,
                            child: CircularProgressIndicator(color: ColorUtil.primary,));
                        return Image.asset("assets/splash.jpg",fit:BoxFit.contain,height: 80,);
                      },
                      errorWidget: (a,b,c){
                        return Image.asset("assets/splash.jpg",fit:BoxFit.contain,height: 80,);
                      },
                    ),
                    /*child: Image.asset("${dataListener['ImagePath']}",fit: BoxFit.contain,height: 100,errorBuilder: (a,b,c){
                      return Image.asset("assets/splash.jpg",fit:BoxFit.contain,height: 80,);
                    },)*/
                ),
              ],
            )
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