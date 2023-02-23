import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:treedonate/api/ApiManager.dart';
import 'package:treedonate/api/apiUtils.dart';
import 'package:treedonate/model/parameterMode.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/alertDialog.dart';
import 'package:treedonate/widgets/fittedText.dart';
import 'package:treedonate/widgets/loader.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../helper/language.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/navigationBarIcon.dart';


class CSRDashboard extends StatefulWidget {
  VoidCallback voidCallback;
  CSRDashboard({required this.voidCallback});
  @override
  _CSRDashboardState createState() => _CSRDashboardState();
}

class _CSRDashboardState extends State<CSRDashboard> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  List<Widget> widgets=[];
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }

  var node;

  double cardWidth=0.0;

  Map dashBoardDetail={
    "TotalVolunteer": 0,
    "VolunteerPrimaryUnit": "",
    "VolunteerSecoundaryUnit": "Unit",
    "VolunteerPercentage": 0,
    "IsVolunteerIncrease": true,
    "TotalLandParcel": 0.00,
    "LandParcelPrimaryUnit": "",
    "LandParcelSecoundaryUnit": "Unit",
    "LandParcelPercentage": 0.00,
    "IsLandParcelIncrease": true,
    "TotalSeeding": 0,
    "SeedingPrimaryUnit": "",
    "SeedingSecoundaryUnit": "Unit",
    "SeedingPercentage": 0.00,
    "IsSeedingIncrease": true,
    "TotalNursery": 0,
    "NurseryPrimaryUnit": "",
    "NurcerySecoundaryUnit": "Unit",
    "NurseryPercentage": 0.00,
    "IsNurseryIncrease": true,
    "TotalPlanting": 0,
    "PlantingPrimaryUnit": "",
    "PlantingSecoundaryUnit": "Unit",
    "PlantingPercentage": 0.00,
    "IsPlantingIncrease": true,
    "TotalNurseryPlants": 0,
    "TotalPlantations": 0
  };

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: const Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: const Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leading: NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  actions: [
                    LanguageSwitch(onChange: () { setState(() {}); },),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('CSR Dashboard',style: TextStyle(color:ColorUtil.themeBlack,fontFamily:Language.boldFF,fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit:BoxFit.fill),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  padding: const EdgeInsets.only(left: 10,right: 10, top: 10),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.antiAlias,
                    shrinkWrap: true,
                    children: [
                      /*Container(
                    margin: EdgeInsets.only(left: 5, right: 5,bottom: 10),
                    child: Text('Eco Green Foundation Dashboard',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xff000000)),),
                  ),*/
                      const SizedBox(height: 5,),
                      Wrap(
                        spacing: 0,
                        runSpacing: 8,
                        alignment: WrapAlignment.spaceAround,
                        ///runAlignment: WrapAlignment.center,
                        //crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth!*0.45,
                            height: 190,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0, // soften the shadow
                                  spreadRadius: .0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/logo.png',fit: BoxFit.contain,)
                                // Row(
                                //   children: [
                                //     Container(
                                //       width:50,
                                //       height: 50,
                                //       alignment: Alignment.center,
                                //       decoration: BoxDecoration(
                                //           color: Color(0XFFf8cba2),
                                //           shape:BoxShape.circle
                                //       ),
                                //       child: Image.asset('assets/trees/Seeds.png',height: 30,),
                                //     ),
                                //     SizedBox(width:5 ,),
                                //     RichText(
                                //       text: TextSpan(
                                //         children: <TextSpan>[
                                //           TextSpan(text: 'Target ',  style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                //           TextSpan(text: '10 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                //         ],
                                //       ),
                                //       // textScaleFactor: 0.5,
                                //     )
                                //   ],
                                // ),
                                // SizedBox(height: 5,),
                                // Text('Zone',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                // SizedBox(height: 5,),
                                // Text.rich(
                                //   TextSpan(
                                //     text: '5', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                //     children: [
                                //       TextSpan(text: ' Zone ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          getCardPrimary(
                              img: "assets/Slice/DefaultVolunteer.png",
                              imgBg:  const Color(0XFFF2F2F2),
                              title: "No of Donation",
                              primaryTotal: '${dashBoardDetail["TotalVolunteer"]}',
                              primaryUnit: "",
                              secondaryUnit: 'Times ',
                              titleChart:'Donate Chart',
                              valClr: Color(0xff005659),
                            arrowIcon: Icon(Icons.arrow_drop_down,color:Color(0xff005659), )
                          ),
                          getCardPrimary(
                              img: "assets/trees/planting.png",
                              title: "Total Amount",
                              primaryTotal: '${dashBoardDetail["TotalLandParcel"]}',
                              primaryUnit: "",
                              secondaryUnit: 'Lakhs ',
                              titleChart:'Cash Chart',
                              valClr: Color(0xff3C4688),
                              arrowIcon: Icon(Icons.arrow_drop_down,color:Color(0xff3C4688),)
                          ),
                          getCardPrimary(
                              img: "assets/trees/Seeds.png",
                              title: "Consumption",
                              primaryTotal: '${dashBoardDetail["TotalSeeding"]}',
                              primaryUnit: "",
                              secondaryUnit: 'Precentage',
                              titleChart:'Consumption Chart',
                              valClr: Color(0xffAA662E),
                              arrowIcon: Icon(Icons.arrow_drop_up_outlined,color:Color(0xffAA662E),)
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5,),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth!*0.45,
                              height: 150,
                              clipBehavior: Clip.antiAlias,
                              //padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffF9CBA5),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width:50,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: Color(0XFFF2F2F2),
                                                  shape:BoxShape.circle
                                              ),
                                              child: Image.asset('assets/trees/Nursery.png',height: 30,),
                                            ),
                                            const SizedBox(width:5 ,),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '${Language.target} ',  style: TextStyle(fontFamily: Language.regularFF,fontSize: 14,color: Color(0xff000000)),),
                                                  const TextSpan(text: '300 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                                ],
                                              ),
                                              // textScaleFactor: 0.5,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(Language.nursery,style: TextStyle(fontFamily: Language.mediumFF,fontSize: 14,color: ColorUtil.themeBlack),),
                                        const SizedBox(height: 4,),
                                        Text.rich(
                                          TextSpan(
                                            text: '${dashBoardDetail["TotalNursery"]}', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                            children: [
                                              TextSpan(text: ' ${Language.nursery} ', style: ts14(ColorUtil.themeBlack),)
                                            ],
                                          ),
                                        ),
                                        FittedText(
                                          height: 22,
                                          text: '${dashBoardDetail["TotalNurseryPlants"]} ${Language.nursery} ${Language.plant} ',
                                          textStyle: ts18(ColorUtil.themeBlack,fontsize: 13),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        /*Text('${dashBoardDetail["TotalNurseryPlants"]} ${Language.nursery} ${Language.plant} ',
                                          style: ts18(ColorUtil.themeBlack,fontsize: 13),),*/
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Transform(
                                      transform: Matrix4.skewY(2.3),
                                      origin:const Offset(50 ,-50),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffCFEDD8),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth!*0.46,
                              height: 150,
                              //padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffCFEDD8),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width:50,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: Color(0XFFF2F2F2),
                                                  shape:BoxShape.circle
                                              ),
                                              child: Image.asset('assets/trees/plant.png',height: 30,),
                                            ),
                                            const SizedBox(width:5 ,),
                                            RichText(
                                              text:  TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '${Language.target} ',  style: ts14(ColorUtil.themeBlack,),),
                                                  TextSpan(text: '2 ${Language.crore} ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                                ],
                                              ),
                                              // textScaleFactor: 0.5,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(Language.plantation,style: TextStyle(fontFamily:Language.mediumFF,fontSize: 14,color: Color(0xff000000)),),
                                        const SizedBox(height: 5,),
                                        Text.rich(
                                          TextSpan(
                                            text: '${dashBoardDetail["TotalPlantations"]}', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                            children: [
                                              TextSpan(text: ' ${Language.plant} ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                            ],
                                          ),
                                        ),
                                        Text('${dashBoardDetail["TotalPlanting"]} ${Language.plantation} ',  style: const TextStyle(fontFamily: 'RR',fontSize: 13,color: Color(0xff000000)),),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Transform(
                                      transform: Matrix4.skewY(2.3),
                                      origin:const Offset(50 ,-50),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF3F3F3),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                    ],
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
  void assignWidgets() async{
   // await parseJson(widgets, General.NurseryGridIdentifier);
    try{

    }catch(e){}
  }


  Widget getCardPrimary({String img="",Color imgBg=const Color(0XFFf8cba2),String title="",String titleChart="",
  String primaryTotal="0",String primaryUnit="",String secondaryUnit="",Color valClr=const Color(0XFF000000),Widget? arrowIcon}){
    return Container(
      width: SizeConfig.screenWidth!*0.45,
      height: 190,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: .0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              0.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width:50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: imgBg,
                    shape:BoxShape.circle
                ),
                child: Image.asset(img,height: 30,),
              ),
              const SizedBox(width: 5,),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: ts14(const Color(0xff000000),),),
              arrowIcon??Container()
            ],
          ),
          const SizedBox(height: 5,),
          Text.rich(
            TextSpan(
              text: primaryTotal, style: TextStyle(color: valClr, fontSize: 20,fontFamily: 'RB'),
              children: [
                TextSpan(text: ' / $secondaryUnit ', style: ts14(const Color(0xff767676),fontfamily: 'Med'),)
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Text(titleChart,style: TextStyle(color: ColorUtil.themeBlack, fontSize: 12,fontFamily: 'RB'),),
          const SizedBox(height: 5,),
          Image.asset("assets/csrdonate.PNG")
        ],
      ),
    );
  }

}
