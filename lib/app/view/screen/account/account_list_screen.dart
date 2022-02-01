
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/view/common/app_bar/app_bar_builder.dart';
import 'package:mymoneyorganizer/app/view/common/drawer/app_drawer_builder.dart';

import 'account_details_screen.dart';

class AccountListScreen extends StatelessWidget {
  const AccountListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBarBuilder.buildAppBar(context: context),
        drawer: AppDrawerBuilder.buildAppDrawer(),
        floatingActionButton: FloatingActionButton(onPressed:() => _onFabPressed(context)),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  void _onFabPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailScreen()));
  }
}
