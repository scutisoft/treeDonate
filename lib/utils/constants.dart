import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyConstants{
  MyConstants._();
  static String appName="TreeDonate";
  //static String appName="RadiantECS_Dev";
  static String appVersion="1.0.3";
  static bool isLive=false;
  static bool fromUrl=false;
  static bool hasAppVersionController=false;
  static bool bottomSafeArea=true;

  static Duration animeDuration = const Duration(milliseconds: 300);
  static Cubic animeCurve=Curves.easeIn;

  static String dbDateFormat="yyyy-MM-dd";
  static String decimalReg=r'^\d+\.?\d{0,3}';
  static int phoneNoLength=10;
  static int zipcodeLength=6;
  static String digitRegEx='[0-9]';
  static String digitDecimalRegEx=r'^\d+\.?\d{0,30}';
  static String alphaSpaceRegEx='[A-Za-z ]';
  static String alphaSpaceRegEx2="/[அ-ஔ]+|[க-னௌ]+|[ァ-ヴー]+|[a-zA-Z ]+|[々〆〤ヶ]+/u";
  static String addressRegEx='[A-Za-z0-9-,_/*+()@. ]';
}

var formatCurrency = NumberFormat.currency(locale: 'HI',name: "");
double textFormWidth=400;

glowFunTransparent(BuildContext context){
  return Theme.of(context).copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white10
      )
  );
}

ts12(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 12,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts14(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 14,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts15(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 15,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts16(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 16,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts18(Color color,{String fontfamily='RR',double fontsize=18,double ls=0.1}){
  return TextStyle(fontSize: fontsize,fontFamily: fontfamily,color: color,letterSpacing: ls);
}


// double topPad=24.0;



clearCache() async{
  //print("clearCache");
//  SharedPreferences sp=await SharedPreferences.getInstance();


}

void  fadeRoute(Widget widget) {
  Get.to(widget,transition: Transition.fadeIn,duration: const Duration(milliseconds: 400));
}
void fadeRouteOff(Widget widget) {
  Get.off(widget,transition: Transition.fadeIn,duration: const Duration(milliseconds: 400));
}