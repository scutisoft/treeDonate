import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/pages/landParcel/LandParcelGrid.dart';
import 'package:treedonate/pages/navHomeScreen.dart';
import 'package:treedonate/widgets/customAppBar.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid_tile.dart';

class LandingPage extends StatefulWidget {
  VoidCallback voidCallback;
  LandingPage({required this.voidCallback});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  final List<String> imgList = [
    'assets/Slice/Landing-slider-sm.jpg',
    'assets/Slice/Landing-slider-sm-1.jpg',
    'assets/Slice/Landing-slider-sm-2.jpg',
  ];

  List<Widget> widgets=[];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: ColorUtil.theme,
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 80,
                    child: Container(
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){
                              assignWidgets();
                              widget.voidCallback();
                            },
                                icon: Icon(Icons.grid_view_rounded,color:ColorUtil.primary)
                              //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Mr.Balasubramaniyan",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),),
                                    Text("Zone 7 Co-Ordinator",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                                  ],
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorUtil.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                                ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorUtil.themeWhite,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      children: [
                                        Icon(Icons.notifications,color:Colors.orangeAccent,size: 25,),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorUtil.red,
                                            ),
                                            child: Text("1",style:  TextStyle(fontFamily: 'RR',fontSize: 10,color: Colors.white),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),

                          ],
                        ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 190,
                          width: SizeConfig.screenWidth!*0.9,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                clipBehavior: Clip.antiAlias,
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      height: 160,
                                      enlargeCenterPage: false,
                                      viewportFraction: 1,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }
                                  ),
                                  carouselController: _controller,
                                  items: imgList
                                      .map((item) => Image.asset(
                                    item, fit: BoxFit.cover,
                                    width: SizeConfig.screenWidth,height: 160,))
                                      .toList(),
                                ),
                              ),
                              Row(
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          child: buildGrid(),
                        ),



                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
    );
  }
  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children:  [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: GestureDetector(
            onTap: (){
              setPageNumber(9);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.red.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/Land-parcel.png',fit: BoxFit.cover,height: SizeConfig.screenHeight,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Land Parcel",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                            Text("500 Hectare",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
              setPageNumber(11);
            },
            child: Container(
              // width: SizeConfig.screenWidth!*0.4,
              // height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.red.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/seeds.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Seed collection",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                            Text("500 Kg",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
              setPageNumber(12);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.red.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/nursery.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Nursery",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                            Text("250 Numbers",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child:GestureDetector(
            onTap: (){
              setPageNumber(10);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.red.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/planting.png',height: SizeConfig.screenHeight,fit: BoxFit.fill,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Plantings",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                            Text("50,00,000",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  void assignWidgets() async{
    widgets.clear();


    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
