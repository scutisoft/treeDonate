import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/ApiManager.dart';
import 'package:treedonate/notifier/configuration.dart';
import 'package:treedonate/pages/Seeding/seedingGrid.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/accessWidget.dart';
import 'package:treedonate/widgets/loader.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import '../widgets/zoomDrawer/config.dart';
import '../widgets/zoomDrawer/flutter_zoom_drawer.dart';
import 'Nursery/nurseryGrid.dart';
import 'dashboard/dashboard.dart';
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
  MenuScreen({Key? key}) : super(key: key);

  List<dynamic> menuList=[
    {"Title":"DashBoard","PageNumber":14,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Home Page","PageNumber":13,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My Profile","PageNumber":1,"iconNav":Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Donate","PageNumber":2,"iconNav":Icon(Icons.hive_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My History","PageNumber":3,"iconNav":Icon(Icons.history,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":"My Certificate","PageNumber":4,"iconNav":Icon(Icons.file_copy_outlined,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":"Our Events","PageNumber":5,"iconNav":Icon(Icons.event,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":"My trees","PageNumber":6,"iconNav":Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":"+ Volunteer ","PageNumber":7,"iconNav":Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,),"accessId":accessId["VolunteerView"]},
    {"Title":"Notification","PageNumber":8,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":"Land Parcel","PageNumber":9,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":accessId["LandParcelView"]},
    {"Title":"Planting","PageNumber":10,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":accessId["PlantationView"]},
    {"Title":"Seeding","PageNumber":11,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":accessId["SeedCollectionView"]},
    {"Title":"Nursery","PageNumber":12,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":accessId["NurseryView"]},
  ];


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
                const SizedBox(height: 80,),
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
                const SizedBox(height: 20,),
                for(int i=0;i<menuList.length;i++)
                  AccessWidget(
                    hasAccess:menuList[i]['accessId']==null?true: isHasAccess(menuList[i]['accessId']),
                    needToHide: true,
                    widget: DrawerContent(
                        title: menuList[i]['Title'],
                        iconNav: menuList[i]['iconNav']
                    ),
                    onTap: (){
                      setPageNumber(menuList[i]['PageNumber']);
                      controller.toggleDrawer();
                    },
                  ),

                DrawerContent(
                    title: 'LogOut',
                    ontap: (){
                      clearUserSessionDetail();
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

RxInt menuSel=RxInt(14);
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
      child: Stack(
        children: [
          Obx(() => Scaffold(
            key: scaffoldkey,
            body:menuSel.value==14?Dashboard(
                voidCallback:() {
                  controller.toggleDrawer();
                  //scaffoldkey.currentState!.openDrawer();
                }
            ) :menuSel.value==1?MyProfile(
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
          Obx(() => Loader(value: showLoader.value,))
        ],
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  String title;
  Widget iconNav;
  VoidCallback? ontap;
  DrawerContent({required this.title,required this.iconNav, this.ontap});
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

