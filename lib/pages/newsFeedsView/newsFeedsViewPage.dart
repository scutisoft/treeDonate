import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/widgets/customCheckBox.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';


class NewsFeedsView extends StatefulWidget {
  VoidCallback voidCallback;
  NewsFeedsView({required this.voidCallback});
  @override
  _NewsFeedsViewState createState() => _NewsFeedsViewState();
}

class _NewsFeedsViewState extends State<NewsFeedsView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  final List<String> imgList = [
    'assets/Slice/newsfeeds-2.jpg',
    'assets/Slice/newsfeeds-3.jpg',
    'assets/Slice/newsfeeds-4.jpg',
    'assets/Slice/newsfeeds-5.jpg',
    'assets/Slice/newsFeeds-1.jpg',
  ];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    silverController = ScrollController();
    assignWidgets();
    super.initState();
  }

  var node;
  var isNewsFeed=false.obs;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: Container(
              child: Column(
                children: [
                  Container(
                    height: 160,
                    width: SizeConfig.screenWidth,
                    color: Colors.red,
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: 160,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
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
                            width: SizeConfig.screenWidth,))
                              .toList(),
                        ),
                        Positioned(
                            top: 5,
                            left: 5,
                            child: ArrowBack(
                              iconColor: ColorUtil.themeBlack,
                              onTap: () {
                                Get.back();
                              },
                            ),
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
                  Container(
                    height: SizeConfig.screenHeight!-170,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(child: Text("Mr.Balasubramaniyan",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),)),
                                  Text("Zone 7 Co-Ordinator",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Form Land',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),
                              Image.asset('assets/Slice/status-tick.png',width: 30,)
                            ],
                          ),
                          SizedBox(height: 2,),
                          Text('Kanchipuram / Pallipedu Village',style: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),),
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Table(
                             // defaultColumnWidth: FixedColumnWidth(160.0),
                              border: TableBorder.all(
                                  color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                              children: [
                                tableView('Type Of Land','Coastal Forest',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Staff','Balasubramanyani',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Mobile','90923-22264',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Email','Balasubramanyani@gmail.com',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Soil Type','Black Cotton Soil',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Survey Number','585265885',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Hectare','100 Hectare',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Acre','247.1 Acre',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Planting year','2023',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Village','Tirumalai',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Taluk','Sivagangai  ',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('District','SIVAGANGAI  ',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Address','14 NP Developed Plots,100 Feet Rd, Thiru Vi Ka Industrial Estate, Sivagangai, TamilNadu 600032',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Location','13.0233232,80.2203782',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('User Name','Muthu Gokul',ColorUtil.greyBorder,ColorUtil.themeBlack),
                                tableView('Role','Village Coordinator',ColorUtil.greyBorder,ColorUtil.themeBlack),
                              ],
                            ),
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
  void assignWidgets() async {
    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }

  TableRow tableView(String tabelHead,String tablevalue,Color textcolor1,Color textcolor2 ){
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tabelHead,style: TextStyle(fontSize: 15,fontFamily: 'RR',color: textcolor1),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tablevalue,style: TextStyle(fontSize: 15,fontFamily: 'RM',color: textcolor2),),
          ),
        ]
    );
  }
}
