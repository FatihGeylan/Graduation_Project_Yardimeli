import 'dart:async';

import 'package:flutter/material.dart';

class horizontalSrollAnimation extends StatefulWidget {
  final Widget? animationtext;
  const horizontalSrollAnimation( {required this.animationtext,Key? key}) : super(key: key);
  @override
  State<horizontalSrollAnimation> createState() => _horizontalSrollAnimationState();
}

class _horizontalSrollAnimationState extends State<horizontalSrollAnimation> with TickerProviderStateMixin{

  ScrollController _scrollController = ScrollController();
  bool scroll = true;
  int speedFactor = 20;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> animationloop(BuildContext context)async{
    await Future.delayed(Duration(seconds: 3));
    await _scroll();
    // await Future.delayed(Duration(seconds: 1));
    // _scrollreverse();

  }

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);
  }
  _scrollreverse(){
    double minExtent=_scrollController.position.minScrollExtent;
    double distanceDifference = minExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);

  }

  _toggleScrolling() {
    setState(() {
      scroll = !scroll;
    });

    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(_scrollController.offset,
          duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }
  @override
  Widget build(BuildContext context) {
    animationloop(context);
    return NotificationListener(
      onNotification: (notif) {
        if (notif is ScrollEndNotification && scroll) {
          Timer(Duration(seconds: 3), () {
            _scroll();
          });
        }
        return true;
      },
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: widget.animationtext!
      ),
    );
  }
}
