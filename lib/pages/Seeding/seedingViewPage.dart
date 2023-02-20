import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/widgets/loader.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../api/apiUtils.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../widgets/accessWidget.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customCheckBox.dart';
import '../../widgets/fittedText.dart';


class SeedingView extends StatefulWidget {
  String? dataJson;
  Function? closeCb;
  SeedingView({this.closeCb,this.dataJson=""});
  @override
  _SeedingViewState createState() => _SeedingViewState();
}

class _SeedingViewState extends State<SeedingView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  List<dynamic> imgList = [];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> SeedsView = [];
  List<dynamic> SeedsGiverView = [];

  var isNeedApproval=false.obs;

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
                      color: Colors.white,
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
                                .map((item) =>item["ImagePath"]==null?Container(): Image.network(
                              GetImageBaseUrl()+item["ImagePath"], fit: BoxFit.contain,
                              width: SizeConfig.screenWidth,)
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
            body: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgets[0],
                        Image.asset('assets/Slice/status-tick.png',width: 30,)
                      ],
                    ),
                    const SizedBox(height: 2,),
                    widgets[1],
                    const SizedBox(height: 5,),
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
                                  child: Text(Language.seed,style: ts15(ColorUtil.text4),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(Language.quantity,style: ts15(ColorUtil.text4),),
                                ),
                              ]
                          ),
                          for(int i=0;i<SeedsView.length;i++)
                            tableView2(SeedsView[i]['TreeName']??"",SeedsView[i]['Quantity']??"",ColorUtil.themeBlack),
                          // tableView2('Palm Seed','40',ColorUtil.themeBlack),
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
                          for(int i=0;i<SeedsGiverView.length;i++)
                            tableView(SeedsGiverView[i]['Title'],SeedsGiverView[i]['Value'],ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Seeds','Veembu seeds',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Quantity','2,000',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Name','Bala',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Mobile No','9092322265',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Address','14 NP Developed Plots,100 Feet Rd, Thiru Vi Ka Industrial Estate, ',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('State','Tamil Nadu',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('District','Chennai',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Taluk','Puzhal',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Village','Puzhal',ColorUtil.greyBorder,ColorUtil.themeBlack),
                          // tableView('Role','Village Coordinator',ColorUtil.greyBorder,ColorUtil.themeBlack),
                        ],
                      ),
                    ),
                    AccessWidget(
                      hasAccess: isHasAccess(accessId['SeedCollectionApproval']) && isNeedApproval.value,
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
                            FittedText(
                              alignment: Alignment.centerLeft,
                              text: Language.newsFeedChkBox,
                              textStyle: ts14(isNewsFeed.value?ColorUtil.themeWhite:ColorUtil.themeBlack,),
                            ),
                          ],
                        ),

                      )),
                    ),

                  ],
                ),
                Positioned(
                  bottom: 0,
                  child:  AccessWidget(
                    hasAccess: isHasAccess(accessId['SeedCollectionApproval']) && isNeedApproval.value,
                    needToHide: true,
                    widget: Container(
                      height: 70,
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
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
                              child:Center(child: Text(Language.reject,style: ts16(ColorUtil.red,), )) ,
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
                              child:Center(child: Text(Language.accept,style: ts16(ColorUtil.themeWhite,), )) ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ShimmerLoader()
              ],
            ),
          ),
        )
    );

  }

  @override
  void assignWidgets() async {

    widgets.add(HE_Text(dataname: "PageTitle",  contentTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),);
    widgets.add(HE_Text(dataname: "DistrictVillage", contentTextStyle: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),textAlign: TextAlign.center,),);

    widgets.add(HiddenController(dataname: "SeedId"));
    widgets.add(HiddenController(dataname: "IsNewsFeed"));
    widgets.add(HiddenController(dataname: "IsAccept"));

    await parseJson(widgets, getPageIdentifier(),dataJson: widget.dataJson);
    try{

      isNewsFeed.value =valueArray.where((element) => element['key']=="IsNewsFeed").toList()[0]['value'];
      SeedsGiverView=valueArray.where((element) => element['key']=="SeedingView").toList()[0]['value'];
      SeedsView=valueArray.where((element) => element['key']=="Seeds").toList()[0]['value'];
      imgList=valueArray.where((element) => element['key']=="ImagesList").toList()[0]['value'];
      var x=valueArray.where((element) => element['key']=="IsNeedApproval").toList();
      isNeedApproval.value=x.isNotEmpty?x[0]['value']:MyConstants.defaultActionEnable;
      setState((){});

    }catch(e){
      console(e);
    }

  }

  @override
  String getPageIdentifier(){
    return General.addSeedviewListIdentifier;
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
  TableRow tableView2(String td1,String td2,Color textcolor ){
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
        ]
    );
  }
}
