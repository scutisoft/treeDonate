import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/apiUtils.dart';
import 'package:treedonate/widgets/accessWidget.dart';
import '../../utils/utils.dart';
import '../../widgets/customCheckBox.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/loader.dart';


class LandParcelView extends StatefulWidget {
  String? dataJson;
  Function? closeCb;
  LandParcelView({this.closeCb,this.dataJson=""});
  @override
  _LandParcelViewState createState() => _LandParcelViewState();
}

class _LandParcelViewState extends State<LandParcelView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  List<dynamic> imgList = [];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> landParcelView = [];

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
          body: Stack(
            children: [
              NestedScrollView(
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
                          color: Colors.white,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 160,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                    reverse: false,
                                    autoPlay: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }
                                ),
                                carouselController: _controller,
                                items: imgList
                                    .map((item) => Image.network(
                                  GetImageBaseUrl()+item["ImagePath"], fit: BoxFit.contain,
                                  width: SizeConfig.screenWidth,
                                )
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
                          Image.asset('assets/Slice/status-tick.png',width: 30,)
                        ],
                      ),
                      SizedBox(height: 2,),
                      widgets[1],
                      SizedBox(height: 5,),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Table(
                          // defaultColumnWidth: FixedColumnWidth(160.0),
                          border: TableBorder.all(
                              color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                          children: [
                            for(int i=0;i<landParcelView.length;i++)
                              tableView(landParcelView[i]['Title'],landParcelView[i]['Value'],ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Type Of Land','Coastal Forest',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Staff','Balasubramanyani',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Mobile','90923-22264',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Email','Balasubramanyani@gmail.com',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Soil Type','Black Cotton Soil',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Survey Number','585265885',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Hectare','100 Hectare',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Acre','247.1 Acre',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Planting year','2023',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Village','Tirumalai',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Taluk','Sivagangai  ',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('District','SIVAGANGAI  ',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Address','14 NP Developed Plots,100 Feet Rd, Thiru Vi Ka Industrial Estate, Sivagangai, TamilNadu 600032',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Location','13.0233232,80.2203782',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('User Name','Muthu Gokul',ColorUtil.greyBorder,ColorUtil.themeBlack),
                            // tableView('Role','Village Coordinator',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          ],
                        ),
                      ),
                      AccessWidget(
                        hasAccess: isHasAccess(accessId['LandParcelApproval']),
                        needToHide: true,
                        onTap: (){
                          isNewsFeed.value=!isNewsFeed.value;
                        },
                        widget: Obx(() => Container(
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
                                onlyCheckbox: true,
                              ),
                              const SizedBox(width: 5,),
                              Text('Do You Want To Show This News Feed',style: TextStyle(color: isNewsFeed.value?ColorUtil.themeWhite:ColorUtil.themeBlack),)
                            ],
                          ),

                        )),
                      ),
                      AccessWidget(
                        hasAccess: isHasAccess(accessId['LandParcelApproval']),
                        needToHide: true,
                        widget: Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  approveRejHandler(false);
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth!*0.4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: ColorUtil.red),
                                    color: ColorUtil.red.withOpacity(0.3),
                                  ),
                                  child:Center(child: Text('Reject',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.red,fontFamily:'RR'), )) ,
                                ),
                              ),
                              GestureDetector(
                                onTap:(){
                                  approveRejHandler(true);
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth!*0.4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: ColorUtil.primary,
                                  ),
                                  child:Center(child: Text('Accept',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
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
              ShimmerLoader()
            ],
          )
        )
    );

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
  @override
  void assignWidgets() async {

    widgets.add(HE_Text(dataname: "PageTitle",  contentTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),);
    widgets.add(HE_Text(dataname: "LandDistrictVillage", contentTextStyle: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),),);

    widgets.add(HiddenController(dataname: "LandParcelId"));
    widgets.add(HiddenController(dataname: "IsNewsFeed"));
    widgets.add(HiddenController(dataname: "IsAccept"));
    await parseJson(widgets, General.addLandParcelViewIdentifier,dataJson: widget.dataJson);
    try{

      landParcelView=valueArray.where((element) => element['key']=="LandParcelView").toList()[0]['value'];
      isNewsFeed.value=valueArray.where((element) => element['key']=="IsNewsFeed").toList()[0]['value'];
      imgList=valueArray.where((element) => element['key']=="LandImagesList").toList()[0]['value'];
      setState((){});

    }catch(e){
    }
  }


  void approveRejHandler(isAccept){
    sysSubmit(widgets,isEdit: true,
        needCustomValidation: true,
        onCustomValidation: (){
          foundWidgetByKey(widgets,"IsNewsFeed",needSetValue: true,value: isNewsFeed.value);
          foundWidgetByKey(widgets,"IsAccept",needSetValue: true,value: isAccept);
          return true;
        },
        successCallback: (e){
          if(widget.closeCb!=null){
            widget.closeCb!(e);
          }
        }
    );
  }

  @override
  String getPageIdentifier(){
    return General.addLandParcelViewIdentifier;
  }

}
