/*
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AvatarLocation {
  topLeft,
  topCenter,
  topRight,
  leftTop,
  leftCenter,
  leftBottom,
  bottomLeft,
  bottomCenter,
  bottomRight,
  rightTop,
  rightCenter,
  rightBottom,
  topLeftCoroner,
  topRightCoroner,
  bottomLeftCoroner,
  bottomRightCoroner
}

class CardWithAvatar extends StatelessWidget {
  final Widget? avatar;
  final AvatarLocation avatarLocation;
  final double avatarYCenterOffset;
  final EdgeInsets avatarPadding;
  final Size avatarSize;
  final Widget? child;
  final FloatingActionButton? actionButton;
  final FloatingActionButtonLocation actionButtonLocation;
  final double elevation;
  final double rRound;
  final Color? backgroundColor;

  const CardWithAvatar({
    Key? key,
    this.avatar,
    this.avatarLocation = AvatarLocation.topLeft,
    this.avatarYCenterOffset = 0.0,
    this.avatarPadding = const EdgeInsets.only(left: 16, right: 16),
    this.avatarSize = const Size(90.0, 90.0),
    this.child,
    this.actionButton,
    this.actionButtonLocation = FloatingActionButtonLocation.endDocked,
    this.elevation = 4.0,
    this.rRound = 4.0,
    this.backgroundColor,
  })  : assert(elevation >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Material(
      elevation: elevation,
      type: MaterialType.card,
      color: backgroundColor,
      shape: _CardShape(*/
/*avatarSize: avatarSize, rRound: rRound,*/ /*
 fromCard: this, themeData: themeData),
      child: Stack(
        children: [
          //CircleAvatar(),
        ],
      ),
    );
  }
}

class _CardShape extends ShapeBorder {
  final CardWithAvatar fromCard;
  final ThemeData themeData;

  static const List<AvatarLocation> locatedOnTopSide = [
    AvatarLocation.topLeftCoroner,
    AvatarLocation.topRightCoroner,
    AvatarLocation.topLeft,
    AvatarLocation.topCenter,
    AvatarLocation.topRight
  ];

  static const List<AvatarLocation> locatedOnLeftSide = [
    AvatarLocation.leftBottom,
    AvatarLocation.leftCenter,
    AvatarLocation.leftTop,
    AvatarLocation.topLeftCoroner,
    AvatarLocation.bottomLeftCoroner
  ];

  static const List<AvatarLocation> locatedOnBottomSide = [
    AvatarLocation.bottomCenter,
    AvatarLocation.bottomLeft,
    AvatarLocation.bottomRight,
    AvatarLocation.bottomLeftCoroner,
    AvatarLocation.bottomRightCoroner
  ];

  static const List<AvatarLocation> locatedOnRightSide = [
    AvatarLocation.bottomRightCoroner,
    AvatarLocation.topRightCoroner,
    AvatarLocation.rightTop,
    AvatarLocation.rightCenter,
    AvatarLocation.rightBottom
  ];

*/
/*
  static const List<AvatarLocation> topFacet = [
    AvatarLocation.topLeft,
    AvatarLocation.topCenter,
    AvatarLocation.topRight,
    AvatarLocation.topLeftCoroner,
    AvatarLocation.topRightCoroner
  ];

  static const List<AvatarLocation> bottomFacet = [
    AvatarLocation.bottomLeft,
    AvatarLocation.bottomCenter,
    AvatarLocation.bottomRight,
    AvatarLocation.bottomLeftCoroner,
    AvatarLocation.bottomRightCoroner
  ];

  static const List<AvatarLocation> leftFacet = [
    AvatarLocation.leftBottom,
    AvatarLocation.leftCenter,
    AvatarLocation.leftTop,
    AvatarLocation.bottomLeftCoroner,
    AvatarLocation.topLeftCoroner
  ];

  static const List<AvatarLocation> rightFacet = [
    AvatarLocation.rightBottom,
    AvatarLocation.rightCenter,
    AvatarLocation.rightTop,
    AvatarLocation.bottomRightCoroner,
    AvatarLocation.topRightCoroner
  ];

  static const List<AvatarLocation> center = [
    AvatarLocation.bottomCenter,
    AvatarLocation.rightCenter,
    AvatarLocation.leftCenter,
    AvatarLocation.topCenter
  ];
*/ /*


  const _CardShape({required this.fromCard, required this.themeData});

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getCardPath(rect);
    */
/*rect = Rect.fromPoints(rect.topLeft + Offset(0, fromCard.avatarSize.height / 2), rect.bottomRight);
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(fromCard.rRound)));
      //..moveTo(0, 0)
      */ /*
 */
/*..addArc(
        */ /*
 */
/**/ /*
 */
/*Rect.fromPoints(
          rect.topLeft - Offset(-avatarLocationPadding.left, 45),
          rect.topLeft - Offset(-avatarSize.width - avatarLocationPadding.left, -45),
        ),*/ /*
 */
/**/ /*
 */
/*
        0,
        -pi,
      );*/ /*

  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) => this;

  //  *=======================================================================*
  Path _getCardPath(Rect rect) {
    //Get rect
    _RectPoint mainRect = _RectPoint(
      xStartPoint: rect.topLeft.dx,
      yStartPoint: rect.topLeft.dy,
      xEndPoint: rect.bottomRight.dx,
      yEndPoint: rect.bottomRight.dy - _getFABHeight() / 2,
    );
    //Get avatar
    _RectPoint avatarRect = _RectPoint();
    //Get FAB
    _RectPoint fabRect = _RectPoint();

    if (locatedOnTopSide.contains(fromCard.avatarLocation)) {
      mainRect.yStartPoint = fromCard.avatarSize.height / 2;
    }

    if (locatedOnLeftSide.contains(fromCard.avatarLocation)) {
      mainRect.xStartPoint = fromCard.avatarSize.width / 2;
    }

    if (locatedOnRightSide.contains(fromCard.avatarLocation)) {
      mainRect.xEndPoint = rect.bottomRight.dx - fromCard.avatarSize.width / 2;
    }

    if (locatedOnBottomSide.contains(fromCard.avatarLocation)) {
      mainRect.yEndPoint = rect.bottomRight.dy - fromCard.avatarSize.height / 2;
    }

    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(Rect.fromPoints(mainRect.getStartOffset(), mainRect.getEndOffset()), Radius.circular(fromCard.rRound)))
      ..addPath(_getAvatarPath(rect), const Offset(0, 0))
      ..fillType = PathFillType.evenOdd;
  }

  Path _getAvatarPath(Rect rect) {
    */
/*double xStartDelta = 0;
    double yStartDelta = 0;
    double xEndDelta = 0;
    double yEndDelta = 0;*/ /*


    _RectPoint _avatarRect = _RectPoint(
      xStartPoint: 0,
      yStartPoint: 0,
      xEndPoint: fromCard.avatarSize.width,
      yEndPoint: fromCard.avatarSize.height,
    );
    final Map<String, double> _angle = _getAngle();

    if (locatedOnBottomSide.contains(fromCard.avatarLocation)) {
      _avatarRect.setOffset(_getAvatarOffsetX(rect), rect.bottomLeft.dy - fromCard.avatarSize.height);
    }

    if (locatedOnTopSide.contains(fromCard.avatarLocation)) {
      _avatarRect.setOffsetDx(_getAvatarOffsetX(rect));
      */
/*switch (fromCard.avatarLocation){
        case AvatarLocation.leftBottom:{

        }
      }*/ /*

    }

*/
/*    if (fromCard.avatarLocation == AvatarLocation.topLeft || fromCard.avatarLocation == AvatarLocation.bottomLeft) {
      xStartDelta = fromCard.avatarPadding.left + fromCard.rRound;
      xEndDelta = xStartDelta + fromCard.avatarSize.width;
    }
    yEndDelta = fromCard.avatarSize.height;
    return Path()
      ..addArc(
        Rect.fromPoints(Offset(xStartDelta, yStartDelta), Offset(xEndDelta, yEndDelta)),
        _angle['startPoint']!,
        _angle['endPoint']!,
      );*/ /*


    Rect r = Rect.fromPoints(_avatarRect.getStartOffset(), _avatarRect.getEndOffset());
    return Path()
      ..addArc(
        r,
        _angle['startPoint']!,
        _angle['endPoint']!,
      )
      ..lineTo(r.center.dx, r.center.dy); //TODO artefact on round angle
  }

  double _getAvatarOffsetX(Rect rect) {
    switch (fromCard.avatarLocation) {
      case AvatarLocation.bottomLeftCoroner:
      case AvatarLocation.topLeftCoroner:
      case AvatarLocation.leftBottom:
      case AvatarLocation.leftCenter:
      case AvatarLocation.leftTop:
        return 0;
      case AvatarLocation.bottomRightCoroner:
      case AvatarLocation.topRightCoroner:
      case AvatarLocation.rightBottom:
      case AvatarLocation.rightCenter:
      case AvatarLocation.rightTop:
        return rect.bottomRight.dx - fromCard.avatarSize.width;
      case AvatarLocation.bottomLeft:
      case AvatarLocation.topLeft:
        return fromCard.rRound + fromCard.avatarPadding.left;
      default:
        return 50;
    }
  }

  double _getFABHeight() {
    //TODO hardcode FAB size
    if (fromCard.actionButton == null) {
      return 0;
    }
    if (fromCard.actionButton!.mini) {
      return 40.0;
    }
    if (fromCard.actionButton!.isExtended) {
      return 48.0;
    }
    return 56;
  }

  Map<String, double> _getAngle() {
    final Map<String, double> ret = {'startPoint': 0, 'endPoint': 0};
    if (fromCard.avatarLocation == AvatarLocation.topLeft ||
        fromCard.avatarLocation == AvatarLocation.topCenter ||
        fromCard.avatarLocation == AvatarLocation.topRight) {
      ret['startPoint'] = 0;
      ret['endPoint'] = -pi;
    }
    if (fromCard.avatarLocation == AvatarLocation.bottomLeft ||
        fromCard.avatarLocation == AvatarLocation.bottomCenter ||
        fromCard.avatarLocation == AvatarLocation.bottomRight) {
      ret['startPoint'] = 0;
      ret['endPoint'] = pi;
    }

    if (fromCard.avatarLocation == AvatarLocation.topLeftCoroner) {
      ret['startPoint'] = 0;
      ret['endPoint'] = -3 * pi / 2;
    }
    return ret;
  }
}

class _RectPoint {
  double yStartPoint;
  double xStartPoint;
  double yEndPoint;
  double xEndPoint;

  _RectPoint({
    this.xStartPoint = 0,
    this.yStartPoint = 0,
    this.xEndPoint = 0,
    this.yEndPoint = 0,
  });

  //factory _RectPoint.fromCentr

  void setOffset(double dx, double dy) {
    xStartPoint += dx;
    xEndPoint += dx;
    yStartPoint += dy;
    yEndPoint += dy;
  }

  void setOffsetDx(double dx) {
    setOffset(dx, 0);
  }

  void setOffsetDy(double dy) {
    setOffset(0, dy);
  }

  Offset getStartOffset() => Offset(xStartPoint, yStartPoint);

  Offset getEndOffset() => Offset(xEndPoint, yEndPoint);
}
*/
