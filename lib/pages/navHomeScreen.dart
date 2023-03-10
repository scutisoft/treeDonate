import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treedonate/api/ApiManager.dart';
import 'package:treedonate/notifier/configuration.dart';
import 'package:treedonate/pages/CSR/csrGrid.dart';
import 'package:treedonate/pages/Seeding/seedingGrid.dart';
import 'package:treedonate/pages/newsFeedsView/newsFeedGrid.dart';
import 'package:treedonate/utils/constants.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/accessWidget.dart';
import 'package:treedonate/widgets/loader.dart';
import '../helper/appVersionController.dart';
import '../helper/language.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import '../widgets/fittedText.dart';
import '../widgets/zoomDrawer/config.dart';
import '../widgets/zoomDrawer/flutter_zoom_drawer.dart';
import 'Nursery/nurseryGrid.dart';
import 'dashboard/csrDashboard.dart';
import 'dashboard/dashboard.dart';
import 'donateTree/donate.dart';
import 'donateTree/donateTree.dart';
import 'donorsDetails/donorsGrid.dart';
import 'history/historyPage.dart';
import 'history/historyView.dart';
import 'landParcel/LandParcelGrid.dart';
import 'landParcel/landingPage.dart';
import 'landParcel/polymaker.dart';
import 'loginpage/login.dart';
import 'myCertificate/certificatePage.dart';
import 'myTrees/trees.dart';
import 'newsFeedsView/newsFeedsViewPage.dart';
import 'notification/notification.dart';
import 'ourEvents/events.dart';
import 'ourEvents/eventsGrid.dart';
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
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
      child: GetBuilder<MyDrawerController>(
        builder: (_) => ZoomDrawer(
          controller: _.zoomDrawerController,
          style: DrawerStyle.defaultStyle,
          menuScreen: MenuScreen(),
          mainScreen: const Masterpage(),
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          drawerShadowsBackgroundColor: Colors.grey,
          slideWidth: MediaQuery.of(context).size.width * 0.8,
          menuBackgroundColor: const Color(0xff1e3200),
          mainScreenTapClose: true,
        ),
      ),
    );
  }
}

class MenuScreen extends GetView<MyDrawerController> {
  MenuScreen({Key? key}) : super(key: key);

  List<dynamic> menuList=[
    {"Title":Language.dashboard,"PageNumber":14,"iconNav":SvgPicture.asset("assets/Slice/dashboard.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["DashBoardView"]},
    {"Title":'CSR Dashboard',"PageNumber":17,"iconNav":SvgPicture.asset("assets/Slice/dashboard.svg",height: 25,color: ColorUtil.themeWhite,),"accessId": 100},
    {"Title":'CSR',"PageNumber":18,"iconNav":SvgPicture.asset("assets/Slice/dashboard.svg",height: 25,color: ColorUtil.themeWhite,),"accessId": 100},
    {"Title":'Donor Details',"PageNumber":19,"iconNav":SvgPicture.asset("assets/Slice/dashboard.svg",height: 25,color: ColorUtil.themeWhite,),"accessId": null},
    {"Title":Language.homePage,"PageNumber":13,"iconNav":SvgPicture.asset("assets/Slice/home-outline.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["HomeView"]},
    {"Title":Language.myProfile,"PageNumber":1,"iconNav":Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":Language.donate,"PageNumber":2,"iconNav":Icon(Icons.hive_outlined,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":Language.myHistory,"PageNumber":3,"iconNav":Icon(Icons.history,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":Language.myCertificate,"PageNumber":4,"iconNav":Icon(Icons.file_copy_outlined,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":Language.ourEvents,"PageNumber":5,"iconNav":SvgPicture.asset("assets/Slice/calendar-check.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId['EventsView']},
    {"Title":Language.newsFeedTitle,"PageNumber":16,"iconNav":SvgPicture.asset("assets/Slice/newspaper.svg",height: 22,color: ColorUtil.themeWhite,),"accessId":accessId['NewsFeedView']},
    {"Title":Language.myTrees,"PageNumber":6,"iconNav":SvgPicture.asset("assets/Slice/palm-tree.svg",height: 26,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"+ ${Language.volunteer['Value']}","PageNumber":7,"iconNav":Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,),"accessId":accessId["VolunteerView"]},
    {"Title":Language.notification,"PageNumber":8,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":100},
    {"Title":Language.landParcel,"PageNumber":9,"iconNav":SvgPicture.asset("assets/Slice/land-parcel.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["LandParcelView"]},
    {"Title":Language.seeding,"PageNumber":11,"iconNav":SvgPicture.asset("assets/Slice/seed-outline.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["SeedCollectionView"]},
    {"Title":Language.nursery,"PageNumber":12,"iconNav":SvgPicture.asset("assets/Slice/nursery.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["NurseryView"]},
    {"Title":Language.plantation,"PageNumber":10,"iconNav":SvgPicture.asset("assets/Slice/leaf.svg",height: 25,color: ColorUtil.themeWhite,),"accessId":accessId["PlantationView"]},
    {"Title":"PolyMaker","PageNumber":15,"iconNav":const Icon(Icons.map_outlined,color: Colors.white,),"accessId":100},
  ];

/*  List<dynamic> menuList=[
    {"Title":"DashBoard","PageNumber":14,"iconNav":Icon(Icons.dashboard,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Home Page","PageNumber":13,"iconNav":Icon(Icons.home_work_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My Profile","PageNumber":1,"iconNav":Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Donate","PageNumber":2,"iconNav":Icon(Icons.hive_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My History","PageNumber":3,"iconNav":Icon(Icons.history,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My Certificate","PageNumber":4,"iconNav":Icon(Icons.file_copy_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Our Events","PageNumber":5,"iconNav":Icon(Icons.event,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"My trees","PageNumber":6,"iconNav":Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"+ Volunteer ","PageNumber":7,"iconNav":Icon(Icons.energy_savings_leaf_outlined,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Notification","PageNumber":8,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Land Parcel","PageNumber":9,"iconNav":Icon(Icons.landscape_outlined,color: ColorUtil.themeWhite,),"accessId":accessId["LandParcelView"]},
    {"Title":"Planting","PageNumber":10,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Seeding","PageNumber":11,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
    {"Title":"Nursery","PageNumber":12,"iconNav":Icon(Icons.notifications_none,color: ColorUtil.themeWhite,),"accessId":null},
  ];*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
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
            height: SizeConfig.screenHeight!-(82+135+26),
            margin: const EdgeInsets.only(top: 135),
            child: ListView(
              shrinkWrap: true,
              children: [
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
                // Divider(color: Color(0xff099FAF),thickness: 0.1,),
              ],
            ),
          ),
          DrawerContent(
              title: Language.logOut,
              ontap: (){
                clearUserSessionDetail();
              },
              iconNav: Icon(Icons.lock,color: ColorUtil.themeWhite,)
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('(c) ${DateFormat("yyyy").format(DateTime.now())}. ${Language.rights}',
                  style: TextStyle(fontSize: 12,color:const Color(0xffffffff), fontFamily:Language.regularFF),textAlign: TextAlign.center, )
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
/*  if(page==13){
    landingPage.assignWidgets();
  }*/
}
/*LandingPage landingPage=LandingPage (
  voidCallback:(){
    // controller.toggleDrawer();
  },
);*/
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
  void initState(){
    // AppVersionController().getAppVersionDetail();
    AppVersionController().checkVersion();
/*    landingPage.voidCallback=(){
       controller.toggleDrawer();
    };*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
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
            ) :menuSel.value==5?EventsGrid (
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
            ):menuSel.value==15?PolyMakerHomeScreen (
              voidCallback:(){
                controller.toggleDrawer();
              },
            ):menuSel.value==16?NewsFeedGrid (
              voidCallback:(){
                controller.toggleDrawer();
              },
            ) :menuSel.value==17?CSRDashboard (
              voidCallback:(){
                controller.toggleDrawer();
              },
            ) :menuSel.value==18?CSRGrid (
              voidCallback:(){
                controller.toggleDrawer();
              },
            ) :menuSel.value==19?DonorsGrid (
              voidCallback:(){
                controller.toggleDrawer();
              },
            ) :Container(),
          )),
          /*Obx(() => Loader(value: showLoader.value,))*/
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
            const SizedBox(width: 20,),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: iconNav,
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedText(
                  width: width*0.45,
                  text: title,
                  textStyle: TextStyle(fontFamily: Language.regularFF,fontSize: 16,color: Colors.white,letterSpacing: 0.1),
                  alignment: Alignment.centerLeft,
                  height: 28,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

