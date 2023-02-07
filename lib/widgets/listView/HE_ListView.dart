import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HE_ListViewBody extends StatelessWidget {
  List<dynamic> data;
  Widget widget;
  HE_ListViewBody({Key? key,required this.data,required this.widget}) : super(key: key){
    assignWidget();
  }

  RxList<dynamic> widgetList=RxList<dynamic>();

  void assignWidget(){
    int i=0;
    for (var element in data) {
      widgetList.add(widget);
      widgetList[i].updateData(element);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: widgetList.length,
      shrinkWrap: true,
      itemBuilder: (ctx,i){
        return widget;
      },
    ));
  }
}

abstract class HE_ListViewContentExtension{
  updateData(Map data);
}

class HE_ListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  Map data;
  Widget widget;
  HE_ListViewContent({Key? key,required this.widget,required this.data}) : super(key: key){
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
  updateData(Map data) {
    dataListener.value=data;
  }
}
