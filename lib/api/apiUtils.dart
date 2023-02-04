
import '../utils/constants.dart';

import '../model/parameterMode.dart';
import '../notifier/configuration.dart';

int loginUserId=0;
String databaseName="";
int outletId=0;
String outletName="";

String GetBaseUrl(){
  //return "https://scutisoft.in/zoomnshop";
  return MyConstants.isLive?"http://45.126.252.78/EGF": "http://192.168.1.140:5009";
}
String GetImageBaseUrl(){
  return MyConstants.isLive?"http://45.126.252.78/Rad_ECS/AppAttachments/": "http://192.168.1.140:5009/AppAttachments/";
}


getParameterEssential({bool needOutletId=false}) async{
  return [
    ParameterModel(Key: "LoginUserId", Type: "int", Value: await getLoginId()),
    ParameterModel(Key: "IsMobile", Type: "int", Value: 1),
    ParameterModel(Key: "database", Type: "String", Value: getDatabase()),
    ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()),
    if(needOutletId)
      ParameterModel(Key: "OutletId", Type: "String", Value: await getOutletId()),
  ];
}

getLoginId() async{
  //SharedPreferences sp=await SharedPreferences.getInstance();
  // return sp.getInt("LoginUserId");
  return await getSharedPrefString(SP_USER_ID);
}

getDatabase(){
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return  MyConstants.isLive?"RestaPOS_EcoGreen":"RestaPOS_EcoGreen";
}

getOutletId() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletId;
}
getOutletName() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletName;
}