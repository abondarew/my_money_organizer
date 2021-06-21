import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymoneyorganizer/app/view/common/util/color_utils.dart';

const List<Color> defaultAvailableColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

typedef LayoutBuilder = Widget Function(BuildContext context, List<Color> colors, ItemPicker child);
typedef ItemBuilder = Widget Function(Color color, bool isCurrent, void Function() changeColor);
typedef ItemPicker = Widget Function(Color color);

class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onChanged;
  final List<Color> availableColors;
  final LayoutBuilder layoutBuilder;
  final ItemBuilder itemBuilder;

  ColorPicker(
      {required this.pickerColor,
      required this.onChanged,
      this.availableColors = defaultAvailableColors,
      this.layoutBuilder = defaultLayoutBuilder,
      this.itemBuilder = defaultItemBuilder});

  @override
  State<ColorPicker> createState() => _State(pickerColor);

  static Widget defaultLayoutBuilder(BuildContext context, List<Color> colors, ItemPicker child) {
    return Container(
      width: 300,
      height: 300,
      child: GridView.count(
        crossAxisCount: 4,
        /*crossAxisSpacing: 10,
        mainAxisSpacing: 10,*/
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(Color color, bool isChecked, void Function() onChanged) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => onChanged(),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isChecked ? 1.0 : 0.0,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.check_outlined,
                  color: ColorUtils.contrastText(color, Colors.white70, Colors.black87),
                  size: 135,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _State extends State<ColorPicker> {
  late Color _currentColor;

  _State(this._currentColor);

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void _selectColor(Color color) {
    setState(() {
      _currentColor = color;
    });
    //print('select');
    widget.onChanged(color);
    //valueChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(context, widget.availableColors,
        (Color color) => widget.itemBuilder(color, color.value == _currentColor.value, () => _selectColor(color)));
  }
}
