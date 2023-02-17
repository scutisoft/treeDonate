import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/utils.dart';
import '../../pages/Nursery/nurseryForm.dart';
import '../../pages/Nursery/nurseryViewPage.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';


class NurseryGrid extends StatefulWidget {
  VoidCallback voidCallback;
  NurseryGrid({required this.voidCallback});
  @override
  _NurseryGridState createState() => _NurseryGridState();
}

class _NurseryGridState extends State<NurseryGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


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
        return HE_NurseryViewContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "NurseryId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("NurseryId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );
    assignWidgets();
    super.initState();
  }
  List<dynamic> NurseryList=[];
  var node;

  double cardWidth=SizeConfig.screenWidth!-(30+15+25);

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
            controller: silverController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leading:  NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('Nursery',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit:BoxFit.fill),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => SizedBox(height: silverBodyTopMargin.value,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                     // crossAxisAlignment: CrossAxisAlignment.end,
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
                            fadeRoute(NurseryForm(closeCb: (e){
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

      List<dynamic >NurseryGird=valueArray.where((element) => element['key']=="NurseryList").toList()[0]['value'];
      he_listViewBody.assignWidget(NurseryGird);
    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.NurseryGridIdentifier;
  }
}


class HE_NurseryViewContent extends StatelessWidget implements HE_ListViewContentExtension {

  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_NurseryViewContent({Key? key,required this.data,this.onEdit,required this.cardWidth,this.onDelete,required this.globalKey}) : super(key: key){
    dataListener.value=data;
  }

  var dataListener={}.obs;
  var separatorHeight = 50.0.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try{
        separatorHeight.value=parseDouble(globalKey.currentContext!.size!.height)-30;
      }catch(e){}
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
              Container(
                width: cardWidth*0.6,
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                alignment: Alignment.topLeft  ,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    gridCardText("Date", dataListener['Date'],isBold: true),
                    gridCardText("Nursery", dataListener['NurseryName']),
                    gridCardText("Incharge", dataListener['NurseryIncharge']),
                    gridCardText("Location", dataListener['NurseryLocation']),
                    gridCardText("Total Target", dataListener['NoOfTargets']),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Taken : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        // Spacer(),
                        Flexible(child: Text("${dataListener['TotalTaken']}",style: TextStyle(color: ColorUtil.red,fontSize: 14,fontFamily: 'RM'),)),
                      ],
                    ),
                    const SizedBox(height: 2,),
                    /*gridCardText("Balance Stock", dataListener['BalanceStock']),*/


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status      : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        //  Spacer(),
                        Flexible(child: Text("${dataListener['ApproveStatus']}",style: TextStyle(color: getStatusClr(dataListener['ApproveStatus']??""),fontSize: 14,fontFamily: 'RM'),)),
                      ],
                    ),
                  ],
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
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                alignment:Alignment.center,
                // color:Colors.red,
                child:  Column(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  //    mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total Stock',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 13,fontFamily: 'RR'),),
                    Text("${dataListener['NoOfStocks']}",style: ts18(ColorUtil.themeBlack,fontsize: 18)),
                    const SizedBox(height: 10,),

                    Text('Balance Stock',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 13,fontFamily: 'RR'),),
                    Text("${dataListener['BalanceStock']}",style: ts18(ColorUtil.themeBlack,fontsize: 18)),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EyeIcon(
                          onTap: (){
                            fadeRoute(NurseryView(dataJson: getDataJsonForGrid(dataListener['DataJson']),closeCb: (e){
                              updateDataListener(e['Table'][0]);
                              if(onEdit!=null){
                                onEdit!(e['Table'][0]);
                              }
                            },));
                          },
                        ),
                        //const SizedBox(width: 10,),
                        GridEditIcon(
                          hasAccess: isHasAccess(accessId["NurseryEdit"]) && (dataListener['IsEdit']??MyConstants.defaultActionEnable),
                          margin: actionIconMargin,
                          onTap: (){
                            fadeRoute(NurseryForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                              updateDataListener(e['Table'][0]);
                              if(onEdit!=null){
                                onEdit!(e['Table'][0]);
                              }
                            },));
                          },
                        ),
                       // const SizedBox(width: 10,),
                        GridDeleteIcon(
                          hasAccess: isHasAccess(accessId["NurseryDelete"]) && (dataListener['IsDelete']??MyConstants.defaultActionEnable),
                          margin: actionIconMargin,
                          onTap: (){
                            if(onDelete!=null){
                              onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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
