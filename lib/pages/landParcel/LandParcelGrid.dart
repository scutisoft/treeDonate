import 'dart:convert';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/HappyExtension/utils.dart';
import 'package:treedonate/widgets/navigationBarIcon.dart';
import '../../pages/landParcel/LandParcelForm.dart';
import '../../pages/landParcel/LandParcelViewPage.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/customAppBar.dart';
import '../Filter/FilterItems.dart';


class LandParcelGrid extends StatefulWidget {
  VoidCallback voidCallback;
  LandParcelGrid({required this.voidCallback});
  @override
  _LandParcelGridState createState() => _LandParcelGridState();
}

class _LandParcelGridState extends State<LandParcelGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  List<dynamic> landParcelList=[];
  List<dynamic> filterLandParcelList=[];

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
    assignWidgets();
    super.initState();
  }

  var node;

  double cardWidth=0.0;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWidth=SizeConfig.screenWidth!-(20+15+25);
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
            body:Container(
             // height: SizeConfig.screenHeight,
              padding: EdgeInsets.only(left: 10.0, right: 10.0,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => SizedBox(height: (silverBodyTopMargin.value),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimSearchBar(
                        width: SizeConfig.screenWidth!-130,
                        color: ColorUtil.asbColor,
                        boxShadow: ColorUtil.asbBoxShadow,
                        textController: textController,
                        closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                        searchIconColor: ColorUtil.asbSearchIconColor,
                        suffixIcon: ColorUtil.getASBSuffix(),
                        onSubmitted: (a){},
                        onSuffixTap: () {
                          setState(() {
                            textController.clear();
                          });
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
                            updateArrById("LandId", e["Table"][0], filterLandParcelList,isUpdate: false);
                            setState(() {});
                          },));
                        },
                      ),
                    ],
                  ),
                  Flexible(
                   // height: SizeConfig.screenHeight,
                   // width: cardWidth,
                    child: ListView.builder(
                      itemCount: filterLandParcelList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx,i){
                        return GestureDetector(
                          onTap: (){
                            // Get.to(CertificateView());
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: i==filterLandParcelList.length-1?50:5,left: 0,right: 0),
                            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                            width: cardWidth+25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFffffff),
                            ),
                            clipBehavior:Clip.antiAlias,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: cardWidth*0.6,
                                  alignment: Alignment.topLeft  ,
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start ,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('User : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                          // Spacer(),
                                          Text("${filterLandParcelList[i]['UserName']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Land Owner : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                         // Spacer(),
                                          Text("${filterLandParcelList[i]['LandOwner']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Land Type : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                         // Spacer(),
                                          Flexible(child: Text("${filterLandParcelList[i]['LandType']??""}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),)),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Role  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        //  Spacer(),
                                          Text("${filterLandParcelList[i]['Role']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Status  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                          //  Spacer(),
                                          Flexible(child: Text("${filterLandParcelList[i]['Status']}",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),)),
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
                                      Container(width: 1,height:90,color: Color(0xFFF2F3F7),),
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
                                    // color:Colors.red,
                                    child:  Column(
                                      crossAxisAlignment:CrossAxisAlignment.end,
                                      children: [
                                        Text('Land In Hectares ',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                                        Text(filterLandParcelList[i]['LandInHectares'],style: ColorUtil.textStyle18),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                fadeRoute(LandParcelView());
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
                                            GestureDetector(
                                              onTap: (){

                                                fadeRoute(LandParcelForm(dataJson:getDataJsonForGrid(filterLandParcelList[i]['DataJson']),isEdit: true,
                                                  closeCb: (e){
                                                    updateArrById("LandId", e["Table"][0], filterLandParcelList);
                                                    setState(() {});
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
                                                child: Icon(Icons.edit,color: ColorUtil.themeBlack,size: 20,),
                                                //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){

                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                alignment:Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorUtil.primary.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Icon(Icons.delete_outline,color: ColorUtil.red,size: 20,),
                                                //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{

    setState(() {});
    await parseJson(widgets, General.addLandParcelGirdIdentifier);
    try{

      landParcelList=valueArray.where((element) => element['key']=="LandParcelList").toList()[0]['value'];
      filterLandParcelList=landParcelList;
      setState((){});

    }catch(e){
    }
  }
}
