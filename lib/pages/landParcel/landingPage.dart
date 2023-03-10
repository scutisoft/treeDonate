import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../helper/language.dart';
import '../../pages/navHomeScreen.dart';
import '../../widgets/loader.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../helper/appVersionController.dart';
import '../../model/parameterMode.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../widgets/popupBanner/popup.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid_tile.dart';

class LandingPage extends StatefulWidget {
  VoidCallback voidCallback;
  LandingPage({required this.voidCallback});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  final List<String> imgList = [
    'assets/Slice/Landing-slider-sm.jpg',
    'assets/Slice/Landing-slider-sm-1.jpg',
    'assets/Slice/Landing-slider-sm-2.jpg',
  ];

  List<Widget> widgets=[];
  var _current = 0.obs;
  final CarouselController _controller = CarouselController();

  List<dynamic> filterNewsFeed=[];
  List<dynamic> newsFeed=[];

  static const platform = MethodChannel('flutter.native/helper');

  late Widget a;

  @override
  void initState(){
    a=   ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterNewsFeed.length,
      itemBuilder: (ctx,i){
        return getNewsFeed(
            i,
            name: filterNewsFeed[i]['NFNAME']??"",
            nfDescription: filterNewsFeed[i]['NFDescription']??"",
            nfLoc: filterNewsFeed[i]['NFLocation']??"",
            nfType: filterNewsFeed[i]['NFType']??"",
            profileImg: filterNewsFeed[i]['NFProfileImage']??"",
            date: filterNewsFeed[i]['NFDATE']??"",
            time: filterNewsFeed[i]['NFTime']??"",
            img:  filterNewsFeed[i]['NFImageFile']??"",
            isInterested: filterNewsFeed[i]['IsInterested'].toString()
        );
      },
    );
    assignWidgets();
  /*  platform.invokeMethod("helloFromNativeCode").then((value){
      console("platform $value");
    });*/
    super.initState();
  }

  ScrollController? silverController;
  TextEditingController textController = TextEditingController();
  var node;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
      child: Scaffold(
        backgroundColor: const Color(0xFFe8e8e8),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            NestedScrollView(
              controller: silverController,
              // floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    toolbarHeight: 60,
                    backgroundColor: ColorUtil.theme,
                    leading: Container(),
                    actions: [
                      Container(
                        width: SizeConfig.screenWidth,
                        height: 80,
                        child: Container(
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NavBarIcon(
                                onTap:  (){
                                   widget.voidCallback();

                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                 /* LanguageSwitch(onChange: (){
                                    setState(() {});
                                  },),*/
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      widgets[0],
                                      widgets[1],
                                    ],
                                  ),
                                  const SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      setPageNumber(1);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorUtil.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    floating: true,
                    snap: true,
                    pinned: true,
                  ),
                ];
              },
              body: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10,),
                  Container(
                    height: 190,
                    width: SizeConfig.screenWidth!,
                    margin: const EdgeInsets.only(left: 15,right: 15),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          clipBehavior: Clip.antiAlias,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height: 160,
                                enlargeCenterPage: false,
                                viewportFraction: 1,
                                scrollDirection: Axis.horizontal,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  _current.value = index;
                                }
                            ),
                            carouselController: _controller,
                            items: imgList
                                .map((item) => Image.asset(
                              item, fit: BoxFit.cover,
                              width: SizeConfig.screenWidth,height: 160,))
                                .toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  _controller.animateToPage(entry.key),
                              child: Obx(() => Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme
                                        .of(context)
                                        .brightness == Brightness.dark
                                        ? Colors.white
                                        : ColorUtil.primary)
                                        .withOpacity(
                                        _current.value == entry.key ? 0.9 : 0.4)),
                              )),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: buildGrid(),
                  ),
                  const SizedBox(height: 10,),

                  // News&Feeds
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(Language.newsFeedTitle,style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:Language.mediumFF), )

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimSearchBar(
                            width: SizeConfig.screenWidth!-182,
                            color: ColorUtil.asbColor,
                            boxShadow: ColorUtil.asbBoxShadow,
                            textController: textController,
                            closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                            searchIconColor: ColorUtil.asbSearchIconColor,
                            suffixIcon: ColorUtil.getASBSuffix(),
                            onSubmitted: (a){},
                            onChange: (a){
                              filterNewsFeed=searchGrid(a,newsFeed,filterNewsFeed);
                              setState(() {});
                            },

                            onSuffixTap: (clear) {
                              filterNewsFeed=searchGrid("",newsFeed,filterNewsFeed);
                              setState(() {});
                            },
                          ),
                          /*const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            fadeRoute(FilterItems());
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.primary,
                            ),
                            child: Icon(Icons.filter_alt_outlined,color:ColorUtil.themeBlack,),
                          ),
                        ),*/
                          const SizedBox(width: 15,),
                        ],
                      ),
                    ],
                  ),
                  a,
               /*   ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filterNewsFeed.length,
                    itemBuilder: (ctx,i){
                      return getNewsFeed(
                          i,
                          name: filterNewsFeed[i]['NFNAME']??"",
                          nfDescription: filterNewsFeed[i]['NFDescription']??"",
                          nfLoc: filterNewsFeed[i]['NFLocation']??"",
                          nfType: filterNewsFeed[i]['NFType']??"",
                          profileImg: filterNewsFeed[i]['NFProfileImage']??"",
                          date: filterNewsFeed[i]['NFDATE']??"",
                          time: filterNewsFeed[i]['NFTime']??"",
                          img:  filterNewsFeed[i]['NFImageFile']??"",
                          isInterested: filterNewsFeed[i]['IsInterested'].toString()
                      );
                    },
                  ),*/
                  ShimmerLoader(),
                  NoData(show: filterNewsFeed.isEmpty),
                  //Obx(() => NoData(show: filterNewsFeed.isEmpty && !showLoader.value,)),
                  const SizedBox(height: 15,),

                ],
              ),
            ),
            Obx(() => Loader(value: showLoader.value,))
          ],
        ),
      ),
    );
  }


  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children:  [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: GestureDetector(
            onTap: (){
              if(isHasAccess(accessId["LandParcelView"])){
                setPageNumber(9);
              }

            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/Land-parcel.png',fit: BoxFit.cover,height: SizeConfig.screenHeight,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Language.landParcel,style:TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.mediumFF,fontSize: 14,letterSpacing: 1.0),),
                            // Text("500 Hectare",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
              if(isHasAccess(accessId["SeedCollectionView"])){
                setPageNumber(11);
              }
            },
            child: Container(
              // width: SizeConfig.screenWidth!*0.4,
              // height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/seeds.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Language.seeding,style:TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.mediumFF,fontSize: 14,letterSpacing: 1.0),),
                            //  Text("500 Kg",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
              if(isHasAccess(accessId["NurseryView"])){
                setPageNumber(12);
              }
              // setPageNumber(12);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/nursery.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Language.nursery,style:TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.mediumFF,fontSize: 14,letterSpacing: 1.0),),
                            // Text("250 Numbers",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child:GestureDetector(
            onTap: (){
              if(isHasAccess(accessId["PlantationView"])){
                setPageNumber(10);
              }
              // setPageNumber(10);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/planting.png',height: SizeConfig.screenHeight,fit: BoxFit.fill,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Language.plantation,style:TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.mediumFF,fontSize: 14,letterSpacing: 1.0),),
                            // Text("50,00,000",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Directory? imgPath;

  @override
  void assignWidgets() async{
    widgets.clear();
    newsFeed.clear();
    filterNewsFeed.clear();
    widgets.add(HE_Text(dataname: "UserName", contentTextStyle: TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),));
    widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),));

    imgPath=await getApplicationPath();

    await parseJson(widgets, General.HomePageViewIdentifier);


    try{
      newsFeed=valueArray.where((element) => element['key']=="NewsFeedList").toList()[0]['value'];
      showLoader.value=true;
      await downloadNewsFeedImages(newsFeed);
      showLoader.value=false;
      filterNewsFeed= newsFeed;
      assignListView();
    }
    catch(e){}


  }

  void assignListView(){
    a =   ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterNewsFeed.length,
      itemBuilder: (ctx,i){
        return getNewsFeed(
            i,
            name: filterNewsFeed[i]['NFNAME']??"",
            nfDescription: filterNewsFeed[i]['NFDescription']??"",
            nfLoc: filterNewsFeed[i]['NFLocation']??"",
            nfType: filterNewsFeed[i]['NFType']??"",
            profileImg: filterNewsFeed[i]['NFProfileImage']??"",
            date: filterNewsFeed[i]['NFDATE']??"",
            time: filterNewsFeed[i]['NFTime']??"",
            img:  filterNewsFeed[i]['NFImageFile']??"",
            isInterested: filterNewsFeed[i]['IsInterested'].toString()
        );
      },
    );
    setState(() {});
  }

  Future<void> downloadNewsFeedImages(arr) async {
    //int z=0;
    for(var a in arr){
      String img=a['NFImageFile']??"";
      List<dynamic> imgList=[];
      imgList=img.split(",");
      imgList.add(a['NFProfileImage']??"");
      for(int i=0;i<imgList.length;i++){
        String imgFolder=getFolderNameFromFolderPath(imgList[i]);
        String fileName=getFileNameFromFolderPath(imgList[i]);
        //console("file $z $imgFolder $fileName");
        await download(GetImageBaseUrl()+imgList[i],imgPath!.path,imgFolder,fileName);
      //  z++;
      }
    }
  }

  Widget getNewsFeed(int index,{String name="",String nfType="",String nfDescription="",String profileImg="",String nfLoc="",
    String date="",String time="", String img="",String isInterested="0"
  }){
   // console("getNewsFeed $index");
    List<dynamic> imgList=[];
    List<String> imgListUrl=[];
    imgList=img.split(",");
    for(int i=0;i<imgList.length;i++){
      imgListUrl.add('${imgPath!.path}/${imgList[i]}');
    }
    /*var reload=false.obs;
    if(imgList.isEmpty){
      reload.value=true;
    }
    for(int i=0;i<imgList.length;i++){
      imgListUrl.add('${imgPath!.path}/${imgList[i]}');
      String imgFolder=getFolderNameFromFolderPath(imgList[i]);
      String fileName=getFileNameFromFolderPath(imgList[i]);
      download(GetImageBaseUrl()+imgList[i],imgPath!.path,imgFolder,fileName).then((value){
        if(i==imgList.length-1){
          reload.value=true;
        }
      });
    }*/
    /*for (var element in imgList) {
      imgListUrl.add('${imgPath!.path}/$element');
    }*/

    Widget getImgContainer(path){
      /*var reload=false.obs;
      String imgFolder=getFolderNameFromFolderPath(path);
      String fileName=getFileNameFromFolderPath(path);
      download(GetImageBaseUrl()+path,imgPath!.path,imgFolder,fileName).then((value){
        reload.value=true;
      });*/
      /*return Obx(() => reload.value?Image.file(File('${imgPath!.path}/$path'),fit: BoxFit.cover):
      Image.asset('assets/logo.png',fit: BoxFit.cover));*/

      return Image.file(File('${imgPath!.path}/$path'),fit: BoxFit.cover,errorBuilder: (a,b,c){
        return Image.asset('assets/logo.png',fit: BoxFit.cover);
      });

     // return Image.file(File('/storage/emulated/0/Android/data/com.scutisoft.nammaramnamkadamai_dev/files/$path'),fit: BoxFit.cover);
     // return Obx(() => Image.asset(/*imgPath==null?'assets/logo.png':*/'/storage/emulated/0/Android/data/com.scutisoft.nammaramnamkadamai_dev/files/$path',fit: reload.value?BoxFit.cover:BoxFit.cover));
      //return CachedNetworkImage(imageUrl: GetImageBaseUrl()+path,fit: BoxFit.cover);
      //  return Image.network(GetImageBaseUrl()+path,fit: BoxFit.cover,);
    }

    Widget getProfile(path){
     // var reload=false.obs;
   /*   String imgFolder=getFolderNameFromFolderPath(path);
      String fileName=getFileNameFromFolderPath(path);
      download(GetImageBaseUrl()+path,imgPath!.path,imgFolder,fileName).then((value){
        reload.value=true;
      });*/

      //return Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,);
      return Image.file(File('${imgPath!.path}/$path'),fit: BoxFit.cover,errorBuilder: (a,b,c){
        return Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,);
      },);
     /* return Obx(() => reload.value?Image.file(File('${imgPath!.path}/$path'),fit: BoxFit.contain):
      Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,));*/

    }

    Widget getImgByCount(cunt) {
      if(cunt==1){
        return  SizedBox(
            width:SizeConfig.screenWidth,
            height: 200,
            child: getImgContainer(imgList[0])
        );
      }
      else if(cunt==2){
        return Container(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width:SizeConfig.screenWidth!*0.50,
                  height: 200,
                  child:getImgContainer(imgList[0])
              ),
              const SizedBox(width: 1,),
              SizedBox(
                  width:(SizeConfig.screenWidth!*0.5)-31,
                  height: 200,
                  child:getImgContainer(imgList[1])
              )
            ],
          ),
        );
      }
      else if(cunt>=3){
        return SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width:SizeConfig.screenWidth!*0.5,
                  height: 200,
                  child:getImgContainer(imgList[0])
              ),
              const SizedBox(width: 1,),
              SizedBox(
                width:(SizeConfig.screenWidth!*0.5)-31,
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                        width:SizeConfig.screenWidth,
                        height: 99.5,
                        child:getImgContainer(imgList[1])
                    ),
                    const SizedBox(height: 1,),
                    SizedBox(
                        width:SizeConfig.screenWidth,
                        height: 99.5,
                        child:getImgContainer(imgList[2])
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      return Container(height: 200,);
    }

    return Container(
      width: SizeConfig.screenWidth,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: ColorUtil.themeWhite
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getImgByCount(imgList.length),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ColorUtil.primary,
                          shape: BoxShape.circle,
                        ),
                        child: getProfile(profileImg)
                      /*child: Image.network(GetImageBaseUrl()+profileImg,fit: BoxFit.contain,errorBuilder: (a,b,c){
                       return Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,);
                     },),*/
                      // child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            flex:2,
                            child: Text("$name",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),)
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: ColorUtil.primary,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                            child: Text("$nfType",style:  TextStyle(fontFamily: 'RM',fontSize: 13,color: ColorUtil.themeWhite),)
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("$time",style:  TextStyle(fontFamily: 'RB',fontSize: 13,color: ColorUtil.themeBlack),),
                        Text("$date",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10 ,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                child: Text("$nfDescription",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,color: ColorUtil.text4,),
                    const SizedBox(width: 5,),
                    Text("$nfLoc",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),)
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Divider(
                thickness: 1,
                color: ColorUtil.text4,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_alt_sharp,color: ColorUtil.text4,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    /*Row(
                      children: [
                        Icon(Icons.comment,color: ColorUtil.primary,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),*/
                    Row(
                      children: [
                        Icon(Icons.thumb_up,color: ColorUtil.primary,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async{

                            showLoader.value=true;
                            List<String> localPath=[];
                           // List<XFile> localPath=[];
                            for (var element in imgList) {
                              /*String imgFolder=getFolderNameFromFolderPath(element);
                              String fileName=getFileNameFromFolderPath(element);*/
                              localPath.add('${imgPath!.path}/$element');
                            //  localPath.add(XFile('${imgPath!.path}/$element'));
                            }
                            showLoader.value=false;
                            console(localPath);
                            //Share.shareFiles(localPath,text: nfDescription,subject:nfType);

                            platform.invokeMethod("openShare",jsonEncode(localPath)).then((value){
                              console("platform $value");
                            });

                            /*console(nfDescription);
                            showLoader.value=false;
                            Share.shareFiles(localPath,text: nfDescription,subject:nfType);*/


                          //  Share.shareXFiles(localPath,text: nfDescription,subject:nfType );
                            //  ShareExtend.shareMultiple(localPath, "file",subject: nfType,extraTexts: [nfDescription]);
                            /* await FlutterShare.shareFile(
                              title: nfType,
                              text: nfDescription,
                              filePath: docs[0] as String,
                            );*/
                          },
                          child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Icon(Icons.share,color: ColorUtil.primary,)
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: nfType=='Event',
                      child: GestureDetector(
                        onTap: (){
                          updateEventInterest(index);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: isInterested=="1"?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          /*Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
              decoration: BoxDecoration(
                  color:Colors.orange,
                  borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text("Admin",style: TextStyle(fontSize: 12,color: ColorUtil.themeWhite,fontFamily:'RM'), ),
            ),
          ),*/
          Positioned(
            top: 165,
            right: 20,
            child: GestureDetector(
              onTap: (){
                showHideDotsPopup(imgListUrl);
                //fadeRoute(NewsFeedsView());
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtil.themeBlack,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: const Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  color: ColorUtil.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.themeWhite,),
              ),
            ),
          )
        ],
      ),
    );
  }



  void showHideDotsPopup(images) {
   /* Get.defaultDialog(
        title: "Hii"
    );*/
    PopupBanner(
      context: context,
      images: images,
      useDots: true,
      autoSlide: false,
      onClick: (index) {},
      fit: BoxFit.contain,
      isLocal: true
    ).show();
  }

  void updateEventInterest(int index) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: "USP_Events_InsertInterestedDetails"));
    params.add(ParameterModel(Key: "NFId", Type: "String", Value: filterNewsFeed[index]['NFID']));
    ApiManager().GetInvoke(params).then((value){
      if(value[0]){
        //var parsed=json.decode(value[1]);
        filterNewsFeed[index]['IsInterested']=filterNewsFeed[index]['IsInterested'].toString()=="1"?0:1;
        setState(() {});
      }
    });
  }

}

class SA extends StatelessWidget {
  String name = "";
  String nfType = "";
  String nfDescription = "";
    String profileImg = "";  String nfLoc = "";   String date = "";   String time = "";   String img = "";   String isInterested = "0";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: ColorUtil.themeWhite
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
             // getImgByCount(imgList.length),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ColorUtil.primary,
                          shape: BoxShape.circle,
                        ),
                      //  child: getProfile(profileImg)
                      /*child: Image.network(GetImageBaseUrl()+profileImg,fit: BoxFit.contain,errorBuilder: (a,b,c){
                       return Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,);
                     },),*/
                      // child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            flex:2,
                            child: Text("$name",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),)
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: ColorUtil.primary,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                            child: Text("$nfType",style:  TextStyle(fontFamily: 'RM',fontSize: 13,color: ColorUtil.themeWhite),)
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("$time",style:  TextStyle(fontFamily: 'RB',fontSize: 13,color: ColorUtil.themeBlack),),
                        Text("$date",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10 ,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                child: Text("$nfDescription",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,color: ColorUtil.text4,),
                    const SizedBox(width: 5,),
                    Text("$nfLoc",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),)
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Divider(
                thickness: 1,
                color: ColorUtil.text4,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_alt_sharp,color: ColorUtil.text4,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    /*Row(
                      children: [
                        Icon(Icons.comment,color: ColorUtil.primary,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),*/
                    Row(
                      children: [
                        Icon(Icons.thumb_up,color: ColorUtil.primary,),
                        const SizedBox(width: 8,),
                        Text("0",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async{

                            /*showLoader.value=true;
                            List<String> localPath=[];
                            // List<XFile> localPath=[];
                            for (var element in imgList) {
                              *//*String imgFolder=getFolderNameFromFolderPath(element);
                              String fileName=getFileNameFromFolderPath(element);*//*
                              localPath.add('${imgPath!.path}/$element');
                              //  localPath.add(XFile('${imgPath!.path}/$element'));
                            }
                            console(localPath);
                            console(nfDescription);
                            showLoader.value=false;
                            Share.shareFiles(localPath,text: nfDescription,subject:nfType);*/
                            // Share.shareXFiles(localPath,text: nfDescription,subject:nfType );
                            //  ShareExtend.shareMultiple(localPath, "file",subject: nfType,extraTexts: [nfDescription]);
                            /* await FlutterShare.shareFile(
                              title: nfType,
                              text: nfDescription,
                              filePath: docs[0] as String,
                            );*/
                          },
                          child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Icon(Icons.share,color: ColorUtil.primary,)
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: nfType=='Event',
                      child: GestureDetector(
                        onTap: (){
                          //updateEventInterest(index);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: isInterested=="1"?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          /*Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
              decoration: BoxDecoration(
                  color:Colors.orange,
                  borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text("Admin",style: TextStyle(fontSize: 12,color: ColorUtil.themeWhite,fontFamily:'RM'), ),
            ),
          ),*/
          Positioned(
            top: 165,
            right: 20,
            child: GestureDetector(
              onTap: (){
            //    showHideDotsPopup(imgListUrl);
                //fadeRoute(NewsFeedsView());
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtil.themeBlack,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: const Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  color: ColorUtil.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.themeWhite,),
              ),
            ),
          )
        ],
      ),
    );
  }

  SA({
      required this.name,
    required this.nfType,
    required this.nfDescription,
    required  this.profileImg,
    required this.nfLoc,
    required this.date,
    required this.time,
    required this.img,
    required this.isInterested}); //SA({Key? key,required this.name}) : super(key: key);
}
