import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultAppDrawer extends StatelessWidget {
  const DefaultAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Column(
        children: [
          /*UserAccountsDrawerHeader(
            accountName: Text('accountName'),
            accountEmail: Text('accountEmail'),
            currentAccountPicture: CircleAvatar(
              child: Text('CU'),
            ),
          ),*/
          _buildHeader(),
          Expanded(
            /*child: Column(
              children: [
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                Text('111111'),
                Text('22222'),
              ],
            ),*/
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Divider(
                  indent: 48,
                  endIndent: 48,
                  thickness: 3,
                ),
                Row(
                  children: [
                    Divider(
                      indent: 0,
                      endIndent: 16,
                      thickness: 5,
                    ),
                    /*Text('Entities'),
                    Divider(),*/
                  ],
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                Divider(),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  child: Text('button'),
                ),
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
        decoration: BoxDecoration(color: Colors.amber),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              height: 24,
              child: Text("Flutter Step-by-Step", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500))),
        ]));
  }
}
