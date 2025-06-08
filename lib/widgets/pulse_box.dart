import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../providers/box_provider.dart';
import '../routes/app_router.dart';
class PulseBox extends StatefulWidget {
  final BoxModel box;

  const PulseBox({super.key, required this.box});

  @override
  _PulseBoxState createState() => _PulseBoxState();
}

class _PulseBoxState extends State<PulseBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(DetailRoute(id: widget.box.id)),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 8 * _controller.value + 4,
                  spreadRadius: 2 * _controller.value,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '点击跳转',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}