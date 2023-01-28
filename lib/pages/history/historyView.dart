import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/history/historyPage.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/timeLine/connectors.dart';
import '../../widgets/timeLine/indicators.dart';
import '../../widgets/timeLine/timeline_tile_builder.dart';
import '../../widgets/timeLine/timelines.dart';

class HistoryTreeView extends StatefulWidget {
  VoidCallback voidCallback;
  HistoryTreeView({required this.voidCallback});

  @override
  _HistoryTreeViewState createState() => _HistoryTreeViewState();
}

class _HistoryTreeViewState extends State<HistoryTreeView> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

  List<Widget> widgets=[];
  ScrollController? silverController;
  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }
  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                        backgroundColor: Color(0XFFF3F3F3),
                        expandedHeight: 180.0,
                        floating: true,
                        snap: false,
                        pinned: true,
                        leading: GestureDetector(
                          onTap: (){
                            widget.voidCallback();
                          },
                            child: Icon(Icons.arrow_back_ios_new_sharp,color: ColorUtil.themeBlack,size: 25,)
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1.8,
                          title: Text('My Certificate History',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                          background: Image.asset('assets/Slice/history-bg.png',fit:BoxFit.cover),
                        ),
                      ),
              ];
            },
            body:Container(
                height: SizeConfig.screenHeight,
                child: Timeline.tileBuilder(
                  builder: TimelineTileBuilder.connected(
                    contentsAlign: ContentsAlign.basic,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: GestureDetector(
                          onTap: (){
                           fadeRoute(HistoryPage());
                          },
                          child: Text('Timeline Event $index')
                      ),
                    ),
                    oppositeContentsBuilder:(context, index) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(' Event $index'),
                    ) ,
                    // indicatorStyle: IndicatorStyle.dot,
                    indicatorBuilder: (_, index) {
                      var color;
                      var child;
                      if(index%2==0){
                        child= Positioned(
                          right:2,
                          child: DotIndicator(
                            size: 15.0,
                            color: Colors.transparent,
                            child: Image.asset("assets/Slice/history-leaf.png"),
                          ),
                        );
                      }
                      else{
                        child= Positioned(
                          left:2,
                          child: DotIndicator(
                            size: 15.0,
                            color: Colors.transparent,
                            child: Transform.scale(
                              scaleX: -1,
                              child: Image.asset("assets/Slice/history-leaf.png"),
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 35,
                        width: 30,
                        //  color: ColorUtil.primary,
                        child: Stack(
                          children: [
                            Align(
                              alignment:Alignment.center,
                              child: Container(
                                height: 35,
                                width: 2,
                                color: ColorUtil.primary,
                              ),
                            ),
                            child,
                          ],
                        ),
                      );
                    },
                    connectorBuilder: (_, index, type) {
                      return SizedBox(
                        height: 35.0,
                        child: DecoratedLineConnector(
                          decoration: BoxDecoration(
                              color: ColorUtil.primary
                          ),
                        ),
                      );
                    },
                    itemCount: 20,
                  ),
               ),
            ),
          ),
        )
      );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    setState(() {});
    await parseJson(widgets, General.donateIdentifier);
  }
}
