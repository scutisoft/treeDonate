import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/apiUtils.dart';
import '../../helper/language.dart';
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
                                      child: Obx(() => Image.network('${GetImageBaseUrl()}${profileImgPath.value}',width: 90,fit: BoxFit.cover,
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
                        child:Center(child: Text(Language.editProfile,style: TextStyle(fontSize: 16,color: ColorUtil.themeWhite,fontFamily:Language.regularFF), )) ,
                      ),
                    ),
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
    widgets.add(HE_Text(dataname: "UserName", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Designation", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 15),));
    widgets.add(HE_Text(dataname: "Email", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "PhoneNumber", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));
    widgets.add(HE_Text(dataname: "Password", contentTextStyle: TextStyle(color:ColorUtil.primary,fontFamily: 'RR',fontSize: 16),));

    setState(() {});
    await parseJson(widgets, General.ProfileViewIdentifier);

    try{
      profileImgPath.value="Image/"+valueArray.where((element) => element['key']=="UserImage").toList()[0]['value'];
    }catch(e){}
  }
}
