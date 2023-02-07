import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/apiUtils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/navigationBarIcon.dart';
import 'editProfile.dart';

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


  var profileImgPath="".obs;

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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NavBarIcon(
                              onTap:  (){
                                widget.voidCallback();
                              },
                            ),
                            SizedBox(height: 10,),
                          Container(
                            width: 150,
                              height: 150,
                              child: Stack(
                                children: [
                                  Image.asset("assets/trees/Profile-bg.png",width: 150,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 90,
                                      clipBehavior: Clip.antiAlias,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Obx(() => Image.network(GetImageBaseUrl()+'${profileImgPath.value}',width: 90,fit: BoxFit.cover,
                                          errorBuilder: (a,b,c){
                                            return Image.asset('assets/trees/plant.png',width: 90,fit: BoxFit.cover,);
                                          },
                                      )),
                                    ),
                                  )
                                ],
                              ),
                          ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child: widgets[0],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child:widgets[1],
                            ),
                            const SizedBox(height: 5,),
                            FittedBox(
                              child: Row(
                                children: [
                                  Image.asset("assets/Slice/At.png",width: 50,),
                                  widgets[2],
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset("assets/Slice/ph.png",width: 50,),
                                widgets[3],
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset("assets/trees/user-icon.png",width: 35,),
                                ),
                                SizedBox(width: 5,),
                                widgets[4],
                              ],
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset("assets/trees/password.png",width: 35,),
                                  ),
                                  SizedBox(width: 5,),
                                  widgets[5],
                                ],
                              ),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  GestureDetector(
                      onTap: (){
                        fadeRoute(EditProfile(closeCb: (e){
                          assignWidgets();
                        },));
                      },
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.all(15.0),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: ColorUtil.primary,
                        ),
                        child:Center(child: Text('Edit Profile',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                      ),
                    ),
                  ),
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   padding: EdgeInsets.all(20),
                  //   margin: EdgeInsets.only(left:15,right: 15),
                  //   decoration: BoxDecoration(
                  //       color: ColorUtil.primary.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(5.0)
                  //   ),
                  //   alignment: Alignment.center,
                  //   child: Text('14 NP Developed Plots,100 Feet Rd, Thiru Vi Ka Industrial Estate, Chennai, TamilNadu 600032',style: TextStyle(fontFamily: 'RM',color: ColorUtil.primary,fontSize: 16),),
                  // ),
                  // SizedBox(height: 10,),
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   height: SizeConfig.screenHeight!*0.38,
                  //   margin: EdgeInsets.only(left: 15.0 ,right: 15.0),
                  //   child: CarouselSlider(
                  //     options: CarouselOptions(
                  //       viewportFraction: 1.0,
                  //       enlargeCenterPage: false,
                  //       scrollDirection: Axis.horizontal,
                  //       autoPlay: true,
                  //         onPageChanged: (index, reason) {
                  //           setState(() {
                  //             _current = index;
                  //           });
                  //         }
                  //     ),
                  //     carouselController: _controller,
                  //     items: imgList
                  //         .map((item) => Container(
                  //       child: Row(
                  //         children: [
                  //           Container(
                  //             width: SizeConfig.screenWidth!-160,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text('12-Dec-2022',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RM',fontSize: 16),),
                  //                 Text('Kanchipuram (10,000)',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 12),),
                  //                 Row(
                  //                   children: [
                  //                     Image.asset("assets/Slice/badgeLeaf.PNG",width: 50,),
                  //                     Container(
                  //                         width: SizeConfig.screenWidth!-210,
                  //                         child: Text('Groeth 95%',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Image.asset("assets/Slice/heartrate.png",width: 50,),
                  //                     Container(
                  //                         width: SizeConfig.screenWidth!-210,
                  //                         child: Text('Health 100%',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Image.asset("assets/Slice/apple.png",width: 50,),
                  //                     Container(
                  //                         width: SizeConfig.screenWidth!-210,
                  //                         child: Text('This Sapling has grown hjgjhgjhgjh',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),)),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //
                  //           Container(
                  //             width: 130,
                  //             child: Image.asset(item,fit: BoxFit.cover,),
                  //           ),
                  //         ],
                  //       ),
                  //     ))
                  //         .toList(),
                  //   )
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: imgList.asMap().entries.map((entry) {
                  //     return GestureDetector(
                  //       onTap: () => _controller.animateToPage(entry.key),
                  //       child: Container(
                  //         width: 12.0,
                  //         height: 12.0,
                  //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: (Theme.of(context).brightness == Brightness.dark
                  //                 ? Colors.white
                  //                 : ColorUtil.primary)
                  //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
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
    widgets.add(HE_Text(dataname: "UserName", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Designation", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 15),));
    widgets.add(HE_Text(dataname: "Email", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "PhoneNumber", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));

    setState(() {});
    await parseJson(widgets, General.ProfileViewIdentifier);

    try{
      profileImgPath.value=valueArray.where((element) => element['key']=="UserImage").toList()[0]['value'];
    }catch(e){}
  }
}
