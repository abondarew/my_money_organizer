import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';
import 'package:mymoneyorganizer/app/routes/routes.dart';

class DefaultAppDrawer extends StatelessWidget {
  const DefaultAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  text: t('home').toTitleCase(),
                  icon: Icons.home,
                  onTap: () => Navigator.pushNamed(context, Routes.homePage),
                ),
                const Divider(),
                _buildDrawerItem(
                  text: t('currency.name').toTitleCase(),
                  icon: Icons.attach_money_rounded,
                  onTap: () => Navigator.pushNamed(context, Routes.currencyList),
                ),
                _buildDrawerItem(text: t('shared.account').toTitleCase(), onTap: () => {}),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildHeader() {
    return DrawerHeader(
      /*padding: EdgeInsets.zero,
      child: Text('test'),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.luminosity,
        color: Colors.amber,
      ),
    );*/
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Stack(
        children: const <Widget>[
          Positioned(
              //bottom: 12.0,
              top: 12.0,
              left: 16.0,
              height: 24,
              child: Text("Money organizer", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({IconData? icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: icon == null ? null : Icon(icon),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
