import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animations/animations.dart';
import 'package:fit_guide/widgets/CreatePlaylist.dart';
const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  final ContainerTransitionType transitionType;

  const CustomFABWidget({
    Key? key,
    required this.transitionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
    transitionDuration: Duration(seconds: 2),
    openBuilder: (context, _) => CreatePlaylist(),
    closedShape: CircleBorder(),
    closedColor: Colors.pink,
    closedBuilder: (context, openContainer) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
      ),
      height: fabSize,
      width: fabSize,
      child: Icon(Icons.add, color: Colors.white),
    ),
  );
}