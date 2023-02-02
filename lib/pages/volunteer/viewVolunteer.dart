import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/utils/utils.dart';
import '../../widgets/customCheckBox.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


class VolunteerView extends StatefulWidget {
  @override
  _VolunteerViewState createState() => _VolunteerViewState();
}

class _VolunteerViewState extends State<VolunteerView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  final List<String> imgList = [
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
    'assets/trees/green-pasture-with-mountain.jpg',
  ];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> landParcelView = [];
  String page="VolunteerRoleAssignment";

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
                      padding: EdgeInsets.only(left: 50),
                      child: Text("Volunteer Detail",style: ts18(ColorUtil.themeBlack,fontfamily: 'RM',ls: 0.8,fontsize: 20),),
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
                    widgets[2],
                    widgets[3],
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

                    const SizedBox(height: 80,)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child:  Container(
                    padding: EdgeInsets.only(top: 0,bottom: 0),
                    color: Colors.white,
                    width: SizeConfig.screenWidth,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            var fWid=foundWidgetByKey(widgets, "VolunteerId");
                            print(fWid);
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
                          child:Center(child: Text('Accept',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                        ),
                      ],
                    ),
                  ),
                )
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
    widgets.add(SearchDrp2(map: const {"dataName":"VolunteerRoleId","hintText":"Select Work Field","labelText":"Work Field"},));
    widgets.add(SearchDrp2(map: const {
      "dataName":"DistrictId","hintText":"Select District","showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":EdgeInsets.all(0.0),"labelText":"District"
    },
      onchange: (e){
        console("onchange $e");
        fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
      },
    ));
    widgets.add(SearchDrp2(map: const {
      "dataName":"TalukId","hintText":"Select Taluk","showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":EdgeInsets.all(0.0),"labelText":"Taluk"
    },
      onchange: (e){
        fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id']);
      },
    ));
    widgets.add(SearchDrp2(map: const {
      "dataName":"VillageId","hintText":"Select Village","showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":EdgeInsets.all(0.0),"labelText":"Village"
    },));

    widgets.add(HiddenController(dataname: "VolunteerId"));

    await parseJson(widgets, General.viewVolunteerIdentifier);

    try{
      landParcelView=valueArray.where((element) => element['key']=="VolunteerDetail").toList()[0]['value'];
      setState((){});
    }catch(e){}
  }

}
