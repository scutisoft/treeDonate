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
import '../../widgets/customCheckBox.dart';


class NurseryView extends StatefulWidget {
  @override
  _NurseryViewState createState() => _NurseryViewState();
}

class _NurseryViewState extends State<NurseryView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  final List<String> imgList = [
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
  ];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<dynamic> NurserySysView = [];
  List<dynamic> NurseryView = [];

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
                      widgets[0],
                     // Text('Form Nursery',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),
                      Image.asset('assets/Slice/status-tick.png',width: 30,)
                    ],
                  ),
                  SizedBox(height: 2,),
                  widgets[1],
                 // Text('dharmapuri / Sudanur Village',style: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:Border(top: BorderSide(color: ColorUtil.greyBorder,),left: BorderSide(color: ColorUtil.greyBorder,),right: BorderSide(color: ColorUtil.greyBorder,))
                    ),
                    child: Table(
                      // defaultColumnWidth: FixedColumnWidth(160.0),
                      border: TableBorder.all(
                          color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                      children: [
                              TableRow(
                              children: [
                              Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Date',style: TextStyle(fontSize: 15,fontFamily: 'RR',color: ColorUtil.text4),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Plant Name',style: TextStyle(fontSize: 15,fontFamily: 'RM',color: ColorUtil.text4),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No of Plants',style: TextStyle(fontSize: 15,fontFamily: 'RR',color: ColorUtil.text4),),
                            ),
                          ]
                        ),
                        for(int i=0;i<NurserySysView.length;i++)
                        tableView3(NurserySysView[i]['Date'],NurserySysView[i]['PlantName'],NurserySysView[i]['NoOfPlant'],ColorUtil.themeBlack),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                    child: Table(
                     // defaultColumnWidth: FixedColumnWidth(160.0),
                      border: TableBorder.all(
                          color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                      children: [
                        for(int i=0;i<NurseryView.length;i++)
                        tableView(NurseryView[i]['Title'],NurseryView[i]['Value'],ColorUtil.greyBorder,ColorUtil.themeBlack),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      isNewsFeed.value=!isNewsFeed.value;
                    },
                    child: Obx(() => Container(
                      margin: EdgeInsets.only(left: 10, right: 10,top: 10),
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: isNewsFeed.value? ColorUtil.primary:ColorUtil.text4,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomCheckBox(
                            isSelect: isNewsFeed.value,
                            selectColor: ColorUtil.primary,
                          ),
                          SizedBox(width: 5,),
                          Text('Do You Want To Show This News Feed',style: TextStyle(color: isNewsFeed.value?ColorUtil.themeWhite:ColorUtil.themeBlack),)
                        ],
                      ),

                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth!*0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: ColorUtil.red),
                            color: ColorUtil.red.withOpacity(0.3),
                          ),
                          child:Center(child: Text('Reject',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.red,fontFamily:'RR'), )) ,
                        ),
                        Container(
                          width: SizeConfig.screenWidth!*0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ColorUtil.primary,
                          ),
                          child:Center(child: Text('Accept',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                        ),
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
    widgets.add(HE_Text(dataname: "SeedingPageTitle",  contentTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),);
    widgets.add(HE_Text(dataname: "LandDistrictVillage", contentTextStyle: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),),);
    await parseJson(widgets, General.NurseryViewIdentifier);
    try{

      NurserySysView=valueArray.where((element) => element['key']=="NurserySys").toList()[0]['value'];
      NurseryView=valueArray.where((element) => element['key']=="NurseryViewList").toList()[0]['value'];
      setState((){});

    }catch(e){
    }

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
  TableRow tableView3(String td1,String td2,String td3,Color textcolor ){
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(td1,style: TextStyle(fontSize: 15,fontFamily: 'RR',color: textcolor),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(td2,style: TextStyle(fontSize: 15,fontFamily: 'RM',color: textcolor),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(td3,style: TextStyle(fontSize: 15,fontFamily: 'RR',color: textcolor),),
          ),
        ]
    );
  }
}
