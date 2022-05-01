import 'package:widgets/widgets.dart';

//class CheckAvatarSide{
final List<AvatarLocation> leftSide = [
  AvatarLocation.bottomLeftCoroner,
  AvatarLocation.leftBottom,
  AvatarLocation.leftCenter,
  AvatarLocation.leftTop,
  AvatarLocation.topLeftCoroner,
];

final List<AvatarLocation> topSide = [
  AvatarLocation.topLeftCoroner,
  AvatarLocation.topLeft,
  AvatarLocation.topCenter,
  AvatarLocation.topRight,
  AvatarLocation.topRightCoroner,
];

final List<AvatarLocation> rightSide = [
  AvatarLocation.topRightCoroner,
  AvatarLocation.rightTop,
  AvatarLocation.rightCenter,
  AvatarLocation.rightBottom,
  AvatarLocation.bottomRightCoroner,
];

final List<AvatarLocation> bottomSide = [
  AvatarLocation.bottomRightCoroner,
  AvatarLocation.bottomRight,
  AvatarLocation.bottomCenter,
  AvatarLocation.bottomLeft,
  AvatarLocation.bottomLeftCoroner,
];

final List<AvatarLocation> coroner = [
  AvatarLocation.bottomLeftCoroner,
  AvatarLocation.topLeftCoroner,
  AvatarLocation.topRightCoroner,
  AvatarLocation.bottomRightCoroner,
];

final List<AvatarLocation> center = [
  AvatarLocation.leftCenter,
  AvatarLocation.topCenter,
  AvatarLocation.rightCenter,
  AvatarLocation.bottomCenter,
];

bool onLeftSide(AvatarLocation location, {bool includeCoroner = true}) => //leftSide.contains(location);
    includeCoroner ? leftSide.contains(location) : (leftSide.contains(location) && !coroner.contains(location));

bool onTopSide(AvatarLocation location, {bool includeCoroner = true}) => //topSide.contains(location);
    includeCoroner ? topSide.contains(location) : (topSide.contains(location) && !coroner.contains(location));

bool onRightSide(AvatarLocation location, {bool includeCoroner = true}) => //rightSide.contains(location);
    includeCoroner ? rightSide.contains(location) : (rightSide.contains(location) && !coroner.contains(location));

bool onBottomSide(AvatarLocation location, {bool includeCoroner = true}) =>
    includeCoroner ? bottomSide.contains(location) : (bottomSide.contains(location) && !coroner.contains(location));

bool onCoroner(AvatarLocation location) => coroner.contains(location);

bool onCenter(AvatarLocation location) => center.contains(location);

bool onCenterX(AvatarLocation location) => (onCenter(location) && (onTopSide(location) || onBottomSide(location)));

bool onCenterY(AvatarLocation location) => (onCenter(location) && (onLeftSide(location) || onRightSide(location)));

//}
