// change screens
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
    barrierColor: Colors.white,
    barrierDismissible: false,
    maintainState: true,
    opaque: true,
    reverseTransitionDuration: Duration(milliseconds: 600),
    fullscreenDialog: true,
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (

        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: Colors.transparent,
          child: child,
        ),
  );
}