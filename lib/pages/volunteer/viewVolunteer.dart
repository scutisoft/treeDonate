import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/widgets/fittedText.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../widgets/accessWidget.dart';
import '../../widgets/pinWidget.dart';
import '../../api/ApiManager.dart';
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
import '../../widgets/searchDropdown/dropdown_search.dart';


class VolunteerView extends StatefulWidget {
  bool isEdit;
  String? dataJson;
  Function? closeCb;


  VolunteerView({this.closeCb,this.dataJson="",this.isEdit=false});
  @override
  _VolunteerViewState createState() => _VolunteerViewState();
}

class _VolunteerViewState extends State<VolunteerView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  final List<String> imgList = [
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
  ];
  List<dynamic> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> landParcelView = [];
  String page="VolunteerRoleAssignment";

  var showTaluk=false.obs;
  var showVillage=false.obs;

  @override
  void initState() {
    silverController = ScrollController();
    assignWidgets();
    super.initState();
  }

  var node;
  var isNewsFeed=false.obs;
  var isEGFZone=false.obs;

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
                  expandedHeight: 50.0,
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
                      height: 50,
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(Language.volunteerDetails,style: ts18(ColorUtil.themeBlack,fontfamily:Language.mediumFF,ls: 0.8,fontsize: 20),),
                      /*child: Stack(
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
                      ),*/
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children:[
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Table(
                        // defaultColumnWidth: FixedColumnWidth(160.0),
                        border: TableBorder.all(
                            color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                        children: [
                          for(int i=0;i<landParcelView.length;i++)
                            tableView(landParcelView[i]['Title'],landParcelView[i]['Value'],ColorUtil.greyBorder,ColorUtil.themeBlack),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    widgets[0],
                    widgets[1],
                    Obx(() => Visibility(visible: showTaluk.value,child: widgets[2])),
                    Obx(() => Visibility(visible: showVillage.value,child: widgets[3])),
                    AccessWidget(
                      hasAccess: isHasAccess(accessId['VolunteerApproval']),
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
                           // Text(Language.newsFeedChkBox,style: TextStyle(color: isNewsFeed.value?ColorUtil.themeWhite:ColorUtil.themeBlack),)
                          ],
                        ),

                      )),
                    ),
                    AccessWidget(
                      hasAccess: isHasAccess(accessId['EGFZoneApproval']),
                      needToHide: true,
                      widget: Obx(() => Container(
                        margin: EdgeInsets.only(left: 10, right: 10,top: 10),
                        padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                        /*decoration: BoxDecoration(
                            color: isNewsFeed.value? ColorUtil.primary:ColorUtil.text4,
                            borderRadius: BorderRadius.circular(10)
                        ),*/
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CupertinoSwitch(
                              value: isEGFZone.value,
                              activeColor: ColorUtil.primary,
                              onChanged: (v){
                                isEGFZone.value=v;
                              },
                            ),
                           Text("   EGF Zone",style: ts20(ColorUtil.themeBlack),)
                          ],
                        ),

                      )),
                    ),

                    const SizedBox(height: 80,)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child:  AccessWidget(
                    hasAccess: isHasAccess(accessId['VolunteerApproval']),
                    needToHide: true,
                    widget: Container(
                      padding: EdgeInsets.only(top: 0,bottom: 0),
                      color: Colors.white,
                      width: SizeConfig.screenWidth,
                      height: 70,
                      alignment: Alignment.center,
                      child: DoneBtn(onDone: (){
                        sysSubmit(widgets,isEdit: widget.isEdit,
                          needCustomValidation: true,
                          onCustomValidation: (){
                            foundWidgetByKey(widgets,"IsNewsFeed",needSetValue: true,value: isNewsFeed.value);
                            foundWidgetByKey(widgets,"VolunteerRoleTypeId",needSetValue: true,value: isEGFZone.value);
                            return true;
                          },
                          successCallback: (e){
                            console("sysSubmit $e");
                            if(widget.closeCb!=null){
                              widget.closeCb!(e);
                            }
                          }
                        );
                      }, title: Language.update),
                      /*child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              sysSubmit(widgets,isEdit: widget.isEdit);
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
                          Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: ColorUtil.primary,
                            ),
                            child:const Center(child: Text('Accept',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                          ),
                        ],
                      ),*/
                    ),
                  ),
                ),
                ShimmerLoader(),
              ]
            ),
          ),
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
    widgets.add(SearchDrp2(map:  {"dataName":"VolunteerRoleId","hintText":Language.selWorkField,"labelText": Language.workField},
    onchange: (e){onRoleChange(e['Id'].toString());},));
    widgets.add(SearchDrp2(map:  {
      "dataName":"DistrictId","hintText":Language.selDistrict,"showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":const EdgeInsets.all(0.0),"labelText":Language.district
    },
      onchange: (e){
        console("onchange $e");
        fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
      },
    ));
    widgets.add(SearchDrp2(map:  {
      "dataName":"TalukId","hintText":Language.selTaluk,"showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":const EdgeInsets.all(0.0),"labelText":Language.taluk
    },
      onchange: (e){
        fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id']);
      },
    ));
    widgets.add(SearchDrp2(map:  {
      "dataName":"VillageId","hintText": Language.selVillage,"showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":const EdgeInsets.all(0.0),"labelText": Language.village
    },));

    widgets.add(HiddenController(dataname: "VolunteerId"));
    widgets.add(HiddenController(dataname: "IsNewsFeed"));
    widgets.add(HiddenController(dataname: "VolunteerRoleTypeId"));

    await parseJson(widgets, getPageIdentifier(),dataJson: widget.dataJson);
    try{
      landParcelView=valueArray.where((element) => element['key']=="VolunteerDetail").toList()[0]['value'];
      isNewsFeed.value=valueArray.where((element) => element['key']=="IsNewsFeed").toList()[0]['value'];
      isEGFZone.value=valueArray.where((element) => element['key']=="VolunteerRoleTypeId").toList()[0]['value'];
      setState(() {});
    }catch(e) {
      console(e);
    }
  }

  @override
  String getPageIdentifier(){
    return General.viewVolunteerIdentifier;
  }



  void onRoleChange(roleId){
    console("Role $roleId");
    if(roleId=="7"||roleId=="4"){
      showTaluk.value=false;
      showVillage.value=false;
    }
    else if(roleId=="5"){
      showTaluk.value=true;
      showVillage.value=false;
      console("${showTaluk.value}");
    }
    else if(roleId=="6"){
      showTaluk.value=true;
      showVillage.value=true;
    }
    widgets[2].required=showTaluk.value;
    widgets[3].required=showVillage.value;
    widgets[2].clearValues();
    widgets[3].clearValues();
    widgets[3].setValue([]);
  }

}
