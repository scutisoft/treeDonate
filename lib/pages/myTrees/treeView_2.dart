import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../api/apiUtils.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../widgets/treeDonateWidgets.dart';
import 'treeUsesView_3.dart';


class OurTreeView extends StatefulWidget {
  String dataJson;
  OurTreeView({this.dataJson=""});
  @override
  _OurTreeViewState createState() => _OurTreeViewState();
}

class _OurTreeViewState extends State<OurTreeView> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  List<dynamic> widgets=[];
  List<dynamic> imgList = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

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

  double headerWidth=SizeConfig.screenWidth!-(35+50);

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
                    Container(
                      height: 180,
                      width: SizeConfig.screenWidth,
                      color: Color(0xffFAFAF8),
                      child: Stack(
                        children: [
                          Container(
                            height: 160,
                            width: SizeConfig.screenWidth,
                            color: ColorUtil.primary,
                            clipBehavior: Clip.none,
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      height: 160,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }
                                  ),
                                  carouselController: _controller,
                                  items: imgList
                                      .map((item) =>  Image.network(
                                    GetImageBaseUrl()+item["ImagePath"], fit: BoxFit.contain,
                                    width: SizeConfig.screenWidth,
                                  ),
                                    //   Image.asset(
                                    // GetImageBaseUrl()+item["Img"], fit: BoxFit.cover,
                                    // width: SizeConfig.screenWidth,)
                                  )
                                      .toList(),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: imgList
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () =>
                                            _controller.animateToPage(entry.key),
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme
                                                  .of(context)
                                                  .brightness == Brightness.dark
                                                  ? Colors.white
                                                  : ColorUtil.primary)
                                                  .withOpacity(
                                                  _current == entry.key ? 0.9 : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ArrowBack(
                                      iconColor: ColorUtil.themeWhite,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          widgets[0],
                                          widgets[1],
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 15.0,top: 13),
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtil.primary,
                                  ),
                                  child: Icon(Icons.favorite,color: ColorUtil.themeWhite,size: 25,),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            right: 15,
                            top: 145,
                            child: Container(
                                width: 110,
                                height: 30,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: Colors.amber,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 25.0, // soften the shadow
                                      spreadRadius: 0.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/Slice/seed-outline.svg",color: ColorUtil.primary),
                                    const SizedBox(width: 5,),
                                    Text("${treeDetails['SeedCount']} ",style: TextStyle(color:ColorUtil.primary,fontFamily:'RB',fontSize: 16),),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: SizeConfig.screenWidth,
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StackIcon(
                                icon: SvgPicture.asset("assets/Slice/nursery.svg",color: ColorUtil.primary,height: 28,),
                              ),

                              //Image.asset("assets/trees/user-icon.png",width: 40,),
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
                              StackIcon(
                                icon: SvgPicture.asset("assets/Slice/leaf.svg",color: ColorUtil.primary,height: 25,),
                              ),
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
                    const SizedBox(height: 10,),
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
                            text: TextSpan(text: '${getTamilWord(TreeOtherDetails[i]['Title'])}  ',style: TextStyle(color:ColorUtil.secondary,fontFamily: 'MMB',fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(text: '${TreeOtherDetails[i]['SubTitle']}', style: TextStyle(color:ColorUtil.secondary.withOpacity(0.8),fontFamily: 'MMR',fontSize: 14)),
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
                            fadeRoute(OurTreeUsesView(dataJson: getDataJsonForGrid(ListofUses[i]['DataJson']),));
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
                                    StackIcon(icon: Image.asset("assets/Slice/description.png",height: 20,color: ColorUtil.primary,),top: 2,right: 1,),
                                    const SizedBox(width: 20,),
                                    Text('${ListofUses[i]['Title']??""}',style: TextStyle(color:ColorUtil.primary,fontFamily: 'MMR',fontSize: 16),)
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
                            Icon(Icons.copy_all,color: ColorUtil.themeWhite,),
                            SizedBox(width: 5,),
                            Text('Copy',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
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
    widgets.add(HE_Text(dataname: "TreeName", contentTextStyle: TextStyle(color:ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 20),));
    widgets.add(HE_Text(dataname: "SubCatg", contentTextStyle: TextStyle(color:ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 20),));
    // widgets.add(HE_Text(dataname: "Plants", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Place", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    // widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));


    await parseJson(widgets, General.TreeViewIdentifier,dataJson: widget.dataJson);

    console(valueArray);
    treeDetails=valueArray.where((element) => element['key']=='TreeDetails').toList()[0]['value'];
    TreeOtherDetails=valueArray.where((element) => element['key']=='TreeOtherDetails').toList()[0]['value'];
    ListofUses=valueArray.where((element) => element['key']=='ListofUses').toList()[0]['value'];
    imgList=valueArray.where((element) => element['key']=="ImagesList").toList()[0]['value'];
    setState(() {});
  }
}
