import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/view/common/drawer/app_drawer_builder.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/home';

  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerBuilder.buildAppDrawer(),
      appBar: AppBar(),
      body: Center(
        child: Text('dashboard'),
      ),
    );
  }
}
