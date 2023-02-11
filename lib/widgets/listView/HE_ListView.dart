import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/utils/colorUtil.dart';
import 'package:treedonate/utils/utils.dart';

import '../../HappyExtension/utils.dart';

class HE_ListViewBody extends StatelessWidget {
  List<dynamic> data;
  Function(Map) getWidget;
  ScrollController? scrollController;
  HE_ListViewBody({Key? key,required this.data,required this.getWidget,this.scrollController}) : super(key: key){
    //assignWidget(data);
  }

  RxList<dynamic> widgetList=RxList<dynamic>();

  void assignWidget(dataParam,{bool updatePrimaryList=true,bool clearWidgets=true}){
    if(updatePrimaryList){
      data=dataParam;
    }
    if(clearWidgets) {
      widgetList.clear();
    }
   // int i=0;
    for (var element in dataParam) {
      widgetList.add(getWidget(element));
     // i++;
    }
  }

  void updateArrById(primaryKey,updatedMap,{ActionType action=ActionType.update}){
    if(action==ActionType.update){
      int index=data.indexWhere((element) => element[primaryKey].toString()==updatedMap[primaryKey].toString());
      if(index!=-1){
        updatedMap.forEach((key, value) {
          if(data[index].containsKey(key)){
            data[index][key]=value;
          }
        });
        console("Data Found");
      }

      /*int widgetIndex=widgetList.indexWhere((element) => element.dataListener[primaryKey].toString()==updatedMap[primaryKey].toString());
      if(widgetIndex!=-1){
        console("Widget Found");
      }*/
    }
    else if(action==ActionType.deleteById){
      data.removeWhere((element) => element[primaryKey].toString()==updatedMap[primaryKey].toString());
      widgetList.removeWhere((element) => element.dataListener[primaryKey].toString()==updatedMap[primaryKey].toString());
    }
  }

  void searchHandler(searchKey){
    if(searchKey==null || searchKey == ""){
      assignWidget(data);
    }
    else{
      assignWidget(data.where((element) => getValuesFromMap(element).contains(searchKey.toString().toLowerCase())).toList(growable: false),updatePrimaryList: false);
      //console("search ${data.length} ${widgetList.length}");
    }
  }

  void addData(dataMap){
    data.insert(0, dataMap);
    widgetList.insert(0, getWidget(dataMap));
  }

/*  ScrollController scrollController=ScrollController();*/

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true,
        radius:  const Radius.circular(ColorUtil.scrollBarRadius),
        thickness: 6,
        controller: scrollController,
        trackVisibility: true,
        interactive: true,
        child: Obx(() =>
    /*SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for(int i=0;i<widgetList.length;i++)
                widgetList[i]
            ],
          ),
        )*/
    ListView.builder(
      itemCount: widgetList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx,i){
        return widgetList[i];
      },
    )
    ));
  }
}

abstract class HE_ListViewContentExtension{
  updateDataListener(Map data);

}

class HE_ListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  HE_ListViewContent({Key? key,required this.data,this.onEdit,this.onDelete}) : super(key: key){
    dataListener.value=data;
  }
  var dataListener={}.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Container()
    );
  }

  @override
  updateDataListener(Map data) {
    data.forEach((key, value) {
      if(dataListener.containsKey(key)){
        dataListener[key]=value;
      }
    });
  }
}
