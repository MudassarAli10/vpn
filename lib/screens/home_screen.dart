import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vpn_basic_project/Controllers/home_controller.dart';
import 'package:vpn_basic_project/Widgets/count_down_timer.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/network_screen.dart';

import '../Helpers/pref.dart';
import '../Widgets/home_card.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import 'location_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(
          CupertinoIcons.home,
          color: Colors.white,
        ),
        title: Text(
          'Enque VPN ',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                Pref.isDarkMode = !Pref.isDarkMode;
              },
              icon: Icon(
                Icons.brightness_6_sharp,
                color: Colors.white,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
                onPressed: () => Get.to(() => NetworkTestScreen()),
                icon: Icon(
                  CupertinoIcons.info,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      //Bottom Navigation To Move  Country List
      bottomNavigationBar: _countryList(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //VPN Button
          Obx(() => _vpnButton()),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  onTap: () => Get.to(() => LocationScreen()),
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? 'Country'
                      : _controller.vpn.value.countryLong,
                  subtitle: 'COUNTRY',
                  icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(Icons.vpn_lock_rounded,
                              size: 30, color: Colors.white)
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png')),
                ),
                HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? '100 ms'
                      : '${_controller.vpn.value.ping} ms',
                  subtitle: 'PING',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.equalizer,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),

          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: "${snapshot.data?.byteIn ?? "0 kbps"}",
                  subtitle: 'DOWNLOAD',
                  icon: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    child: Icon(
                      color: Colors.white,
                      Icons.arrow_downward_rounded,
                      size: 30,
                    ),
                  ),
                ),
                HomeCard(
                  title: "${snapshot.data?.byteOut ?? "0 kbps"}",
                  subtitle: 'UPLOAD',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //VPN Button
  Widget _vpnButton() => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
                // _controller.startTimer.value = !_controller.startTimer.value;
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _controller.getButtonColor.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _controller.getButtonColor.withOpacity(.3),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                      color: _controller.getButtonColor,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: mq.height * .015,
              bottom: mq.height * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Disconnect'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
          ),
          //Count Down Timer
          Obx(() => CountDownTimer(
                startTimer:
                    _controller.vpnState.value == VpnEngine.vpnConnected,
              )),
        ],
      );

  //Bottom Navigation To  Move the Country List
  Widget _countryList(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
              color: Theme.of(context).bottomNav,
              height: 60,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.globe,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Change Location',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
