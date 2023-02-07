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
  static String volunteerDetailIdentifier=!MyConstants.fromUrl?"assets/json/users/volunteerDetail.json":"02BEE340-2EB9-45A7-B89E-1129414BC238";
  static String addVolunteerIdentifier=!MyConstants.fromUrl?"assets/json/users/add-volunteer.json":"85C7DE06-9E9B-4532-9D3E-B740F164BBA6";
  static String viewVolunteerIdentifier=!MyConstants.fromUrl?"assets/json/users/volunteerView.json":"AF0D9D82-F943-48A3-BD89-46118B1D3174";
  static String addLandParcelIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcel.json":"DACF7963-7A17-42A8-82B3-8DC83C072BCE";
  static String addLandParcelGirdIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcelGrid.json":"C54B3AE0-24A6-4BC0-849B-C5F9C6FF9E07";
  static String addLandParcelViewIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcelView.json":"4F219F7A-3203-420A-A816-D41627A002D3";
  static String addSeedCollectionFrmIdentifier=!MyConstants.fromUrl?"assets/json/users/seedCollectionForm.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addSeedGridViewIdentifier=!MyConstants.fromUrl?"assets/json/users/SeedingGrid.json":"24FEEB47-777D-4277-B2A4-D3066360FFC6";
  static String addSeedviewListIdentifier=!MyConstants.fromUrl?"assets/json/users/seedingView.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String addNurseryFormIdentifier=!MyConstants.fromUrl?"assets/json/users/NurseryForm.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String NurseryGridIdentifier=!MyConstants.fromUrl?"assets/json/users/nurseryGrid.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String NurseryViewIdentifier=!MyConstants.fromUrl?"assets/json/users/nurseryView.json":"4CE18B2F-15DC-4899-957B-C851ECCBFC34";
  static String ProfileViewIdentifier=!MyConstants.fromUrl?"assets/json/users/MyProfile.json":"DEF0DF35-8B09-49DF-9560-06453BEFB043";
  static String EditProfileViewIdentifier=!MyConstants.fromUrl?"assets/json/users/Edit-Profile.json":"DEF0DF35-8B09-49DF-9560-06453BEFB043";
  static String HomePageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/HomePage.json":"6F4207A7-8DF9-458B-9B99-D1386FCB2B93";


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