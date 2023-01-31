import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/apiUtils.dart';
import '../notifier/getUiNotifier.dart';
import 'colorUtil.dart';
import 'constants.dart';


class General{
  //Bala bro please note this ("users/HOME-PAGE-USER-9898") (users/fileName)
  //Add user json files in assets/json/users..........
  static String donateIdentifier=!MyConstants.fromUrl?"assets/json/users/donate.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addVolunteerIdentifier=!MyConstants.fromUrl?"assets/json/users/add-volunteer.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addLandParcelIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcel.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addLandParcelGirdIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcelGrid.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addLandParcelViewIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcelView.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";


  static String eventName="eventName";
  static String FormSubmit="FormSubmit";
  static String Navigation="Navigation";
  static String openDrawer="OpenDrawer";
  static String formSubmitNavigate="FormSubmitNavigate";
  static String formDataJson_ApiCall="formDataJson_ApiCall";

  static String changeValues="changeValues";
  static String changeValuesArray="changeValuesArray";
  static String locationClick="locationClick";
  static String navigateToPage="navigateToPage";
  static String typeOfNavigation="typeOfNavigation";
  static String actionType="actionType";
  static String openMap="openMap";
  static String dynamicPageGuid="dynamicPageGuid";
  static String changePageViewIndex="changePageViewIndex";
  static String pageViewPrevious="pageViewPrevious";
  static String openDialer="OpenDialer";
  static String openDialog="openDialog";
  static String openDatePicker="openDatePicker";
  static String reload="reload";
  static String getByIdArray="getByIdArray";

  checkApiCall(Map clickEvent,var res,String pageId) async{
    var val="";
    Get.defaultDialog(
      title: "",
      content: CircularProgressIndicator(),
      barrierDismissible: false,
    );
    await GetUiNotifier().postUiJson( await getLoginId(), pageId, res,clickEvent).then((value){
      Get.back();
      log("checkApiCall response $value");
      if(value[0]){
        val=value[1];
      }
      else{
        Get.dialog(  CupertinoAlertDialog(
          title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
          content: Text("${value[1]}",
            style: TextStyle(fontSize: 18),),
        ));
      }
      //val=value;

    });
    return val;
  }


  showAlertPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }

  showSuccessPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }


  getPage(String page,{String dynamicPageIdentifier="",String dataJson=""}){
    switch(page){
    }
    return Container();
  }


}