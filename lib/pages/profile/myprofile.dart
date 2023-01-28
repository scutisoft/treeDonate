import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/owl-carosaul.dart';

class MyProfile extends StatefulWidget {
  VoidCallback voidCallback;
  MyProfile({required this.voidCallback});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  final List<String> imgList = [
    'assets/trees/tree-1.png',
    'assets/trees/tree-10.png',
    'assets/trees/tree-100.png',
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
          backgroundColor: Color(0xffFAFAF8),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth!-130,
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              widget.voidCallback();

                            },
                              child: Image.asset("assets/trees/profile.png",width: 150,)),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child: Text('Mr K Raja',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 24),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child: Text('EGF Pvt, Ltd.',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 15),),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Image.asset("assets/Slice/At.png",width: 50,),
                                Text('contact@EGF.com',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset("assets/Slice/ph.png",width: 50,),
                                Text('+91-86104-86104',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 130,
                          child: Image.asset("assets/trees/leaf-bg.png",fit: BoxFit.cover,)
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left:15,right: 15),
                    decoration: BoxDecoration(
                        color: ColorUtil.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    alignment: Alignment.center,
                    child: Text('14 NP Developed Plots,100 Feet Rd, Thiru Vi Ka Industrial Estate, Chennai, TamilNadu 600032',style: TextStyle(fontFamily: 'RM',color: ColorUtil.primary,fontSize: 16),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight!*0.38,
                    margin: EdgeInsets.only(left: 15.0 ,right: 15.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
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
                          .map((item) => Container(
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth!-160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('12-Dec-2022',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RM',fontSize: 16),),
                                  Text('Kanchipuram (10,000)',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 12),),
                                  Row(
                                    children: [
                                      Image.asset("assets/Slice/badgeLeaf.PNG",width: 50,),
                                      Container(
                                          width: SizeConfig.screenWidth!-210,
                                          child: Text('Groeth 95%',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("assets/Slice/heartrate.png",width: 50,),
                                      Container(
                                          width: SizeConfig.screenWidth!-210,
                                          child: Text('Health 100%',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("assets/Slice/apple.png",width: 50,),
                                      Container(
                                          width: SizeConfig.screenWidth!-210,
                                          child: Text('This Sapling has grown hjgjhgjhgjh',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: 130,
                              child: Image.asset(item,fit: BoxFit.cover,),
                            ),
                          ],
                        ),
                      ))
                          .toList(),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : ColorUtil.primary)
                                  .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    widgets.add(HE_Text(dataname: "PageTitle", contentTextStyle: ts18(ColorUtil.primary,fontfamily: 'RB',fontsize: 18),content: "Hello",));
    widgets.add(HE_Text(dataname: "PageSubTitle", contentTextStyle: ts14(ColorUtil.text4)));
    widgets.add(SearchDrp2(map: const {"dataName":"Occasion","hintText":"Select Occasion"},));
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "Name",
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: "Mobile Number",
      textInputType: TextInputType.number,
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Email',
      hasInput: true,
      required: true,
      labelText: "Email",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
