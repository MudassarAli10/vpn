import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/Controllers/location_controller.dart';

import '../Widgets/vpn_card.dart';
import '../main.dart';

class LocationScreen extends StatelessWidget {
  final _controller = LocationController();

   LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if(_controller.vpnList.isEmpty)
    _controller.getVpnData();
    return  Obx(
          () =>Scaffold(
          appBar: AppBar(
            title: Text('VPN Location (${_controller.vpnList.length })'),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom:10, right:10,),
            child: FloatingActionButton(onPressed: (){ _controller.getVpnData();},
              child:Icon(CupertinoIcons.refresh) ,),
          ),
          body: _controller.isLoading.value
                ? _loadingWidget()
                : _controller.vpnList.isEmpty
                    ? _noVpnFound()
                    : _vpnData(),
          ),
    );
  }

  _vpnData() => ListView.builder(
      itemCount:_controller.vpnList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: mq.height*.015,bottom: mq.height*.1,right: mq.width*.04,left:  mq.width*.04),
      itemBuilder: (context, index) =>
          VpnCard(vpn: _controller.vpnList[index]));

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          LottieBuilder.asset('assets/animations/loading.json'),
          Text(
            'Loading VPN.........',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
        ]),
      );

  _noVpnFound() => Center(
          child: Text(
        'Sorry NO VPN Found.........',
        style: TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ));
}
