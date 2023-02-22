import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/utils.dart';
import '../../api/ApiManager.dart';
import '../../helper/language.dart';
import '../../pages/volunteer/viewVolunteer.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/recase.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/navigationBarIcon.dart';
import '../Filter/FilterItems.dart';
import '../landParcel/LandParcelViewPage.dart';
import 'addvolunteer.dart';
import 'volunteerFilter.dart';

class VolunteerPage extends StatefulWidget {
  VoidCallback voidCallback;
  VolunteerPage({super.key, required this.voidCallback});

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  List<Widget> widgets=[];

  RxDouble silverBodyTopMargin=RxDouble(0.0);
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  late HE_ListViewBody he_listViewBody;

  @override
  void initState(){
    silverController=ScrollController();
    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_VListViewContent(
          data: e,
          globalKey: GlobalKey(),
          cardWith: SizeConfig.screenWidth!-(55+30),
          onDelete: (dataJson){
            sysDeleteHE_ListView(he_listViewBody, "VolunteerId",dataJson: dataJson);
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("VolunteerId", updatedMap);
          },
        );
      },
      //scrollController: globalKey.currentState!.innerController,
    );
    WidgetsBinding.instance.addPostFrameCallback((_){

      silverBodyTopMargin.value=0.0;
      silverController!.addListener(() {
        if(silverController!.offset>triggerOffset){
            silverBodyTopMargin.value=toolBarHeight-(-(silverController!.offset-flexibleSpaceBarHeight));
            if(silverBodyTopMargin.value<0){
              silverBodyTopMargin.value=0;
            }
        }
        else if(silverController!.offset<triggerEndOffset){
            silverBodyTopMargin.value=0;
        }
      });
     // he_listViewBody.scrollListener(globalKey.currentState!.innerController);

    });
    assignWidgets();
    super.initState();
  }



  var node;
  double cardWith=0.0;
  final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWith=SizeConfig.screenWidth!-(55+30);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: const Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            key: globalKey,
            //physics: const NeverScrollableScrollPhysics(),
            controller: silverController,
            // floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: const Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leadingWidth: 50.0,
                  leading: NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  /*leading: GestureDetector(
                      onTap: (){
                        widget.voidCallback();
                      },
                      child: Icon(Icons.arrow_back_ios_new_sharp,color: ColorUtil.themeBlack,size: 25,)
                  ),*/
                  flexibleSpace:  FlexibleSpaceBar(
                    expandedTitleScale: 1.5,
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(left: 50,bottom: 16),
                    title: Text(Language.volunteerDetails,style: TextStyle(fontSize: 18,color: ColorUtil.themeBlack,fontFamily: Language.mediumFF)),
                    background: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,)
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 5.0,),
                  child: Column(
                    // controller: silverController,
                    //  physics: const NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //SizedBox(height: 50,),
                      Obx(() => Container(
                        height: 50,
                        margin: EdgeInsets.only(top: (10+silverBodyTopMargin.value),bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimSearchBar(
                              width: SizeConfig.screenWidth!-80,
                              color: ColorUtil.asbColor,
                              boxShadow: ColorUtil.asbBoxShadow,
                              textController: textController,
                              closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                              searchIconColor: ColorUtil.asbSearchIconColor,
                              suffixIcon: ColorUtil.getASBSuffix(),
                              onSubmitted: (a){
                              },
                              onChange: (a){
                                he_listViewBody.searchHandler(a);
                              },
                              onSuffixTap: (clear) {
                                if(clear){
                                  he_listViewBody.searchHandler("");
                                }
                              },
                            ),
                            const SizedBox(width: 5,),
                            FilterIcon(
                              onTap: (){
                                fadeRoute(VolunteerFilter());
                              },
                            ),
                            const SizedBox(width: 15,),
                          ],
                        ),
                      ),),
                      Flexible(child:he_listViewBody),
                      Obx(() => NoData(show: he_listViewBody.widgetList.isEmpty,)),
                    ],
                  ),
                ),
                ShimmerLoader(),
              ],
            )
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    getData({});
  }

  void getData(dataJson) async{
    await parseJson(widgets, General.volunteerDetailIdentifier,dataJson: jsonEncode(dataJson));
    List<dynamic> volunteerList=valueArray.where((element) => element['key']=="VolunteerList").toList()[0]['value'];
    he_listViewBody.assignWidget(volunteerList);
    //  setState(() {});
  }

  @override
  String getPageIdentifier(){
    return General.volunteerDetailIdentifier;
  }
}

class HE_VListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWith;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  HE_VListViewContent({Key? key,required this.data,this.onEdit,required this.cardWith,this.onDelete, required this.globalKey}) : super(key: key){
    dataListener.value=data;
  }

  var dataListener={}.obs;
  var separatorHeight = 50.0.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      separatorHeight.value=parseDouble(globalKey.currentContext!.size!.height)-30;
    });
    return Obx(
            ()=> Container(
              key: globalKey,
              margin: const EdgeInsets.only(bottom: 10,left: 15,right: 10),
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              width: SizeConfig.screenWidth!*1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0XFFffffff),
              ),
              clipBehavior:Clip.antiAlias,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    width: cardWith*0.65,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text('${dataListener['VolunteerName']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${Language.date} :',style: ts14(ColorUtil.text4,),),
                            Text('${dataListener['JoinedDate']}',style: ts14(ColorUtil.themeBlack,fontfamily: 'Med'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${Language.phoneNo} :',style: ts14(ColorUtil.text4,),),
                            Text('${dataListener['VolunteerContactNo']}',style: ts14(ColorUtil.primary,fontfamily: 'Med'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${Language.location} :',style: ts14(ColorUtil.text4,),),
                            Text(getTitleCase(dataListener['DistrictName']),style: ts14(ColorUtil.primary,fontfamily: 'Med'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${Language.role} :',style: ts14(ColorUtil.text4,),),
                            Text(getTitleCase(dataListener['VolunteerRole']),style: ts14(ColorUtil.primary,fontfamily: 'Med'),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Spacer(),
                  Container(
                    width: 30,
                    alignment:Alignment.topRight,
                    child: Column(
                      children: [
                        Container(
                          width: 15,
                          height:10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                            color: Color(0xFFF2F3F7),
                          ),
                        ),
                        Container(width: 1,height:separatorHeight.value,color: Color(0xFFF2F3F7),),
                        Container(
                          width: 15,
                          height:10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                            color: Color(0xFFF2F3F7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: cardWith*0.35,
                            height: 50,
                            alignment:Alignment.center,
                            // color:Colors.red,
                            child: Image.asset('assets/Slice/DefaultVolunteer.png',)
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            EyeIcon(
                              onTap: (){
                                fadeRoute(VolunteerView(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                  updateDataListener(e['Table'][0]);
                                  if(onEdit!=null){
                                    onEdit!(e['Table'][0]);
                                  }
                                },));
                              },
                            ),
                            const SizedBox(width: 10,),
                            GridDeleteIcon(
                              hasAccess: isHasAccess(accessId["VolunteerDelete"]),
                              onTap: (){
                                if(onDelete!=null){
                                  onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }

  @override
  updateDataListener(Map data) {
    data.forEach((key, value) {
      if(dataListener.containsKey(key)){
        dataListener[key]=value;
      }
    });
  }
}
