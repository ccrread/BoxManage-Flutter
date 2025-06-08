import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../providers/box_provider.dart';
import '../routes/app_router.dart';
class BoxItem extends StatelessWidget {
  final BoxModel box;

  const BoxItem({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(DetailRoute(id: box.id)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '页面 ${box.id}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}