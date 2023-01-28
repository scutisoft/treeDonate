import '../utils/constants.dart';
import '../widgets/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../api/apiUtils.dart';
import '../model/parameterMode.dart';
import '../notifier/getUiNotifier.dart';
abstract class ExtensionCallback {
  String getType();
  getValue();
  setValue(var value);
  bool validate();
  String getDataName();
  void clearValues();
}

class HappyExtensionHelper{
  Future<List<ParameterModel>> getFrmCollection(List widgets) async{

    List<ParameterModel> parameterList=[];
    for (var widget in widgets) {
      String elementType="";
      try{
        elementType=widget.getType();
      }catch(e){}

      if(elementType=='inputTextField'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.validate()){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
          }
        }
      }
      if(elementType=='searchDrp' || elementType=='searchDrp2'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.validate()){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
          }
        }
      }
      if(elementType=='hidden'){
        if(widget.hasInput??false){
          parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
        }
      }
    }
    return parameterList;
  }

  setFrmValuesV2(List widgets,List response){
    if (response!=null && response.isNotEmpty) {
      for(int i=0;i<response.length;i++){
        response[i].forEach((key,value){
          //log("Key $key $value");
          var widget=null;
          var foundWid=widgets.where((x) => x.getDataName()==key).toList();
          if(foundWid.length==1){
            widget=foundWid[0];
          }
          if(widget!=null){
            String widgetType="";
            try{
              widgetType=widget.getType();
            }catch(e){}

            if(widgetType=='hidden'){
              widget.setValue(value??"");
            }
            else if(widgetType=='inputTextField'){
              widget.setValue(value.toString());
            }
            else if(widgetType=='searchDrp'){
              widget.setValues({"Id":value});
            }
          }
        });
      }
    }
  }
  setFrmValues(List widgets,List valueArray){
    if (valueArray!=null && valueArray.isNotEmpty) {
      for (var value in valueArray) {
        var widget=null;
        var foundWid=widgets.where((x) => x.getDataName()==value['key']).toList();
        if(foundWid.length==1){
          widget=foundWid[0];
        }
        if(widget!=null){
          String widgetType="";
          try{
            widgetType=widget.getType();
            if(widgetType.isNotEmpty){
              widget.setValue(value['value']);
            }
          }catch(e){
            CustomAlert().cupertinoAlert("Error HE001 $e");
          }
          //print("widgetType $widgetType $value");
        }
      }
    }
  }


  var parsedJson;
  List<dynamic> valueArray=[];
  parseJson(List<Widget> widgets,String pageIdentifier,{String? dataJson}) async{
    if(MyConstants.fromUrl){
      await getUIFromDb(widgets,pageIdentifier, dataJson);
    }
    else{
      String data = await DefaultAssetBundle.of(Get.context!).loadString(pageIdentifier);
      parsedJson=jsonDecode(data);
      if(parsedJson.containsKey('valueArray')){
        valueArray=parsedJson['valueArray'];
      }
      if(valueArray.isNotEmpty){
        setFrmValues(widgets, valueArray);
      }
      //print(valueArray);
    }
  }

  Future<void> getUIFromDb(List<Widget> widgets,String pageIdentifier,String? dataJson) async{
    await GetUiNotifier().getUiJson(pageIdentifier,await getLoginId(),true,dataJson: dataJson).then((value){
      print("----getUIFromDb-----");
      print(value);
      if(value!="null"){
        var parsed=jsonDecode(value);
        parsedJson=jsonDecode(parsed['Table'][0]['PageJson']);
        if(parsedJson.containsKey('valueArray')){
          valueArray=parsedJson['valueArray'];
        }

        if(valueArray.isNotEmpty){
          setFrmValues(widgets, valueArray);
        }
      }
    });
  }

  Future<void> postUIJson(String pageIdentifier,String dataJson,String action,{VoidCallback? successCallback}) async{
    await GetUiNotifier().postUiJson(await getLoginId(), pageIdentifier, dataJson, {"actionType":action}).then((value){
      //print("----- post    $value");
      if(value[0]){
        if(successCallback!=null){
          successCallback();
        }
      }
      else{
        CustomAlert().cupertinoAlert(value[1]);
      }
    });
  }
}

abstract class HappyExtensionHelperCallback{
  void assignWidgets() async{}
}