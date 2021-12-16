import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<Color> defaultAvailableColors = [
  //Colors.transparent,
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
  //TODO edit size dialog for desktop
  final Color pickerColor;
  final ValueChanged<Color> onChanged;
  final List<Color> availableColors;
  final LayoutBuilder layoutBuilder;
  final ItemBuilder itemBuilder;

  const ColorPicker(
      {Key? key,
      required this.pickerColor,
      required this.onChanged,
      this.availableColors = defaultAvailableColors,
      this.layoutBuilder = defaultLayoutBuilder,
      this.itemBuilder = defaultItemBuilder})
      : super(key: key);

  @override
  State<ColorPicker> createState() => _State();

  static Widget defaultLayoutBuilder(BuildContext context, List<Color> colors, ItemPicker child) {
    return SizedBox(
      width: 300,
      height: 300,
      child: GridView.count(
        crossAxisCount: 4,
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(Color color, bool isChecked, void Function() onChanged) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          //color: isChecked ? const Color.fromARGB(255, 60, 196, 252) : const Color.fromARGB(0, 60, 196, 252), //TODO what?
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: isChecked ? const Color.fromARGB(255, 60, 196, 252) : const Color.fromARGB(0, 60, 196, 252),
              spreadRadius: 1.5,
              blurRadius: 3,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(215, 255, 255, 255),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
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
                  ),
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

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void _selectColor(Color color) {
    setState(() {
      _currentColor = color;
    });
    widget.onChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (Color color) => widget.itemBuilder(
        color,
        color.value == _currentColor.value,
        () => _selectColor(color),
      ),
    );
  }
}
