import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';


class PlantingView extends StatefulWidget {
  @override
  _PlantingViewState createState() => _PlantingViewState();
}

class _PlantingViewState extends State<PlantingView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  final List<String> imgList = [
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
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

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: true,
                  snap: true,
                  pinned: false,
                  leading: ArrowBack(
                    iconColor: ColorUtil.themeBlack,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    //expandedTitleScale: 1.8,
                    background: Container(
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
                              item, fit: BoxFit.fill,
                              width: SizeConfig.screenWidth,))
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
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Form Plantation',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),
                      Image.asset('assets/Slice/status-tick.png',width: 30,)
                    ],
                  ),
                  SizedBox(height: 2,),
                  Text('dharmapuri / Sudanur Village',style: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(160.0),
                      border: TableBorder.all(
                          color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                      children: [
                        tableView('Event Name','GMT Planting',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('No of Plants','2000',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('District','Dharmapuri',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('Taluk','Gummanur',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('village','Sudanur',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('Land to Plant Trees','Bala / Owner',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('Location','13.0233232,80.2203782',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        tableView('Bag Material & Size','Poly Bag (32*13)',ColorUtil.greyBorder,ColorUtil.themeBlack),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
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
