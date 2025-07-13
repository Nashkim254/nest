import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

class DotWidget extends StatefulWidget {
  @override
  _DotWidgetState createState() => _DotWidgetState();
}

class _DotWidgetState extends State<DotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIndex = (activeIndex + 1) % 3;
          });
          _controller.forward(from: 0);
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot({required int index}) {
    return Positioned(
      left: index * 20.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: index == activeIndex ? kcPrimaryColor : kcOffWhite5Grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 20,
      child: Stack(
        children: List.generate(3, (i) => _dot(index: i)),
      ),
    );
  }
}
