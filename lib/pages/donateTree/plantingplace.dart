import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treedonate/utils/utils.dart';
import '../../utils/sizeLocal.dart';

import '../../utils/colorUtil.dart';
import '../../widgets/searchDropdown/search2.dart';


class PlantingVillagePlace extends StatefulWidget {
  const PlantingVillagePlace({Key? key}) : super(key: key);
  @override
  _PlantingVillagePlaceState createState() => _PlantingVillagePlaceState();
}

class _PlantingVillagePlaceState extends State<PlantingVillagePlace> {
  Search2 bHFloorDrp=Search2(
    dataName: "BHFloorId",
    width: SizeConfig.screenWidth,
    dialogWidth: SizeConfig.screenWidth!,
    selectWidgetHeight: 50,
    hinttext: "Select Planting Place",
    data: [
      {"Id":1,"Text":"Govt Hospital"},
      {"Id":2,"Text":"Public Place"},
      {"Id":3,"Text":"Govt Quaters"},
      {"Id":4,"Text":"Govt School"},
      {"Id":5,"Text":"Govt College"},
    ],
    showSearch: false,
    onitemTap: (i){},
    selectedValueFunc: (e){},
    scrollTap: (){},
    isToJson: true,
    margin: EdgeInsets.only(left: 15,right: 15,top:25,bottom: 0),
    dialogMargin: EdgeInsets.only(left: 15,right: 15,top: 5),
    selectWidgetBoxDecoration: BoxDecoration(
        border: Border.all(color: Color(0xffEBEBEB)),
            color: ColorUtil.themeWhite
    ),
  );
//  late  double width,height,width2,height2;


  Search2V3 districtDrp=Search2V3(
    width: 100,
    dialogWidth: SizeConfig.screenWidth,
    dialogMargin: EdgeInsets.zero,
    dataName: "DistrictId",
    hinttext: "Select District",
    showSearch: true,
    onitemTap: (i){},
    selectedValueFunc: (e){

    },
    scrollTap: (){},
    isToJson: true,
    data: [],
  );
  Search2V3 talukDrp=Search2V3(
    width: 100,
    dialogWidth: SizeConfig.screenWidth,
    dialogMargin: EdgeInsets.zero,
    dataName: "TalukId",
    hinttext: "Select Taluk",
    showSearch: true,
    onitemTap: (i){},
    selectedValueFunc: (e){

    },
    scrollTap: (){},
    isToJson: true,
    data: [],
  );
  Search2V3 villageDrp=Search2V3(
    width: 100,
    dialogWidth: SizeConfig.screenWidth,
    dialogMargin: EdgeInsets.zero,
    dataName: "VillageId",
    hinttext: "Select Village",
    showSearch: true,
    onitemTap: (i){},
    selectedValueFunc: (e){

    },
    scrollTap: (){},
    isToJson: true,
    data: [],
  );

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.074737, 80.267689),
    zoom: 12.5,
  );

  Future<void> navigateMap(lat, lng,{double zoom=12.5}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(parseDouble(lat), parseDouble(lng)),
      zoom: zoom,
    )));
  }

/*  List locations = [];
  String googleMapsApi = 'AIzaSyCzxj6UFfx8uvDaaE9OSSPkjJXdou3jD9I';
  TextEditingController _latController = new TextEditingController();
  TextEditingController _lngController = new TextEditingController();
  int zoom = 4;


  var _controller = StaticMapController(
    googleApiKey: MyConstants.mapApiKey,
    width: 400,
    height: 400,
    zoom: 10,
    center: Location(-3.1178833, -60.0029284),
  );
  late ImageProvider image;*/
  @override
  void initState(){
    districtDrp.setDataArray([{"Id":1,"Text":"CHENNAI","latitude":"13.074737","longitude":"80.267689"},{"Id":2,"Text":"THIRUVALLUR","latitude":"13.153773","longitude":"79.915219"},{"Id":3,"Text":"RANIPET"},{"Id":4,"Text":"VELLORE","latitude":"12.909641","longitude":"79.139241"},{"Id":5,"Text":"THIRUPATTUR"},{"Id":6,"Text":"TIRUVANNAMALAI"},{"Id":7,"Text":"KANCHIPURAM"},{"Id":8,"Text":"CHENGALPATTU"},{"Id":9,"Text":"CUDDALORE"},{"Id":10,"Text":"KALLAKURUCHI"},{"Id":11,"Text":"VILLUPURAM"},{"Id":12,"Text":"TRICHY"},{"Id":13,"Text":"PERAMBALUR"},{"Id":14,"Text":"ARIYALUR"},{"Id":15,"Text":"MAYILADUDURAI"},{"Id":16,"Text":"NAGAPATTINAM"},{"Id":17,"Text":"THIRUVARUR"},{"Id":18,"Text":"THANJAVUR"},{"Id":19,"Text":"PUDUKKOTTAI"},{"Id":20,"Text":"THENI"},{"Id":21,"Text":"MADURAI"},{"Id":22,"Text":"SIVAGANGAI"},{"Id":23,"Text":"RAMANATHAPURAM"},{"Id":24,"Text":"VIRUDHUNAGAR"},{"Id":25,"Text":"THENKASI"},{"Id":26,"Text":"THOOTHUKUDI"},{"Id":27,"Text":"TIRUNELVELI"},{"Id":28,"Text":"KANYAKUMARI"},{"Id":29,"Text":"COIMBATORE","latitude":"10.994743","longitude":"76.96688"},{"Id":30,"Text":"NILGIRIS"},{"Id":31,"Text":"TIRUPUR"},{"Id":32,"Text":"DINDUGAL"},{"Id":33,"Text":"KARUR"},{"Id":34,"Text":"ERODE"},{"Id":35,"Text":"NAMMAKAL"},{"Id":36,"Text":"SALEM"},{"Id":37,"Text":"DHARMAPURI"},{"Id":38,"Text":"KRISHNAGIRI"}]);
    talukDrp.setDataArray([{"Id":1,"Text":"Avadi","latitude":"13.10559996101265","longitude":"80.09788287501283"},{"Id":2,"Text":"Guindy","latitude":"13.006810698877896","longitude":"80.22108857891945"}]);
    villageDrp.setDataArray([{"Id":1,"Text":"Ekkatuthangal","latitude":"13.022356153260509","longitude":"80.20275605373816"},{"Id":2,"Text":"Guindy","latitude":"13.006810698877896","longitude":"80.22108857891945"}]);
    districtDrp.selectedValueFunc=(e){
      console(e);
      if(e['latitude']!=null){
        navigateMap(e['latitude'], e['longitude']);
      }
    };
    talukDrp.selectedValueFunc=(e){
      console(e);
      if(e['latitude']!=null){
        navigateMap(e['latitude'], e['longitude'],zoom: 15);
      }
    };
    villageDrp.selectedValueFunc=(e){
      console(e);
      if(e['latitude']!=null){
        navigateMap(e['latitude'], e['longitude'],zoom: 16);
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: SizeConfig.screenHeight,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                //Image.asset('assets/login/maps.png',fit:BoxFit.fill,width:SizeConfig.screenWidth,),
                //Image(image: image),
                //StaticMap(MyConstants.mapApiKey, locations: locations, zoom: zoom,),
                bHFloorDrp,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        districtDrp,
                        talukDrp,
                        villageDrp

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child:IconButton(
                      icon:Icon(Icons.cancel,color: Colors.red,size: 25,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text('Select Village',style: TextStyle(fontSize: 20,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 5,),
                Text('55 Village Available',style: TextStyle(fontSize: 13,color: ColorUtil.primary,fontFamily: 'RR'),),
                SizedBox(height: 20,),
                Text('Ariyalur',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Chennai',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Coimbatore',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Chennai',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                Text('Theni',style: TextStyle(fontSize: 18,color: ColorUtil.primary,fontFamily: 'RB'),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color:ColorUtil.primary,
                    ),
                    padding: EdgeInsets.only(right: 15,top: 10,bottom: 10,left:15),
                    child: Text('Done',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}