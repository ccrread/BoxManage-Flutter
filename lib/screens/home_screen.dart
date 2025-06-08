import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import '../providers/box_provider.dart';
import '../widgets/adaptive_grid.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(boxProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('盒子管理系统'),
        backgroundColor: Colors.blue[100], // 淡蓝色标题栏
      ),
      body: Center(
        child: Container(
          width: 600, // 设置固定宽度
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4), // 蓝色边框，更粗
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 蓝色方形按钮区域
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: notifier.addBox,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          '增加按钮',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: notifier.removeBox,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          '减少按钮',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 绿色边框容器
             Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(10),
                ),
                width: 350, 
                constraints: const BoxConstraints(
                minHeight: 0, 
                ),
                child: const AdaptiveGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}