import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/view/common/drawer/app_drawer_builder.dart';
import 'package:widgets/card_with_avatar/src/builder.dart';
import 'package:widgets/widgets.dart';

import '../currency/currency_detail_screen.dart';

//import 'package:mymoneyorganizer/app/view/common/widget/card_with_avatar.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/home';

  const DashBoard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DashBoard> {
  Color cl = Colors.red;
  bool visibleCheckBox = false;
  String? dat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerBuilder.buildAppDrawer(),
      appBar: AppBar(),
      /*body: Center(
        child: ExCircleAvatar<String>(
          avatarChild: (val) => Text(val),
          initialData: 'qq',
          data: dat ?? 'qq',
          avatarSetting: ExAvatarSetting(
              avatarSize: Size(90, 90), elevation: 4, backgroundColor: cl, shadowOnContent: false, canvasColor: Colors.grey.shade50),
          onTap: () => setState(() {
            dat = 'USD';
            visibleCheckBox = !visibleCheckBox;
            cl = Colors.blueAccent;
          }),
          visibleAdditionalControl: visibleCheckBox,
        ),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AvatarCardBuilder(
              child: Container(
                color: Colors.purpleAccent,
              ),
              avatar: CircleAvatar(),
              buttonLocation: ButtonLocation.centerDocked,
              elevation: 16,
              avatarOffset: EdgeInsets.all(42),
              avatarLocation: AvatarLocation.topLeft,
              actionButton: FloatingActionButton(
                onPressed: () => _testButton(),
                child: Text('T'),
                //backgroundColor: Colors.red,
              ),
            ), /*CardWithAvatar(
              //backgroundColor: Colors.purpleAccent,
              elevation: 8,
              avatarLocation: AvatarLocation.bottomLeft,
              rRound: 2,
              //avatarPadding: EdgeInsets.only(left: 0),
              actionButton: FloatingActionButton(
                onPressed: () => null,
              ),
            ),*/
          ),
        ),
        /*child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: SizedBox(
                height: 350,
                width: 750,
                child: Card(
                  child: Text('qqq'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: SizedBox(
                width: 90,
                height: 90,
                child: ExCircleAvatar<String>(
                  avatarChild: (val) => Text(val),
                  initialData: 'qq',
                  data: dat ?? 'qq',
                  avatarSetting: ExAvatarSetting(
                      avatarSize: Size(double.maxFinite, double.maxFinite),
                      elevation: 0,
                      backgroundColor: cl,
                      shadowOnContent: true,
                      canvasColor: Colors.grey.shade50),
                  onTap: () => setState(() {
                    dat = 'USD';
                    visibleCheckBox = !visibleCheckBox;
                    cl = Colors.blueAccent;
                  }),
                  visibleAdditionalControl: visibleCheckBox,
                ),
              ),
            ),
          ],
        ),*/
      ),
    );
  }

  void _testButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
  }
}
