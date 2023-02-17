import 'dart:async';
import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/alertDialog.dart';
import 'package:treedonate/widgets/customAppBar.dart';
import 'package:treedonate/widgets/customCheckBox.dart';
import 'package:treedonate/widgets/searchDropdown/dropdown_search.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../model/parameterMode.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/videoPlayer/src/flick_video_player.dart';
import '../../widgets/videoPlayer/src/manager/flick_manager.dart';

class AddVolunteer extends StatefulWidget {
  String? editId;
  VoidCallback? closeCb;
  bool isDirectAdd;

  AddVolunteer({this.editId,this.closeCb,this.isDirectAdd=false});

  @override
  _AddVolunteerState createState() => _AddVolunteerState();
}

class _AddVolunteerState extends State<AddVolunteer> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];

  var volunteerType=1.obs;
  var isAccept=false.obs;

  BoxDecoration inActiveDec=BoxDecoration(
    shape:BoxShape.circle,
    color: ColorUtil.primary.withOpacity(0.5),
    border:Border.all(color:Colors.white,width: 3.0),
  );
  BoxDecoration activeDec=BoxDecoration(
    shape:BoxShape.circle,
    color: ColorUtil.primary,
    border:Border.all(color:Colors.white,width: 3.0),
  );

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }
  ScrollController? silverController;
  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body:  NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  automaticallyImplyLeading: true,
                  leading:  ArrowBack(
                     onTap: (){
                       Get.back();
                    },
                    iconColor: ColorUtil.themeBlack,
                  ),
                  leadingWidth: 50.0,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(left: 40),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('நம் மரம்\nநம் கடமை',style: TextStyle(fontSize: 12,color: ColorUtil.primary,fontFamily: 'RM'),textAlign: TextAlign.start,),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            showProductVideo();
                          },
                          child: Container(
                            height: 30,
                            width: 70,
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.only(left:15,right: 15),
                            decoration: BoxDecoration(
                                color: ColorUtil.secondary,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            alignment: Alignment.center,
                            child: Text('Watch Video',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  background: Container(
                    alignment: Alignment.centerRight,
                      child: Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,)
                  ),
                  ),
                ),
              ];
            },
            body:Container(
              // height: SizeConfig.screenHeight,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                    child: Text('Volunteer Information',style: TextStyle(fontSize: 14,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                  ),
                  SizedBox(height: 5,),
                  Flexible(
                   child:  ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        widgets[0],
                        widgets[1],
                        widgets[2],
                        widgets[3],
                        widgets[4],
                        widgets[5],
                        widgets[6],
                        widgets[7],

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10,bottom: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  volunteerType.value=2;
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border:Border.all(color: ColorUtil.primary,width: 1.0),
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Obx(() => AnimatedContainer(
                                          duration: MyConstants.animeDuration,
                                          padding: const EdgeInsets.all(10),
                                          width: 10,
                                          height: 10,
                                          decoration: volunteerType.value==2?activeDec:inActiveDec,
                                        )),
                                      ),
                                      const SizedBox(width: 10,),
                                      Text('NGO',style: TextStyle(fontSize: 15,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30,),
                              GestureDetector(
                                onTap:(){
                                  volunteerType.value=1;
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border:Border.all(color: ColorUtil.primary.withOpacity(0.5),width: 1.0),
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Obx(() => AnimatedContainer(
                                          duration: MyConstants.animeDuration,
                                          padding: const EdgeInsets.all(10),
                                          width: 10,
                                          height: 10,
                                          decoration: volunteerType.value==1?activeDec:inActiveDec,
                                        )),
                                      ),
                                      SizedBox(width: 10,),
                                      Text('Individual',style: TextStyle(fontSize: 15,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15,right: 15,top: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HE_Text(
                                  dataname: "",
                                  content: "Our Policy",
                                  contentTextStyle: ts18(ColorUtil.text2,fontfamily: "RM")
                              ),
                              const SizedBox(height: 10,),
                              widgets[9],
                              const SizedBox(height: 10,),
                              widgets[10],
                              const SizedBox(height: 10,),
                              widgets[11],
                              const SizedBox(height: 10,),
                              Obx(() => CustomCheckBox(isSelect: isAccept.value,content: "Accept",ontap: (){isAccept.value=!isAccept.value;},)),
                              const SizedBox(height: 20,)
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        GestureDetector(
                          onTap: (){
                            onSubmit();
                          },
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: 50,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(left:15,right: 15),
                            decoration: BoxDecoration(
                                color: ColorUtil.secondary,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            alignment: Alignment.center,
                            child: Text('Submit',style: TextStyle(fontFamily: 'RR',color: ColorUtil.themeWhite,fontSize: 14),),
                          ),
                        ),
                        SizedBox(height:15,),
                      ],
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
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "Name",
      regExp: null,
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
      onChange: (v){
        if(v.length==10){
          widgets[2].isEnabled=true;
          widgets[2].reload.value=!widgets[2].reload.value;
          requestOtp(v);
          Timer(const Duration(milliseconds: 500), () {
            node.nextFocus();
          });

        }
        else{
          widgets[2].isEnabled=false;
          widgets[2].reload.value=!widgets[2].reload.value;
          widgets[2].clearValues();
        }
      },
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'OTP',
      hasInput: true,
      required: true,
      isEnabled: false,
      labelText: "OTP",
      textInputType: TextInputType.number,
      textLength: 6,
      regExp: MyConstants.digitRegEx,
      onChange: (v){

      },
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
    widgets.add(HiddenController(dataname: "VolunteerId"));
/*    widgets.add(AddNewLabelTextField(
      dataname: 'Address',
      hasInput: true,
      required: true,
      labelText: "Address",
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));*/
    widgets.add(SearchDrp2(map: const {
      "dataName":"District","hintText":"Select District","showSearch":true,"mode":Mode.DIALOG,
      "dialogMargin":EdgeInsets.all(0.0),"labelText":"District"
    },required: true,));
    widgets.add(AddNewLabelTextField(
      dataname: 'Zipcode',
      hasInput: true,
      required: true,
      labelText: "Zipcode",
      textInputType: TextInputType.number,
      textLength: 6,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(SearchDrp2(map: const {"dataName":"Interest","hintText":"Select Interest","labelText":"Interest"},required: false,));

    widgets.add(HiddenController(dataname: "VolunteerType"));
    widgets.add( HE_Text(
        dataname: "PolicyContent1",
        content: "",
        contentTextStyle: ts15(ColorUtil.text2,fontfamily: "RR")
    ));
    widgets.add( HE_Text(
        dataname: "PolicyContent2",
        content: "",
        contentTextStyle: ts15(ColorUtil.text2,fontfamily: "RR")
    ));
    widgets.add( HE_Text(
        dataname: "PolicyContent3",
        content: "",
        contentTextStyle: ts15(ColorUtil.text2,fontfamily: "RR")
    ));
    setState(() {});
    await parseJson(widgets, General.addVolunteerIdentifier,dataJson: widget.editId);
  }


  void onSubmit() async{
    widgets[8].setValue(volunteerType.value);
    sysSubmit(widgets,needCustomValidation: true,onCustomValidation: (){
      if(!isAccept.value){
        CustomAlert().cupertinoAlert("Please Accept Our Policy...");
      }
      return isAccept.value;
    },successCallback: (e){
      isAccept.value=false;
    },isEdit: !widget.isDirectAdd,closeFrmOnSubmit: !widget.isDirectAdd);
  }

  void requestOtp(contactNumber){
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertOTP));
    params.add(ParameterModel(Key: "ContactNumber", Type: "String", Value: contactNumber));
    ApiManager().GetInvoke(params).then((value){
      if(value[0]){
        console(value);
        var parsed=json.decode(value[1]);
        try{
        }catch(e){}
        //print(parsed);
      }
    });
  }


  @override
  String getPageIdentifier(){
    return General.addVolunteerIdentifier;
  }


  void showProductVideo(){
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: '4NvaH_aSjyM',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    /*FlickManager flickManager=FlickManager(
        videoPlayerController: VideoPlayerController.network("https://www.youtube.com/watch?v=4NvaH_aSjyM")
    );*/

    Get.dialog(Dialog(

      //shape: alertRadius,
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAlias,
      insetPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
          height:186,
          width:SizeConfig.screenWidth,
          decoration:const BoxDecoration(
            color:Colors.black,
          ),

          child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  //videoProgressIndicatorColor: Colors.amber,
                  /*progressColors: ProgressColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),*/
                  /*onReady () {
                _controller.addListener(listener);
                },*/
                ),
                /*Container(
                  //margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                  child: FlickVideoPlayer(
                      flickManager: flickManager
                  ),
                )*/
              ]
          )
      ),
    )).then((value){
      //flickManager.dispose();
      controller.dispose();
    });
  }
}
