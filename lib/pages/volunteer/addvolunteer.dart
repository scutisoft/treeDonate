import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treedonate/utils/utils.dart';
import 'package:treedonate/widgets/alertDialog.dart';
import 'package:treedonate/widgets/customCheckBox.dart';
import 'package:treedonate/widgets/searchDropdown/dropdown_search.dart';
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

  var volunteerType=2.obs;
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

  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    height: 250,
                    child: Container(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:140,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(onPressed: (){
                                       Get.back();
                                  },
                                      icon: Icon(Icons.arrow_back_ios_new_sharp,color:ColorUtil.themeBlack)
                                    //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Save Trees',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 24),),
                                        Text('${DateFormat("dd-MMM-yyyy").format(DateTime.now())} \n${DateFormat().add_jm().format(DateTime.now())}',style: TextStyle(color:ColorUtil.text5,fontFamily: 'RR',fontSize: 14,height: 1.4),),
                                        SizedBox(height: 10,),
                                       // Text('Chennai',style: TextStyle(color:ColorUtil.primary,fontFamily: 'RB',fontSize: 24),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,width: SizeConfig.screenWidth!-140,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                    child: Text('Volunteer Information',style: TextStyle(fontSize: 14,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: SizeConfig.screenHeight!-350,
                    width: SizeConfig.screenWidth!*1,
                    child:  ListView(
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
                                           border:Border.all(color: ColorUtil.primary,width: 1.0),
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
                                     const SizedBox(width: 10,),
                                     Text('NGO',style: TextStyle(fontSize: 15,color: ColorUtil.themeBlack,fontFamily: 'RM'),),
                                   ],
                                 ),
                               ),
                             ),
                             const SizedBox(width: 30,),
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
                                           border:Border.all(color: ColorUtil.primary.withOpacity(0.5),width: 1.0),
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
                        )

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
    },isEdit: !widget.isDirectAdd);
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

}
