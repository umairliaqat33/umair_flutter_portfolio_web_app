import 'package:flutter/material.dart';

class BouncyButton extends StatefulWidget {
  final Widget buttonWidget;
  final Function onTap;
  const BouncyButton({
    super.key,
    required this.buttonWidget,
    required this.onTap,
  });
  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isClicked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 1, end: 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      _isClicked = true;
    });

    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isClicked ? 1.0 : _animation.value,
          child: GestureDetector(
              onTap: () {
                widget.onTap();
                _onButtonPressed();
              },
              child: widget.buttonWidget),
        );
      },
    );
  }
}
