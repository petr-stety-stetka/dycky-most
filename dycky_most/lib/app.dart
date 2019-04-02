import 'package:dycky_most/Screens/Peoples.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  static const title = 'Dycky Most!';

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App>  {
  @override
  Widget build(BuildContext context) {
    return PeoplesScreen(0);
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-6444168087211762~3440254009');

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>['3027FD057D30E990839B715229A1FE0A'], // Android emulators are considered test devices
    );

    BannerAd myBanner = BannerAd(
      adUnitId: 'ca-app-pub-6444168087211762/5108558898',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo
    );

    myBanner
      ..load()
      ..show(
        anchorOffset: 0,
        anchorType: AnchorType.bottom,
      );
  }
}