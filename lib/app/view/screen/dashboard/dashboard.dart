import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/view/common/drawer/app_drawer_builder.dart';
import 'package:mymoneyorganizer/app/view/common/widget/circle_avatar.dart';

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
      body: Center(
        child: ExCircleAvatar<String>(
          avatarChild: (val) => Text(val),
          initialData: 'qq',
          data: dat ?? 'qq',
          avatarSetting: ExAvatarSetting(
              avatarSize: Size(90, 90), elevation: 4, backgroundColor: cl, shadowOnContent: true, canvasColor: Colors.grey.shade50),
          onTap: () => setState(() {
            dat = 'USD';
            visibleCheckBox = !visibleCheckBox;
            cl = Colors.blueAccent;
          }),
          visibleAdditionalControl: visibleCheckBox,
        ),
      ),
    );
  }
}
