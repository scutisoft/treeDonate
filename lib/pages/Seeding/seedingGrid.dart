import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/utils.dart';
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
import 'seedingForm.dart';
import 'seedingViewPage.dart';


class SeedingGrid extends StatefulWidget {
  VoidCallback voidCallback;
  SeedingGrid({required this.voidCallback});
  @override
  _SeedingGridState createState() => _SeedingGridState();
}

class _SeedingGridState extends State<SeedingGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();
  late HE_ListViewBody he_listViewBody;
  double cardWidth=SizeConfig.screenWidth!-(20+15+25);

  @override
  void initState(){
    silverController= ScrollController();

    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_SeedContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "SeedId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("SeedId", updatedMap);
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
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: true,
                  snap: true,
                  pinned: false,
                  leading: NavBarIcon(
                      onTap: (){
                        widget.voidCallback();
                      },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('Seeding',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body:Container(
             // height: SizeConfig.screenHeight,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          fadeRoute(SeedingForm());
                        },
                      ),
                    ],
                  ),
                  Flexible(child: he_listViewBody),
                  Obx(() => NoData(show: he_listViewBody.widgetList.isEmpty,)),
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    await parseJson(widgets, getPageIdentifier());
    try{
      List<dynamic> seedingList=valueArray.where((element) => element['key']=="SeedingList").toList()[0]['value'];
      he_listViewBody.assignWidget(seedingList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.addSeedGridViewIdentifier;
  }
}

class HE_SeedContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_SeedContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey}) : super(key: key){
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
              margin: const EdgeInsets.only(bottom: 10,left: 0,right: 0),
              padding: const EdgeInsets.only(left: 15.0,right: 10.0),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seed : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text(dataListener['Seed'],style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),overflow: TextOverflow.ellipsis,)),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name : ${ separatorHeight.value}',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Text(dataListener['GName'],style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mobile No  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            //  Spacer(),
                            Text(dataListener['GPhoneNumber'],style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            //  Spacer(),
                            Flexible(child: Text(dataListener['Glocation'],style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),)),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            // Spacer(),
                            Flexible(child: Text(dataListener['Status'],style: TextStyle(color: getStatusClr(dataListener['Status']),fontSize: 14,fontFamily: 'RR'),)),
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
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Seed Qty ',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RR'),),
                        Text("${dataListener['SeedQty']}",style: ColorUtil.textStyle18),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){

                                fadeRoute(SeedingView());
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
                                fadeRoute(SeedingForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                  updateDataListener(e['Table'][0]);
                                  if(onEdit!=null){
                                    onEdit!(e['Table'][0]);
                                  }
                                },));
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
                            GridDeleteIcon(
                              hasAccess: isHasAccess(accessId["VolunteerDelete"]),
                              onTap: (){
                                if(onDelete!=null){
                                  onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                                }
                              },
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