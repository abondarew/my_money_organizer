import 'package:flutter/material.dart';
import 'package:widgets/card_with_avatar/const.dart';
import 'package:widgets/card_with_avatar/src/widget/card.dart';

class AvatarCardBuilder extends StatelessWidget {
  final Widget avatar;
  final AvatarLocation avatarLocation;
  final EdgeInsets avatarOffset;
  final EdgeInsets avatarPadding;
  final Size avatarSize;
  final Widget child;
  final Widget? actionButton;
  final Size buttonSize;
  final EdgeInsets buttonPadding;
  final ButtonLocation buttonLocation;
  final double buttonIndented;
  final Color? backgroundColor;
  final double elevation;
  final Radius radiusRect;

  //final CardSettings cardSettings; //TODO not initialize variable

  const AvatarCardBuilder({
    Key? key,
    required this.avatar,
    this.avatarLocation = AvatarLocation.topLeft,
    this.avatarOffset = const EdgeInsets.all(16),
    this.avatarPadding = const EdgeInsets.all(4),
    this.avatarSize = const Size(90, 90),
    required this.child,
    this.actionButton,
    this.buttonLocation = ButtonLocation.rightDocked,
    this.buttonIndented = 32,
    this.buttonSize = const Size(56, 56),
    this.buttonPadding = const EdgeInsets.all(4),
    this.backgroundColor,
    this.elevation = 4.0,
    this.radiusRect = const Radius.circular(4.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWithAvatar(
      CardSettings(
        avatar: avatar,
        avatarLocation: avatarLocation,
        avatarOffset: avatarOffset,
        avatarSize: avatarSize,
        avatarPadding: avatarPadding,
        child: child,
        actionButton: actionButton,
        buttonLocation: buttonLocation,
        buttonSize: buttonSize,
        buttonPadding: buttonPadding,
        buttonIndented: buttonIndented,
        backgroundColor: backgroundColor,
        elevation: elevation,
        radiusRect: radiusRect,
      ),
    );
  }
}
