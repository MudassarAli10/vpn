import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/API/apis.dart';
import 'package:vpn_basic_project/Widgets/network_card.dart';
import 'package:vpn_basic_project/models/network_data.dart';

import '../main.dart';
import '../models/ip_details.dart';

class NetworkTestScreen extends StatelessWidget {
  const NetworkTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            ipData.value=IPDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
          },
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: Obx(()=> ListView(
          padding: EdgeInsets.only(
              left: mq.width * .04,
              right: mq.width * .04,
              top: mq.height * .01,
              bottom: mq.height * .1),
          children: [
            NetworkCard(
                data: NetworkData(
                    title: 'IP Address',
                    subtitle: ipData.value.query,
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.blue,
                      size: 28,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Internet Provider',
                    subtitle: ipData.value.isp,
                    icon: Icon(
                      Icons.business,
                      color: Colors.orange,
                      size: 28,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Location',
                    subtitle: ipData.value.country.isEmpty
                        ? 'Fetching...'
                        : '${ipData.value.city},${ipData.value.regionName},${ipData.value.country}',
                    icon: Icon(
                      CupertinoIcons.location,
                      color: Colors.pink,
                      size: 28,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Pin Code',
                    subtitle: ipData.value.zip,
                    icon: Icon(
                      Icons.pin,
                      color: Colors.teal,
                      size: 28,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Time Zone',
                    subtitle: ipData.value.timezone,
                    icon: Icon(
                      CupertinoIcons.time,
                      color: Colors.green,
                      size: 28,
                    ))),
          ],
        ),
      ),
    );
  }
}
