import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/apiUtils.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/loader.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../widgets/treeDonateWidgets.dart';


class OurTreeUsesView extends StatefulWidget {
  String dataJson;
  String title;
  OurTreeUsesView({this.dataJson="",required this.title});
  @override
  _OurTreeUsesViewState createState() => _OurTreeUsesViewState();
}

class _OurTreeUsesViewState extends State<OurTreeUsesView> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  List<Widget> widgets=[];

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  List<dynamic> TreeOtherDetails=[];

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
                    CustomAppBar(
                      title: widget.title,
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin:const EdgeInsets.only(left:15,right: 15,),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StackIcon(
                            icon: SvgPicture.asset("assets/Slice/nursery.svg",color: ColorUtil.primary,height: 28,),
                          ),
                          const SizedBox(width: 10,),
                          widgets[0],
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ListView.builder(
                      itemCount: TreeOtherDetails.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,i){
                        return Container(
                          width: SizeConfig.screenWidth,
                          margin:const EdgeInsets.only(left:15,right: 15,bottom: 15),
                          decoration: BoxDecoration(
                             // color: ColorUtil.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(right: 10,top: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle
                                ),
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset("assets/splash.jpg"),
                              ),
                              Expanded(
                                child: Text('${TreeOtherDetails[i]['Description']}',
                                    style: TextStyle(color:ColorUtil.secondary.withOpacity(0.8),fontFamily: 'MMR',fontSize: 14)
                                ),
                              )
                            ],
                          )
                          /*child: RichText(
                            text: TextSpan(text: '${TreeOtherDetails[i]['Title']} ',style: TextStyle(color:ColorUtil.secondary,fontFamily: 'MMB',fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(text: '${TreeOtherDetails[i]['Description']}', style: TextStyle(color:ColorUtil.secondary.withOpacity(0.8),fontFamily: 'MMR',fontSize: 14)),
                              ],
                            ),
                          ),*/
                        );
                      },
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
                Positioned(
                  bottom: -10,
                  child: Container(
                    height: 0,
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
                            Icon(Icons.copy_all,color: ColorUtil.themeWhite,),
                            SizedBox(width: 5,),
                            Text('Copy',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ShimmerLoader()
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
    await parseJson(widgets, General.TreeUsesViewIdentifier,dataJson: widget.dataJson);
    console(valueArray);
    TreeOtherDetails=valueArray.where((element) => element['key']=='TreeOtherDetails').toList()[0]['value'];
    setState(() {});
  }
}
