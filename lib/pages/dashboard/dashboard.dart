import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';


class Dashboard extends StatefulWidget {
  VoidCallback voidCallback;
  Dashboard({required this.voidCallback});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> District=[
    {"Districtname":"Chennai","Hectares":10.00,},
    {"Districtname":"Erode","Hectares":20.00,},
    {"Districtname":"Salem","Hectares":30.00,},
    {"Districtname":"Theni","Hectares":40.00,},
    {"Districtname":"Trichy","Hectares":50.00,},
    {"Districtname":"Thenkasi","Hectares":60.00,},
    {"Districtname":"thiruvallur","Hectares":70.00,},
    {"Districtname":"Maduarai","Hectares":80.00,},
    {"Districtname":"Vellore","Hectares":90.00,},
    {"Districtname":"Villupuram","Hectares":10.00,},
    {"Districtname":"Coimbatore","Hectares":100.00,},
    {"Districtname":"Permabalur","Hectares":550.00,},
  ];
  List<dynamic> Zone=[
    {"Zonename":"Zone 1","Hectare":10.00,},
    {"Zonename":"Zone 2","Hectare":20.00,},
    {"Zonename":"Zone 3","Hectare":30.00,},
    {"Zonename":"Zone 4","Hectare":40.00,},
    {"Zonename":"Zone 5","Hectare":50.00,},
  ];
  List<Widget> widgets=[];
  bool isWaveView=true;
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();
  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }
  List<dynamic> NurseryList=[];
  var node;

  double cardWidth=0.0;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  floating: true,
                  snap: true,
                  pinned: true,
                  leading: GestureDetector(
                      onTap: (){
                        widget.voidCallback();
                      },
                      child: Icon(Icons.arrow_back_ios_new_sharp,color: ColorUtil.themeBlack,size: 25,)
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.8,
                    title: Text('Dashboard',style: TextStyle(color:ColorUtil.themeBlack,fontFamily: 'RB',fontSize: 18,),textAlign: TextAlign.left,),
                    background: Image.asset('assets/Slice/left-align.png',fit:BoxFit.fill),
                  ),
                ),
              ];
            },
            body:Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.only(left: 10,right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      height: SizeConfig.screenHeight,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                            child: Text('Eco Green Foundation Dashboard',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xff000000)),),
                          ),
                          SizedBox(height: 5,),
                          Wrap(
                            spacing: 0,
                            runSpacing: 8,
                            alignment: WrapAlignment.spaceAround,
                            ///runAlignment: WrapAlignment.center,
                            //crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth!*0.45,
                                height: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: .0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width:50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFF2F2F2),
                                              shape:BoxShape.circle
                                          ),
                                          child: Image.asset('assets/Slice/DefaultVolunteer.png',height: 30,),
                                        ),
                                        SizedBox(width: 5,),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(color: Colors.black, fontSize: 36),
                                            children: <TextSpan>[
                                              TextSpan(text: 'Target ',  style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                              TextSpan(text: '3 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                              TextSpan(text: 'Lac', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),)
                                            ],
                                          ),
                                          // textScaleFactor: 0.5,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Volunteer',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                      TextSpan(
                                        text: '21', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                        children: [
                                          TextSpan(text: '/ Persons ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth!*0.45,
                                height: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: .0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width:50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFf8cba2),
                                              shape:BoxShape.circle
                                          ),
                                          child: Image.asset('assets/trees/planting.png',height: 30,),
                                        ),
                                        SizedBox(width: 5,),
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 36),
                                              children: <TextSpan>[
                                                TextSpan(text: 'Target ',  style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                                TextSpan(text: '6 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                                TextSpan(text: 'Lac Hectare', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),)
                                              ],
                                            ),
                                            // textScaleFactor: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Land Parcel',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                      TextSpan(
                                        text: '122.53', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                        children: [
                                          TextSpan(text: '/ Hectares ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth!*0.45,
                                padding: EdgeInsets.all(10),
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: .0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width:50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFf8cba2),
                                              shape:BoxShape.circle
                                          ),
                                          child: Image.asset('assets/trees/Seeds.png',height: 30,),
                                        ),
                                        SizedBox(width: 5,),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(color: Colors.black, fontSize: 36),
                                            children: <TextSpan>[
                                              TextSpan(text: 'Target ',  style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                              TextSpan(text: '500 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                              TextSpan(text: 'Cr', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),)
                                            ],
                                          ),
                                          // textScaleFactor: 0.5,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Seeds Stock',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                      TextSpan(
                                        text: '186', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                        children: [
                                          TextSpan(text: '/ Numbers ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth!*0.45,
                                height: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: .0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width:50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFf8cba2),
                                              shape:BoxShape.circle
                                          ),
                                          child: Image.asset('assets/trees/Seeds.png',height: 30,),
                                        ),
                                        SizedBox(width:5 ,),
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(text: 'Target ',  style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                              TextSpan(text: '300 ' ,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                            ],
                                          ),
                                          // textScaleFactor: 0.5,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Nursery',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                      TextSpan(
                                        text: '12', style: TextStyle(color: ColorUtil.themeBlack, fontSize: 20,fontFamily: 'RB'),
                                        children: [
                                          TextSpan(text: ' Nursery ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),)
                                        ],
                                      ),
                                    ),
                                    Text('6730 Nursery Plants ',  style: TextStyle(fontFamily: 'RR',fontSize: 13,color: Color(0xff000000)),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 370,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0, // soften the shadow
                                  spreadRadius: .0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(left: 10,right: 10, top: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('assets/trees/plant.png',height: 50,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Land Parcel ',  style: TextStyle(fontFamily: 'RR',fontSize: 13,color: Color(0xff000000)),),
                                        Text('122.53 Hectares',  style: TextStyle(fontFamily: 'RM',fontSize: 13,color: Color(0xff000000)),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                isWaveView=true;
                                              });
                                            },
                                            //child: Icon(Icons.bar_chart, color:! isWaveView? Colors.black45:Color(0xffFF0022),size: 30)
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: !isWaveView?BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all(color: ColorUtil.primary),
                                              color: ColorUtil.primary.withOpacity(0.2)
                                            ):BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                                border: Border.all(color: ColorUtil.primary),
                                                color: ColorUtil.primary
                                            ),
                                            child:Text('Zone',  style: TextStyle(fontFamily: 'RR',fontSize: 13,color:! isWaveView? ColorUtil.primary:ColorUtil.themeWhite),),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                isWaveView=false;
                                              });
                                            },
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: isWaveView?BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                border: Border.all(color: ColorUtil.primary),
                                                color: ColorUtil.primary.withOpacity(0.2)
                                            ):BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                border: Border.all(color: ColorUtil.primary),
                                                color: ColorUtil.primary
                                            ),
                                            child:Text('District',  style: TextStyle(fontFamily: 'RR',fontSize: 13,color:isWaveView? ColorUtil.primary:ColorUtil.themeWhite),),
                                          ),
                                           // child: Icon(Icons.auto_graph, color: isWaveView? Colors.black45:Color(0xffFF0022),size: 30,)
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                AnimatedCrossFade(
                                    firstChild: BarZone(),
                                    secondChild: BarDistrict(),
                                    crossFadeState: isWaveView?CrossFadeState.showSecond:CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 400)
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: 300,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 15,right: 15,top:15,bottom: 15),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0, // soften the shadow
                                  spreadRadius: .0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Upcoming Nursery & Plants',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xff000000)),),
                                        SizedBox(height: 1,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('300 Nursery /',style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xff000000)),),
                                            Container(
                                                margin:EdgeInsets.only(top:5),
                                                child: Text(' 2 Cr Plants',style: TextStyle(fontFamily: 'RR',fontSize: 13,color: Color(0xff000000)),)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        //color: ColorUtil.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset('assets/trees/filter.png',height: 25,),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Container(
                                //      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                //       alignment: Alignment.center,
                                //       decoration: BoxDecoration(
                                //         color: Color(0xffAC6839),
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Row(
                                //         children: [
                                //           Icon(Icons.arrow_drop_up_outlined,color: ColorUtil.themeWhite,)
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 10,),
                                Flexible(
                                  // height: SizeConfig.screenHeight,
                                  // width: cardWidth,
                                  child: ListView.builder(
                                    itemCount: 10,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (ctx,i){
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: ColorUtil.red.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Image.asset('assets/trees/plant.png',height: 30,),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('100 Nursery',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xff000000)),),
                                                SizedBox(height: 1,),
                                                Text(' 1 Month Later',style: TextStyle(fontFamily: 'RR',fontSize: 13,color: Color(0xff000000).withOpacity(0.4)),)
                                              ],
                                            ),
                                            Text('50,000.00',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xff000000)),),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{

    setState(() {});
    await parseJson(widgets, General.NurseryGridIdentifier);
    try{

      NurseryList=valueArray.where((element) => element['key']=="NurserydataList").toList()[0]['value'];
      setState((){});

    }catch(e){
    }
  }
  Widget BarZone(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: 200,
          padding: EdgeInsets.only(left: 5,right: 5),
          child: FutureBuilder<dynamic>(
            future: Future.value(District),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if( snapshot.connectionState == ConnectionState.waiting){
                return Container();
                // return  Center(child: Text('Please wait its loading...'));
              }
              else{
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}',));
                else
                  return  SfCartesianChart(
                    legend: Legend(isVisible: false, opacity: 0.7),
                    title: ChartTitle(text: ''),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      isVisible: true,
                      interval: 1,
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                          color: Colors.transparent
                      ),
                      //  minorGridLines: const MinorGridLines(width: 1,color: Colors.white),
                      axisLine:const AxisLine(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.none,
                      labelPlacement:LabelPlacement.betweenTicks,

                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: true,
                      //numberFormat: formattedNumber,
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                          color: Colors.transparent
                      ),
                      //   labelStyle: TextStyle(color: AppTheme.yAxisText)
                    ),
                    series:[
                      ColumnSeries<dynamic, String>(
                        animationDuration:2000,
                        onRendererCreated: (ChartSeriesController c){

                        },
                        markerSettings: MarkerSettings(
                          //  isVisible:currentSaleData.length==1? true:false,
                          color: ColorUtil.primary,
                          isVisible: false,
                        ),
                        dataSource: District,
                        // borderColor: th.dashRedColor,
                        borderWidth: 3,
                        color: ColorUtil.primary,
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Color(0xFF1A1E24).withOpacity(1),
                        //     Color(0xFF21252B).withOpacity(0.3),
                        //
                        //   ],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   //  stops: [0,30]
                        // ),
                        width: 0.5,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7)),
                        name: 'District',
                        xValueMapper: (dynamic sales, _) =>sales['Districtname'],
                        yValueMapper: (dynamic sales, _) => sales['Hectares'],
                        selectionBehavior: SelectionBehavior(
                          enable: true,
                          selectedColor: ColorUtil.primary,
                          unselectedColor: ColorUtil.primary,

                        ),
                        //initialSelectedDataIndexes:<int>[ rn.paymentTypeData.indexWhere((element) => element['Amount']==rn.paymentTypeData2.last['Amount']).toInt()],
                        //initialSelectedDataIndexes:<int>[ paymentTypeData.length-1],
                      ),
                    ],
                    tooltipBehavior: TooltipBehavior(

                        enable: true,
                        duration: 2000,
                        //   format: "point.y",
                        color: ColorUtil.primary,
                        header: "",
                        textStyle:TextStyle(color: Colors.white,fontSize: 14),
                        canShowMarker: false,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: Text('${formatCurrency.format(data['Hectares'])}',
                                style: TextStyle(color: Colors.white,fontSize: 14),
                              )
                          );
                        }

                    ),
                  );
              }
            },

          ),
        ),
      ],
    );
  }
 Widget  BarDistrict(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: 200,
          padding: EdgeInsets.only(left: 5,right: 5),
          child: FutureBuilder<dynamic>(
            future: Future.value(Zone),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if( snapshot.connectionState == ConnectionState.waiting){
                return Container();
                // return  Center(child: Text('Please wait its loading...'));
              }
              else{
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}',));
                else
                  return  SfCartesianChart(
                    legend: Legend(isVisible: false, opacity: 0.7),
                    title: ChartTitle(text: ''),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      isVisible: true,
                      interval: 1,
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                          color: Colors.transparent
                      ),
                      //  minorGridLines: const MinorGridLines(width: 1,color: Colors.white),
                      axisLine:const AxisLine(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.none,
                      labelPlacement:LabelPlacement.betweenTicks,

                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: true,
                      //numberFormat: formattedNumber,
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                          color: Colors.transparent
                      ),
                      //   labelStyle: TextStyle(color: AppTheme.yAxisText)
                    ),
                    series:[
                      ColumnSeries<dynamic, String>(
                        animationDuration:2000,
                        onRendererCreated: (ChartSeriesController c){

                        },
                        markerSettings: MarkerSettings(
                          //  isVisible:currentSaleData.length==1? true:false,
                          color: ColorUtil.primary,
                          isVisible: false,
                        ),
                        dataSource: Zone,
                        // borderColor: th.dashRedColor,
                        borderWidth: 3,
                        color: ColorUtil.primary,
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Color(0xFF1A1E24).withOpacity(1),
                        //     Color(0xFF21252B).withOpacity(0.3),
                        //
                        //   ],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   //  stops: [0,30]
                        // ),
                        width: 0.5,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7)),
                        name: 'Zone',
                        xValueMapper: (dynamic sales, _) =>sales['Zonename'],
                        yValueMapper: (dynamic sales, _) => sales['Hectare'],
                        selectionBehavior: SelectionBehavior(
                          enable: true,
                          selectedColor: ColorUtil.primary,
                          unselectedColor: ColorUtil.primary,

                        ),
                        //initialSelectedDataIndexes:<int>[ rn.paymentTypeData.indexWhere((element) => element['Amount']==rn.paymentTypeData2.last['Amount']).toInt()],
                        //initialSelectedDataIndexes:<int>[ paymentTypeData.length-1],
                      ),
                    ],
                    tooltipBehavior: TooltipBehavior(

                        enable: true,
                        duration: 2000,
                        //   format: "point.y",
                        color: ColorUtil.primary,
                        header: "",
                        textStyle:TextStyle(color: Colors.white,fontSize: 14),
                        canShowMarker: false,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: Text('${formatCurrency.format(data['Hectare'])}',
                                style: TextStyle(color: Colors.white,fontSize: 14),
                              )
                          );
                        }

                    ),
                  );
              }
            },

          ),
        ),
      ],
    );
  }

}
