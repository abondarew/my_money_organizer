import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mymoneyorganizer/app/view/common/util/color_utils.dart';
import 'package:mymoneyorganizer/app/view/common/util/crossfade_animation.dart';

class CardWithAvatar extends StatelessWidget {
  const CardWithAvatar({
    Key? key,
    required this.cardBody,
    required this.avatarSetting,
    this.elevation,
  }) : super(key: key);

  final Widget cardBody;
  final AvatarSetting avatarSetting;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final CardTheme _cardTheme = CardTheme.of(context);
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              //Background circle
              _buildAvatar(
                withBorder: true,
                backgroundColor: _cardTheme.color ?? _theme.cardColor,
                elevation: elevation ?? _cardTheme.elevation ?? 4.0,
              ),
              //Card content
              Padding(
                padding: EdgeInsets.only(top: avatarSetting.avatarHeight / 3),
                child: Card(
                  elevation: elevation ?? _cardTheme.elevation ?? 4.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, avatarSetting.avatarHeight - avatarSetting.avatarHeight / 3, 8, 8),
                    child: cardBody,
                  ),
                ),
              ),
              //Foreground + avatar content circle
              _buildAvatar(
                withBorder: false,
                backgroundColor: _cardTheme.color ?? _theme.cardColor,
                child: _buildAvatarContent(shadowColor: _cardTheme.shadowColor ?? _theme.shadowColor),
                elevation: 0,
              ),
              //Badge
              _buildBadge(
                canvasColor: _cardTheme.color ?? _theme.cardColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar({bool withBorder = false, Widget? child, required Color backgroundColor, required double elevation}) {
    return Align(
      alignment: avatarSetting.avatarAlignment,
      child: Padding(
        padding: avatarSetting.avatarPadding,
        child: SizedBox.fromSize(
          size: avatarSetting.avatarSize,
          child: Material(
            type: MaterialType.circle,
            color: backgroundColor,
            elevation: elevation,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  List<BoxShadow> _buildBoxShadow({required Color shadowColor}) {
    return [
      BoxShadow(
        blurRadius: 4,
        spreadRadius: .5,
        color: shadowColor,
        offset: const Offset(1, 4),
      )
    ];
  }

  AnimatedContainer _buildAvatarContent({required Color shadowColor}) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: avatarSetting.avatarBackgroundColor,
        borderRadius: BorderRadius.circular(avatarSetting.avatarWidth),
        boxShadow: avatarSetting.shadowOnContent ? _buildBoxShadow(shadowColor: shadowColor) : null,
      ),
      duration: const Duration(milliseconds: 250),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(avatarSetting.avatarWidth),
          onTap: avatarSetting.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16), //TODO
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CrossFade<String>(
                builder: (val) => Text(val!,
                    style: TextStyle(
                      fontSize: 400,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.contrastColor(
                          bg: avatarSetting.avatarBackgroundColor!, c1: Colors.grey.shade200, c2: Colors.grey.shade800),
                    )),
                initialData: avatarSetting.avatarText,
                data: avatarSetting.avatarText,
                duration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge({required Color canvasColor}) {
    if (avatarSetting.badge != null) {
      return Align(
        alignment: avatarSetting.avatarAlignment,
        child: Padding(
          padding: EdgeInsets.only(
            left: avatarSetting.avatarPadding.left + avatarSetting.avatarWidth - avatarSetting.avatarWidth / 3,
            top: avatarSetting.avatarHeight - avatarSetting.avatarHeight / 3,
          ),
          child: Material(
            type: MaterialType.circle,
            color: canvasColor,
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: avatarSetting.onTap,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  avatarSetting.badge!,
                  //color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class AvatarSetting {
  final Size avatarSize;
  final String avatarText;
  final Color? avatarBackgroundColor;
  final IconData? badge;
  final VoidCallback onTap;
  final EdgeInsets avatarPadding;
  final Alignment avatarAlignment;
  final bool shadowOnContent;

  AvatarSetting({
    this.avatarPadding = const EdgeInsets.only(left: 16, right: 16),
    this.avatarAlignment = Alignment.topLeft,
    this.avatarSize = const Size(90.0, 90.0),
    required this.avatarText,
    required this.onTap,
    this.avatarBackgroundColor,
    this.badge,
    this.shadowOnContent = false,
  });

  double get avatarWidth => avatarSize.width;

  double get avatarHeight => avatarSize.height;
}
