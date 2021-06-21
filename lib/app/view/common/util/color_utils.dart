import 'dart:math';
import 'dart:ui';

class ColorUtils {
  static Color contrastText(Color bg, Color color1, Color color2) {
    int contrastColor1 = _colorDiff(bg, color1);
    int contrastColor2 = _colorDiff(bg, color2);

    if (contrastColor1 >= contrastColor2) {
      return color1;
    }
    return color2;
  }

  static int _colorDiff(Color color1, Color color2) {
    return ((max(color1.red, color2.red) - min(color1.red, color2.red)) +
            (max(color1.green, color2.green) - min(color1.green, color2.green)) +
            (max(color1.blue, color2.blue) - min(color1.blue, color2.blue)))
        .toInt();
  }
}
