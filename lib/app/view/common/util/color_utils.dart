import 'dart:math';
import 'dart:ui';

class ColorUtils {
  static Color contrastColor({required Color bg, required Color c1, required Color c2}) {
    int contrastColor1 = _colorDiff(bg, c1);
    int contrastColor2 = _colorDiff(bg, c2);

    if (contrastColor1 >= contrastColor2) {
      return c1;
    }
    return c2;
  }

  static Color similarColor({required Color bg, required Color c1, required Color c2}) {
    int contrastColor1 = _colorDiff(bg, c1);
    int contrastColor2 = _colorDiff(bg, c2);

    if (contrastColor1 >= contrastColor2) {
      return c2;
    }
    return c1;
  }

  static int _colorDiff(Color color1, Color color2) {
    return ((max(color1.red, color2.red) - min(color1.red, color2.red)) +
            (max(color1.green, color2.green) - min(color1.green, color2.green)) +
            (max(color1.blue, color2.blue) - min(color1.blue, color2.blue)))
        .toInt();
  }
}
