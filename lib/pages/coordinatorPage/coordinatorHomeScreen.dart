import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/zoomDrawer/config.dart';
import '../../widgets/zoomDrawer/flutter_zoom_drawer.dart';
import '../loginpage/login.dart';
import 'landParcel/LandParcelPage.dart';


class MyCoOrdinatorDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}

class CooardinatorHomePage extends GetView<MyCoOrdinatorDrawerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCoOrdinatorDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        style: DrawerStyle.defaultStyle,
        menuScreen: CoOrdinatoMenuScreen(),
        mainScreen: CoOrdinatoMasterpage(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        menuBackgroundColor: Colors.white,
      ),
    );
  }
}

class CoOrdinatoMenuScreen extends GetView<MyCoOrdinatorDrawerController> {
  const CoOrdinatoMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

         /* Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/Slice/tree-sidenav-bg.jpg',fit:BoxFit.cover,))
              ),

          ),*/
         /* Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: ColorUtil.primary.withOpacity(0.5),
          ),*/
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     IconButton(onPressed: (){
              //       controller.toggleDrawer();
              //     }, icon: Icon(Icons.clear,color: Colors.white,size: 28,),),
              //     SizedBox(width: 10,),
              //     Container(
              //         padding: EdgeInsets.only(right: 15.0),
              //         child:   Image.asset('assets/logo.png',width:SizeConfig.screenWidth!-100,)
              //     ),
              //   ],
              // ),
              SizedBox(height: 20,),
              DrawerContent(
                title: 'My Profile',
                ontap: (){

                    menuSel=1;
                    controller.toggleDrawer();
                },
                iconNav: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,)
                ,
              ),
              DrawerContent(
                  title: 'Land Parcel',
                  ontap: (){
                      menuSel=2;
                      controller.toggleDrawer();
                  },
                  iconNav: Icon(Icons.hive_outlined,color: ColorUtil.themeWhite,)
              ),
              // DrawerContent(
              //     title: 'My History',
              //     ontap: (){
              //       menuSel=3;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.history,color: ColorUtil.themeWhite,)
              // ),
              // DrawerContent(
              //     title: 'My Certificate',
              //     ontap: (){
              //       menuSel=4;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.file_copy_outlined,color: ColorUtil.themeWhite,)
              // ),
              // DrawerContent(
              //     title: 'Our Events',
              //     ontap: (){
              //       menuSel=5;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.event,color: ColorUtil.themeWhite,)
              // ),
              // DrawerContent(
              //     title: 'My trees',
              //     ontap: (){
              //       menuSel=6;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,)
              // ),
              // DrawerContent(
              //     title: '+ Volunteer ',
              //     ontap: (){
              //       menuSel=7;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,)
              // ),
              // DrawerContent(
              //     title: 'Notification',
              //     ontap: (){
              //       menuSel=8;
              //       controller.toggleDrawer();
              //     },
              //     iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
              // ),
              DrawerContent(
                  title: 'LogOut',
                  ontap: (){
                    Get.to(loginPage());
                  },
                  iconNav: Icon(Icons.lock,color: ColorUtil.themeWhite,)
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('(c) 2021. All Rights Reserved. Design By Scutisoft   ',
                      style: TextStyle(fontSize: 12,color:Color(0xffffffff), fontFamily:'RR'),textAlign: TextAlign.center, )
                ),
              ),
              // Divider(color: Color(0xff099FAF),thickness: 0.1,),
            ],
          ),
        ],
      ),
    );
  }
}

int menuSel=2;
class CoOrdinatoMasterpage extends StatefulWidget {
  const CoOrdinatoMasterpage({Key? key}) : super(key: key);

  @override
  _CoOrdinatoMasterpageState createState() => _CoOrdinatoMasterpageState();
}

class _CoOrdinatoMasterpageState extends State<CoOrdinatoMasterpage>{

  GlobalKey <ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  late  double width,height,width2;

  var controller=Get.put(MyCoOrdinatorDrawerController());

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        body:menuSel==2?LandParcel(
            voidCallback:() {
              controller.toggleDrawer();
              //scaffoldkey.currentState!.openDrawer();
            }
        )  :Container(),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  String title;
  Widget iconNav;
  VoidCallback ontap;
  DrawerContent({required this.title,required this.iconNav,required this.ontap});
  late double width;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: width,
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 5,bottom: 5),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Container(
              height: 40,
              width: 40,
              child: iconNav,
            ),
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$title",
                  style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.white,letterSpacing: 0.1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

