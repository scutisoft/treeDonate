import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/utils/utils.dart';

import '../../HappyExtension/utils.dart';

class HE_ListViewBody extends StatelessWidget {
  List<dynamic> data;
  Function(Map) getWidget;
  HE_ListViewBody({Key? key,required this.data,required this.getWidget}) : super(key: key){
    //assignWidget(data);
  }

  RxList<dynamic> widgetList=RxList<dynamic>();

  void assignWidget(dataParam){
    data=dataParam;
    int i=0;
    for (var element in dataParam) {
      widgetList.add(getWidget(element));
      i++;
    }
  }

  void updateArrById(primaryKey,updatedMap,{ActionType action=ActionType.update}){
    if(action==ActionType.update){
      /*int index=data.indexWhere((element) => element[primaryKey].toString()==updatedMap[primaryKey].toString());
      if(index!=-1){
        data[index]=updatedMap;
        console("Data Found");
      }*/

      /*int widgetIndex=widgetList.indexWhere((element) => element.dataListener[primaryKey].toString()==updatedMap[primaryKey].toString());
      if(widgetIndex!=-1){
        console("Widget Found");
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for(int i=0;i<widgetList.length;i++)
                widgetList[i]
            ],
          ),
        )
       /* ListView.builder(
          itemCount: widgetList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx,i){
            console("hi2 $i");
            return widgetList[i];
          },
        )*/
    );
  }
}

abstract class HE_ListViewContentExtension{
  updateDataListener(Map data);
}

class HE_ListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  Map data;
  HE_ListViewContent({Key? key,required this.data}) : super(key: key){
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
    dataListener.value=data;
  }
}
