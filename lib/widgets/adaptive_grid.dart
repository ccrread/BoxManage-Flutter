import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'box_item.dart';
import 'pulse_box.dart';
import '../providers/box_provider.dart';

class AdaptiveGrid extends ConsumerWidget {
  const AdaptiveGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boxes = ref.watch(boxProvider);
    final filledBoxes = boxes.where((box) => box.filled).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // 固定网格参数
        const boxWidth = 100.0;
        const spacing = 15.0;
        const rowSpacing = 15.0;
        const boxHeight = 80.0;
        
        // 计算网格列数 - 确保至少3列（即使容器较小）
        final crossAxisCount = (constraints.maxWidth / (boxWidth + spacing)).floor();
        final effectiveCrossAxisCount = crossAxisCount.clamp(3, 10); 

        // 计算所需行数
        final rowCount = (filledBoxes.length / effectiveCrossAxisCount).ceil();
        
        // 计算总高度 - 包括内边距和边框的高度
        final totalHeight = boxHeight * rowCount +  rowSpacing * (rowCount - 1) + 30; 

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: filledBoxes.isEmpty ? 0 : totalHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: effectiveCrossAxisCount,
              mainAxisSpacing: rowSpacing,
              crossAxisSpacing: spacing,
              childAspectRatio: boxWidth / boxHeight,
            ),
            itemCount: filledBoxes.length,
            itemBuilder: (context, index) {
              final box = filledBoxes[index];
              return box.isFirst 
                ? PulseBox(box: box)
                : BoxItem(box: box);
            },
          ),
        );
      },
    );
  }
}