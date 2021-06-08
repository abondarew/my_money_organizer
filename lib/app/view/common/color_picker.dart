import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorPicker {
  void showColorPicker(
      {required BuildContext context, required List<Color> colors, required ValueChanged<Color> onSelect, Color? currentColor}) {
    /*showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        context: context,
        builder: (_) => _builder(context: context, colors: colors, onSelect: onSelect, currentColor: currentColor));*/

    showDialog<CircleAvatar>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text('head'),
              children: <Widget>[
                /*ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text('user@example.com'),
            onTap: () => Navigator.pop(context, 'user@example.com'),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text('user2@gmail.com'),
            onTap: () => Navigator.pop(context, 'user2@gmail.com'),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: Text('Add account'),
            onTap: () => Navigator.pop(context, 'Add account'),
          ),*/
                GridView.count(
                    crossAxisCount: 5, //(MediaQuery.of(context).size.width / 80).round(),
                    children: List.generate(colors.length, (int index) {
                      return _item(index, colors[index], (colors[index].value == currentColor!.value), onSelect);
                    })),
              ],
            )).then(
      (returnVal) {
        if (returnVal != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You clicked: $returnVal'),
              action: SnackBarAction(label: 'OK', onPressed: () {}),
            ),
          );
        }
      },
    );
  }

  Widget _builder(
      {required BuildContext context, required ValueChanged<Color> onSelect, required List<Color> colors, Color? currentColor}) {
    int _count = (MediaQuery.of(context).size.width / 80).round();
    return DraggableScrollableSheet(
        expand: false,
        //maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: GridView.count(
                crossAxisCount: _count,
                controller: scrollController,
                children: List.generate(colors.length, (int index) {
                  return _item(index, colors[index], (colors[index].value == currentColor!.value), onSelect);
                }),
              ),
            ),
          );
        });
  }

  Widget _item(int index, Color color, bool isCurrent, ValueChanged<Color> onTap) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Ink(
        child: InkWell(
          onTap: () => {onTap(color)},
          child: CircleAvatar(
            child: isCurrent ? Icon(Icons.check) : Container(),
            backgroundColor: color,
          ),
        ),
      ),
    );
  }
}
