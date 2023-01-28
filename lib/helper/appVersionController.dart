import 'dart:convert';

import '../utils/colorUtil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../model/parameterMode.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

class AppVersionController{
  void getAppVersionDetail() async{
    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: "USB_GetAppVersionDetail"));
    params.add(ParameterModel(Key: "AppName", Type: "String", Value: MyConstants.appName));
    ApiManager().GetInvoke(params,/*hideLoaders: true*/).then((value){
      if(value[0]){
        var response=json.decode(value[1]);
        if(response['Table']!=null){
          if(response['Table'].length>0){
            if(response['Table'][0]['AppVersionNumber']!=MyConstants.appVersion){
              Get.defaultDialog(
                  title: "",
                  titleStyle: TextStyle(height: 0),radius: 10,middleText: "New Update Available",middleTextStyle: TextStyle(fontFamily: "RR",fontSize: 20,),
                  barrierDismissible: false,
                  contentPadding: EdgeInsets.all(20),
                  confirm: GestureDetector(
                    onTap: (){
                      launchUrl(Uri.parse(response['Table'][0]['AppVersionURL']),mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorUtil.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Update",style: ts18(Colors.white),),
                    ),
                  )
              );
            }
          }
        }
      }
    });
  }
}