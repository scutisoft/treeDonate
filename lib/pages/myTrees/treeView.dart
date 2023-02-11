import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/apiUtils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/navigationBarIcon.dart';
import 'treeUsesView.dart';


class OurTreeView extends StatefulWidget {
  @override
  _OurTreeViewState createState() => _OurTreeViewState();
}

class _OurTreeViewState extends State<OurTreeView> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  List<Widget> widgets=[];

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }
  List<dynamic> TreeOtherDetails=[];
  List<dynamic> ListofUses=[];
  Map treeDetails={
    "SeedCount": 0,
    "NurseryCount": 0,
    "NurseryAddress": "",
    "PlantationCount": 0
  };

  double headerWidth=SizeConfig.screenWidth!-(150+15+50);

  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0xffFAFAF8),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              children: [
                ListView(
                 shrinkWrap: true,
                  children:[
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth!-150,
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ArrowBack(
                                    iconColor: ColorUtil.themeBlack,
                                    onTap: (){
                                      Get.back();
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widgets[0],
                                      widgets[1],
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/trees/user-icon.png",width: 40,),
                                  const SizedBox(width: 10,),
                                  Text("${treeDetails['SeedCount']} ",style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/trees/user-icon.png",width: 40,),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    width: headerWidth,
                                    child: RichText(
                                        text: TextSpan(text: "${treeDetails['NurseryCount']} ",style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 20),
                                        children: <TextSpan>[
                                          TextSpan(text: "${treeDetails['NurseryAddress']} ", style: TextStyle(color:ColorUtil.text4,fontFamily: 'RR',fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/trees/user-icon.png",width: 40,),
                                  const SizedBox(width: 10,),

                                  SizedBox(
                                    width: headerWidth,
                                    child: RichText(
                                      text: TextSpan(text: "${treeDetails['PlantationCount']} ",style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 20),
                                        children: <TextSpan>[
                                          TextSpan(text:"${treeDetails['PlantationAddress']} " , style: TextStyle(color:ColorUtil.text4,fontFamily: 'RR',fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                            height: 280,
                            child: Image.asset("assets/trees/tree-100.png",fit: BoxFit.fill,)
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: TreeOtherDetails.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,i){
                        return Container(
                          width: SizeConfig.screenWidth,
                          padding:const EdgeInsets.all(10),
                          margin:const EdgeInsets.only(left:15,right: 15,bottom: 10),
                          decoration: BoxDecoration(
                              color: ColorUtil.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: RichText(
                            text: TextSpan(text: '${TreeOtherDetails[i]['Title']} ',style: TextStyle(color:ColorUtil.secondary,fontFamily: 'RB',fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(text: '${TreeOtherDetails[i]['SubTitle']}', style: TextStyle(color:ColorUtil.secondary.withOpacity(0.8),fontFamily: 'RR',fontSize: 14)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15,),
                    ListView.builder(
                      itemCount: ListofUses.length,
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,i){
                        return GestureDetector(
                          onTap: (){
                              fadeRoute(OurTreeUsesView());
                          },
                          child: Container(
                            margin:const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/trees/user-icon.png",width: 40,),
                                    const SizedBox(width: 20,),
                                    Text('${ListofUses[i]['Title']}',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios_outlined,size: 15,color: ColorUtil.primary,)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
                Positioned(
                  bottom: -10,
                  child: Container(
                    height: 70,
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: ColorUtil.primary,
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.share_outlined,color: ColorUtil.themeWhite,),
                            SizedBox(width: 5,),
                            Text('Share',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                          ],
                        ),
                        Container(
                          width: 1,
                          color: ColorUtil.themeWhite,
                        ),
                        Row(
                          children: [
                            Icon(Icons.save_alt_outlined,color: ColorUtil.themeWhite,),
                            SizedBox(width: 5,),
                            Text('Download',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    widgets.add(HE_Text(dataname: "TreeName", contentTextStyle: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 20),));
    widgets.add(HE_Text(dataname: "SubCatg", contentTextStyle: TextStyle(color:ColorUtil.secondary,fontFamily: 'RB',fontSize: 20),));
    // widgets.add(HE_Text(dataname: "Plants", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Place", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));


    await parseJson(widgets, General.TreeViewIdentifier);

    treeDetails=valueArray.where((element) => element['key']=='TreeDetails').toList()[0]['value'];
    TreeOtherDetails=valueArray.where((element) => element['key']=='TreeOtherDetails').toList()[0]['value'];
    ListofUses=valueArray.where((element) => element['key']=='ListofUses').toList()[0]['value'];
    setState(() {});
  }
}
