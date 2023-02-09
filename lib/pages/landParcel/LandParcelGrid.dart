
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/widgets/loader.dart';
import '../../HappyExtension/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../pages/landParcel/LandParcelForm.dart';
import '../../pages/landParcel/LandParcelViewPage.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/customAppBar.dart';


class LandParcelGrid extends StatefulWidget {
  VoidCallback voidCallback;
  LandParcelGrid({required this.voidCallback});
  @override
  _LandParcelGridState createState() => _LandParcelGridState();
}

class _LandParcelGridState extends State<LandParcelGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();




  RxDouble silverBodyTopMargin=RxDouble(0.0);
  late HE_ListViewBody he_listViewBody;
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
        return HE_VListViewContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "LandId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("LandId", updatedMap);
          },
          globalKey: GlobalKey(),
        );
      },
    );
    assignWidgets();
    super.initState();
  }
  var node;

  double cardWidth=SizeConfig.screenWidth!-(30+15+25);

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
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leadingWidth: 50.0,
                  leading: NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('My Land Parcel History',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //SizedBox(height: 50,),
                    Obx(() => Container(
                      height: 50,
                      margin: EdgeInsets.only(top: (10+silverBodyTopMargin.value),bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                              fadeRoute(LandParcelForm(closeCb: (e){
                                he_listViewBody.addData(e);
                              },));
                            },
                          ),
                          const SizedBox(width: 15,),
                        ],
                      ),
                    ),),

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

      List<dynamic >landParcelList=valueArray.where((element) => element['key']=="LandParcelList").toList()[0]['value'];
      he_listViewBody.assignWidget(landParcelList);

    }catch(e){}
  }


  @override
  String getPageIdentifier(){
    return General.addLandParcelGirdIdentifier;
  }
}


class HE_VListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_VListViewContent({Key? key,required this.data,this.onEdit,required this.cardWidth,this.onDelete,required this.globalKey}) : super(key: key){
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
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: cardWidth*0.6,
                alignment: Alignment.topLeft  ,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        // Spacer(),
                        Text("${dataListener['UserName']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Land Owner : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        // Spacer(),
                        Flexible(
                            child: Text("${dataListener['LandOwner']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),)
                        ),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Land Type : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        // Spacer(),
                        Flexible(child: Text("${dataListener['LandType']??""}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),)),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Role  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        //  Spacer(),
                        Text("${dataListener['Role']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                        //  Spacer(),
                        Flexible(child: Text("${dataListener['Status']}",
                          style: TextStyle(color: getStatusClr( dataListener['Status']),fontSize: 14,fontFamily: 'RM'),)),
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
                    Container(width: 1,height:separatorHeight.value,color: Color(0xFFF2F3F7),),
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
                alignment:Alignment.center,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
               //color:Colors.red,
                child:  Column(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: [
                    Text('Land In Hectares ',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                    Text(dataListener['LandInHectares'],style: ColorUtil.textStyle18),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            fadeRoute(LandParcelView(dataJson:getDataJsonForGrid(dataListener['DataJson']),
                              closeCb: (e){
                                updateArrById("LandId", e["Table"][0], dataListener,action: ActionType.update);

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
                        const SizedBox(width: 10,),
                        GridEditIcon(
                            hasAccess: isHasAccess(accessId["LandParcelEdit"]),
                          onTap: (){
                            fadeRoute(LandParcelForm(dataJson:getDataJsonForGrid(dataListener['DataJson']),isEdit: true,
                              closeCb: (e){
                                updateDataListener(e['Table'][0]);
                                if(onEdit!=null){
                                  onEdit!(e['Table'][0]);
                                }
                              },
                            ));
                          },
                        ),
                        const SizedBox(width: 10,),
                        GridDeleteIcon(
                          hasAccess: isHasAccess(accessId["LandParcelDelete"]),
                          onTap: (){
                            if(onDelete!=null){
                              onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                            }
                          },
                        )
                      ],
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