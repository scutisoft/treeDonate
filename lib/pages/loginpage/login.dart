import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treedonate/widgets/loader.dart';

import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../coordinatorPage/coordinatorHomeScreen.dart';
import '../navHomeScreen.dart';


class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;

  @override
  void initState(){
    loadCredentials();
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    _text1.dispose();
    super.dispose();
  }

  void loadCredentials() async{
    _text.text=await getSharedPrefString(SP_USEREMAIL);
    _text1.text=await getSharedPrefString(SP_USERPASSWORD);
  }

  late  double width,height,width2,height2;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0XFFDAFAF7),
                        Color(0XFFC5EDEC),
                      ],
                    )
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png',width: 250,),
                      Stack(
                        children: [
                          Container(
                              child: Image.asset('assets/login/login.png')
                          ),
                          Container(
                            margin: EdgeInsets.all(20.0),
                            padding: EdgeInsets.only(top: 50.0,bottom: 150,left: 20,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: ColorUtil.themeWhite
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text('Login',style: TextStyle(fontSize: 16,fontFamily: 'RB',color: Color(0XFF000000)),)
                                ),
                                SizedBox(height: 5,),
                                Container(
                                    child: Text('Your Account',style: TextStyle(fontSize: 14,fontFamily: 'RR',color: ColorUtil.text4),)
                                ),
                                SizedBox(height: 20,),
                                TextField(
                                  controller: _text,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFF000000),letterSpacing: 1.0,),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: ColorUtil.text4)
                                    ),
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: Colors.white)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    prefixIcon: Icon(Icons.person_outline_outlined,size: 20,color: ColorUtil.text4),
                                    hintText: 'Enter Email',
                                    errorStyle: TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFFBCBBCD),),
                                    hintStyle:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFFBCBBCD),),
                                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top:10),
                                  child: TextField(
                                    controller: _text1,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    obscureText: false,
                                    style:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFF000000),letterSpacing: 1.0,),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide(color: ColorUtil.text4)
                                      ),
                                      border: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      prefixIcon: Icon(Icons.lock,size: 20,color: ColorUtil.text4),
                                      hintText: 'Enter Password',
                                      errorStyle: TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFFBCBBCD),),
                                      hintStyle:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFFBCBBCD),),
                                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                    ),
                                    onEditingComplete: (){
                                      login();
                                    },
                                  ),
                                ),
                                SizedBox(height: 40,),
                                GestureDetector(
                                  onTap: (){
                                    // Get.to(Masterpage());
                                    // Get.to(CooardinatorHomePage());

                                    login();
                                    //fadeRoute(MyHomePage());
                                  },
                                  child: Container(
                                    width: width*0.6,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtil.primary.withOpacity(0.7),
                                          blurRadius: 25.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            0.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      color: ColorUtil.primary,
                                    ),
                                    child:Center(child: Text('Login',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => Loader(value: showLoader.value,))
            ],
          ),
        ),
    );
  }
  login() async{
    if(_text.text.isEmpty){
      CustomAlert().cupertinoAlert("Enter Email....");
      return;
    }
    if(_text1.text.isEmpty){
      CustomAlert().cupertinoAlert("Enter Password....");
      return;
    }
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.loginSp));
    params.add(ParameterModel(Key: "UserName", Type: "String", Value: _text.text));
    params.add(ParameterModel(Key: "Password", Type: "String", Value: _text1.text));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    ApiManager().GetInvoke(params).then((value){
      if(value[0]){
        console(value);
        var parsed=json.decode(value[1]);
        try{
          setUserSessionDetail(parsed["Table"][0]);
          accessData=parsed['Table1'];
          Get.off(MyHomePage());
        }catch(e){}
        //print(parsed);
      }
    });
  }
}
