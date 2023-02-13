import 'package:treedonate/HappyExtension/utils.dart';
import 'package:treedonate/utils/utils.dart';

import '../utils/constants.dart';
import '../widgets/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../api/apiUtils.dart';
import '../model/parameterMode.dart';
import '../notifier/getUiNotifier.dart';
import '../widgets/listView/HE_ListView.dart';
abstract class ExtensionCallback {
  String getType();
  getValue();
  setValue(var value);
  bool validate();
  String getDataName();
  void clearValues();
  int getOrderBy();
  setOrderBy(int oBy);
}

mixin HappyExtensionHelper implements HappyExtensionHelperCallback2{
  Future<List<ParameterModel>> getFrmCollection(List widgets) async{

    List<bool> validateList=[];
    List<ParameterModel> parameterList=[];
    bool validate=false;
    for (var widget in widgets) {
      String elementType="";
      try{
        elementType=widget.getType();
      }catch(e){}

      if(elementType=='inputTextField'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='searchDrp' || elementType=='searchDrp2'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='hidden'){
        if(widget.hasInput??false){
          parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
        }
      }
      if(elementType=='locationPicker'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='multiImage' || elementType=='singleImagePicker'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: await widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: await widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
    }
    bool isValid=!validateList.any((element) => element==false);
    console("valid ${isValid}");
    return isValid?parameterList:[];
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

  setFrmValues(List widgets,List valueArray,{bool fromClearAll=false}){
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
              if(fromClearAll){
                widget.clearValues();
              }
              widget.setValue(value['value']);
              widget.setOrderBy(value['orderBy']??1);
            }
          }catch(e){
            CustomAlert().cupertinoAlert("${widget.getDataName()} Error HE001 \n $e");
          }
          //print("widgetType $widgetType $value");
        }
      }
    }
  }


  var parsedJson;
  List<dynamic> valueArray=[];
  parseJson(List<dynamic> widgets,String pageIdentifier,{String? dataJson}) async{
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

  Future<void> getUIFromDb(List<dynamic> widgets,String pageIdentifier,String? dataJson) async{
    await GetUiNotifier().getUiJson(pageIdentifier,await getLoginId(),true,dataJson: dataJson).then((value){
      print("----getUIFromDb-----");
      console(value);
      if(value!="null" && value.toString().isNotEmpty){
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

  Future<void> postUIJson(String pageIdentifier,String dataJson,String action,{Function? successCallback}) async{
    //"N'$dataJson'"
    await GetUiNotifier().postUiJson(await getLoginId(), pageIdentifier, dataJson, {"actionType":action}).then((value){
      //print("----- post    $value");
      if(value[0]){
       // console(value);
        var parsed=jsonDecode(value[1]);
        String errorMsg=parsed["TblOutPut"][0]["@Message"]??"";
        if(successCallback!=null){
          successCallback(parsed);
        }
        else{
          addNotifications(NotificationType.success,msg: errorMsg);
          //CustomAlert().successAlert(errorMsg, "");
        }
      }
      else{
        CustomAlert().cupertinoAlert(value[1]);
      }
    });
  }

  void sysSubmit(List<dynamic> widgets,{
    Function? successCallback,
    String action="",
    bool isEdit=false,
    bool needCustomValidation=false,
    Function? onCustomValidation,
    bool clearFrm=true,
    bool closeFrmOnSubmit=true
  }) async{

    bool isValid=true;
    if(needCustomValidation){
      isValid=onCustomValidation!();
    }
    List<ParameterModel> params= await getFrmCollection(widgets);
    if(params.isNotEmpty && isValid){
      if(isValid){
        try{
          params.sort((a,b)=>a.orderBy.compareTo(b.orderBy));
        }catch(e){
          CustomAlert().cupertinoAlert("Error HE002 $e");
        }
        postUIJson(getPageIdentifier(),
            jsonEncode(params.map((e) => e.toJsonHE()).toList()),
            action.isNotEmpty?action: isEdit?"Update":"Insert",
            successCallback: (e){
              String errorMsg=e["TblOutPut"][0]["@Message"]??"";
              if(closeFrmOnSubmit){
                Get.back();
              }
              addNotifications(NotificationType.success,msg: errorMsg);
              //CustomAlert().successAlert(errorMsg, "");
              if(clearFrm){
                clearAll(widgets);
              }
              if(successCallback!=null && e['Table']!=null && e['Table'].length>0){
                successCallback(e);
              }
            }
        );
      }
    }

  }

  void sysDelete(arr,primaryKey,primaryArr,{Function? successCallback,String dataJson="",String content="Are you sure want to delete ?",}){
    CustomAlert(
        callback: (){
          postUIJson(getPageIdentifier(),
              dataJson,
              "Delete",
              successCallback: (e){
                String errorMsg=e["TblOutPut"][0]["@Message"];
                addNotifications(NotificationType.success,msg: errorMsg);
                //CustomAlert().successAlert(errorMsg, "");
                if(successCallback!=null){
                  successCallback(e);
                }
                updateArrById(primaryKey, e["Table"][0], arr,action: ActionType.deleteById,primaryArr:primaryArr );
              }
          );
        },
        cancelCallback: (){

        }
    ).yesOrNoDialog2('assets/Slice/like.png', content, false);
  }

  void sysDeleteHE_ListView(HE_ListViewBody he_listViewBody,String primaryKey,{Function? successCallback,String dataJson="",String content="Are you sure want to delete ?",}){
    CustomAlert(
        callback: (){
          postUIJson(getPageIdentifier(),
              dataJson,
              "Delete",
              successCallback: (e){
                String errorMsg=e["TblOutPut"][0]["@Message"];
                addNotifications(NotificationType.success,msg: errorMsg);
                //CustomAlert().successAlert(errorMsg, "");
                if(successCallback!=null){
                  successCallback(e);
                }
                he_listViewBody.updateArrById(primaryKey, e["Table"][0],action: ActionType.deleteById);
                //updateArrById(primaryKey, e["Table"][0], arr,action: ActionType.deleteById,primaryArr:primaryArr );
              }
          );
        },
        cancelCallback: (){

        }
    ).yesOrNoDialog2('assets/Slice/like.png', content, false);
  }

  fillTreeDrp(List<dynamic> widgets,String key,{var refId,var page,bool clearValues=true,var refType,bool toggleRequired=false}) async{
    var fWid=foundWidgetByKey(widgets, key);
    if(fWid!=null){
      if(clearValues){
        fWid.clearValues();
      }
      getMasterDrp(page, key, refId, refType,null).then((value){
        //console("$key    ${value.runtimeType}");
        fWid.setValue(value);
        if(toggleRequired){
          fWid.required=value.isNotEmpty;
          try{
            fWid.isValid.value=true;
          }catch(e){assignWidgetErrorToast("IsValid",e);}
        }
      });
    }
  }

  foundWidgetByKey(List<dynamic> widgets,String key,{bool needSetValue=false,dynamic value}){
    for (var widget in widgets) {
      if(widget.getDataName()==key){
        if(needSetValue){
          widget.setValue(value);
        }
        return widget;
      }
    }
    return null;
  }

  void clearAll(List<dynamic> widgets){
    setFrmValues(widgets, valueArray,fromClearAll: true);
  }

  void updateEnable(List<dynamic> widgets,key,{bool isEnabled=false}){
    var fWid=foundWidgetByKey(widgets, key);
    if(fWid!=null){
      fWid.isEnabled=isEnabled;
      fWid.reload.value=!fWid.reload.value;
      if(!isEnabled){
        fWid.clearValues();
      }
    }
  }

  @override
  String getPageIdentifier(){
    return "";
  }
}

abstract class HappyExtensionHelperCallback{
  void assignWidgets() async{}
}

abstract class HappyExtensionHelperCallback2{
  String getPageIdentifier();
}