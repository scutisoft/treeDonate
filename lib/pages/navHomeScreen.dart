import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/Seeding/seedingGrid.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import '../widgets/zoomDrawer/config.dart';
import '../widgets/zoomDrawer/flutter_zoom_drawer.dart';
import 'Nursery/nurseryGrid.dart';
import 'donateTree/donate.dart';
import 'donateTree/donateTree.dart';
import 'history/historyPage.dart';
import 'history/historyView.dart';
import 'landParcel/LandParcelGrid.dart';
import 'landParcel/landingPage.dart';
import 'loginpage/login.dart';
import 'myCertificate/certificatePage.dart';
import 'myTrees/trees.dart';
import 'notification/notification.dart';
import 'ourEvents/events.dart';
import 'planting/plantingGrid.dart';
import 'profile/myprofile.dart';
import 'volunteer/volunteerPage.dart';

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}

class MyHomePage extends GetView<MyDrawerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        style: DrawerStyle.defaultStyle,
        menuScreen: MenuScreen(),
        mainScreen: Masterpage(),
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

class MenuScreen extends GetView<MyDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
          Container(
            height: SizeConfig.screenHeight!-44,
            child: ListView(
              shrinkWrap: true  ,
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
                    title: 'Home Page',
                    ontap: (){
                      setPageNumber(13);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                  title: 'My Profile',
                  ontap: (){
                    setPageNumber(1);
                      controller.toggleDrawer();
                  },
                  iconNav: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,)
                  ,
                ),
                DrawerContent(
                    title: 'Donate',
                    ontap: (){
                      setPageNumber(2);
                        controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.hive_outlined,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'My History',
                    ontap: (){
                      setPageNumber(3);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.history,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'My Certificate',
                    ontap: (){
                      setPageNumber(4);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.file_copy_outlined,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Our Events',
                    ontap: (){
                      setPageNumber(5);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.event,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'My trees',
                    ontap: (){
                      setPageNumber(6);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: '+ Volunteer ',
                    ontap: (){
                      setPageNumber(7);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Notification',
                    ontap: (){
                      setPageNumber(8);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Land Parcel',
                    ontap: (){
                      setPageNumber(9);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Planting',
                    ontap: (){
                      setPageNumber(10);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Seeding',
                    ontap: (){
                      setPageNumber(11);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'Nursery',
                    ontap: (){
                      setPageNumber(12);
                      controller.toggleDrawer();
                    },
                    iconNav: Icon(Icons.notifications_none,color: ColorUtil.themeWhite,)
                ),
                DrawerContent(
                    title: 'LogOut',
                    ontap: (){
                      Get.to(loginPage());
                    },
                    iconNav: Icon(Icons.lock,color: ColorUtil.themeWhite,)
                ), // Divider(color: Color(0xff099FAF),thickness: 0.1,),
              ],
            ),
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
        ],
      ),
    );
  }
}

RxInt menuSel=RxInt(13);
void setPageNumber(int page){
  menuSel.value=page;
}

class Masterpage extends StatefulWidget {
  const Masterpage({Key? key}) : super(key: key);

  @override
  _MasterpageState createState() => _MasterpageState();
}

class _MasterpageState extends State<Masterpage>{

  GlobalKey <ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  late  double width,height,width2;

  var controller=Get.put(MyDrawerController());


  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    SizeConfig().init(context);
    return SafeArea(
      child: Obx(() => Scaffold(
        key: scaffoldkey,
        body:menuSel.value==1?MyProfile(
            voidCallback:() {
              controller.toggleDrawer();
              //scaffoldkey.currentState!.openDrawer();
            }
        ) :menuSel.value==2?DonateTreePage(
            voidCallback:() {
              controller.toggleDrawer();
              //scaffoldkey.currentState!.openDrawer();
            }
        ) :menuSel.value==3?HistoryTreeView (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==4?CertificatePage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==5?OurEventsPage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==6?MyTreesPage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==7?VolunteerPage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==8?NotificationPage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==9?LandParcelGrid (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==10?PlantingGrid (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==11?SeedingGrid (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :menuSel.value==12?NurseryGrid (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ):menuSel.value==13?LandingPage (
          voidCallback:(){
            controller.toggleDrawer();
          },
        ) :Container(),
      )),
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

