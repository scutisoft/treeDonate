import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


var selectedLanguage=2.obs;

class Language{
  Language._();

  static String regularFF="RR";
  static String boldFF="RB";
  static String mediumFF="RM";

  static Map volunteer={"Value":"Volunteer","FontSize":16.0,"FontFamily":"RR"};
  static Map takeLogin={"Value":"Take \nLogin","FontSize":15.0,"FontFamily":"RR"};
  static Map growingPlant={"Value":"Growing \nPlant","FontSize":15.0,"FontFamily":"RB"};
  static Map login={"Value":"Login","FontSize":15.0,"FontFamily":"RB"};
  static Map loginTitle={"Value":"Login","FontSize":16.0,"FontFamily":"RB"};
  static Map yourAccount={"Value":"Your Account","FontSize":14.0,"FontFamily":"RR"};
  static String enterEmail='Enter Email';
  static String enterPassword='Enter Password';
  static String createPin='Create Pin';
  static String resetPin='Reset Pin';
  static String skip='Skip';
  static String newPin='Enter New Pin';
  static String confirmPin='Confirm New Pin';
  static String setPin='Set Pin';
  static String pinDoesntMatch="Pin doesn't match...";
  static String dashboard="Dashboard";
  static String homePage="Home Page";
  static String myProfile="My Profile";
  static String donate="Donate";
  static String myHistory="My History";
  static String myCertificate="My Certificate";
  static String ourEvents="Our Events";
  static String myTrees="My trees";
  static String landParcel="Land Parcel";
  static String notification="Notification";
  static String seeding="Seed Collection";
  static String nursery="Nursery";
  static String planting="Plantation";
  static String newsFeedTitle="News & Feeds";
  static String noData="No Data Available";
  static String seedsStock="Seeds Stock";
  static String target="Target";
  static String editProfile="Edit Profile";
  static String update="Update";
  static String email="Email";
  static String mobileNo="Mobile Number";
  static String password="Password";
  static String logOut="LogOut";
  static String rights="All Rights Reserved.";
  static String lacHectare="Lac Hectare";


  static Future parseJson(languageId) async{
    if(languageId==1){
      regularFF='RR';
      boldFF='RB';
      mediumFF="RM";
    }
    else if(languageId==2){
      regularFF='MMR';
      boldFF='MMB';
      mediumFF="MMM";
    }

      String data = await DefaultAssetBundle.of(Get.context!).loadString("assets/json/language.json");
      var parsedData=jsonDecode(data);
      Map languageSource=parsedData['Source'];
      volunteer=languageSource['LB_1'][languageId.toString()];
      takeLogin=languageSource['LB_2'][languageId.toString()];
      growingPlant=languageSource['LB_3'][languageId.toString()];
      login=languageSource['LB_4'][languageId.toString()];
      loginTitle=languageSource['LB_15'][languageId.toString()];
      yourAccount=languageSource['LB_5'][languageId.toString()];
      enterEmail=languageSource['LB_6'][languageId.toString()];
      enterPassword=languageSource['LB_7'][languageId.toString()];
      createPin=languageSource['LB_8'][languageId.toString()];
      resetPin=languageSource['LB_9'][languageId.toString()];
      skip=languageSource['LB_10'][languageId.toString()];
      newPin=languageSource['LB_11'][languageId.toString()];
      confirmPin=languageSource['LB_12'][languageId.toString()];
      setPin=languageSource['LB_13'][languageId.toString()];
      pinDoesntMatch=languageSource['LB_14'][languageId.toString()];
    dashboard=languageSource['LB_16'][languageId.toString()];
    homePage=languageSource['LB_17'][languageId.toString()];
    myProfile=languageSource['LB_18'][languageId.toString()];
    donate=languageSource['LB_19'][languageId.toString()];
    myHistory=languageSource['LB_20'][languageId.toString()];
    myCertificate=languageSource['LB_21'][languageId.toString()];
    ourEvents=languageSource['LB_22'][languageId.toString()];
    myTrees=languageSource['LB_23'][languageId.toString()];
    landParcel=languageSource['LB_24'][languageId.toString()];
    notification=languageSource['LB_25'][languageId.toString()];
    seeding=languageSource['LB_26'][languageId.toString()];
    nursery=languageSource['LB_27'][languageId.toString()];
    planting=languageSource['LB_28'][languageId.toString()];
    newsFeedTitle=languageSource['LB_29'][languageId.toString()];
    noData=languageSource['LB_30'][languageId.toString()];
    seedsStock=languageSource['LB_31'][languageId.toString()];
    target=languageSource['LB_32'][languageId.toString()];
    editProfile=languageSource['LB_33'][languageId.toString()];
    update=languageSource['LB_34'][languageId.toString()];
    email=languageSource['LB_35'][languageId.toString()];
    mobileNo=languageSource['LB_36'][languageId.toString()];
    password=languageSource['LB_37'][languageId.toString()];
    logOut=languageSource['LB_38'][languageId.toString()];
    rights=languageSource['LB_39'][languageId.toString()];
  //  lacHectare=languageSource['LB_40'][languageId.toString()];



  }
}