import 'package:flutter/material.dart';

class Marqee extends StatefulWidget {
  final String text;
  final Duration animationDuration;
  final Duration animationDelay;
  final int symbolsPerDurationTime;

  const Marqee(
      {Key key,
      @required this.text,
      this.animationDuration = const Duration(seconds: 10),
      this.symbolsPerDurationTime = 100,
      this.animationDelay = const Duration(seconds: 1)})
      : super(key: key);

  @override
  _MarqeeState createState() => _MarqeeState();
}

class _MarqeeState extends State<Marqee> {
  ScrollController _scrollController;
  Duration _calculatedAnimationDuration;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _calculatedAnimationDuration = _calculateAnimationDuration();

    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        controller: _scrollController,
        child: Container(
          child: Text(
            widget.text,
            softWrap: false,
          ),
        ));
  }

  void _initAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (true) {
        await _initiateDelay();
        await _scrollTextToRight();
        await _initiateDelay();
        await _scrollTextToLeft();
      }
    });
  }

  Future _scrollTextToLeft() {
    return _scrollText(_scrollController.position.minScrollExtent);
  }

  Future _scrollTextToRight() {
    return _scrollText(_scrollController.position.maxScrollExtent);
  }

  Future _scrollText(double position) {
    return _scrollController.animateTo(position,
        duration: _calculatedAnimationDuration, curve: Curves.easeOutCubic);
  }

  Future _initiateDelay() {
    return Future<dynamic>.delayed(widget.animationDelay);
  }

  Duration _calculateAnimationDuration() {
    bool canCalculateDuration = widget.text.isNotEmpty &&
        widget.text.length > widget.symbolsPerDurationTime &&
        (widget.symbolsPerDurationTime > 0);

    if (!canCalculateDuration) {
      return widget.animationDuration;
    }

    return widget.animationDuration *
        (widget.text.length / widget.symbolsPerDurationTime);
  }
}
