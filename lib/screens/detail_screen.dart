import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import '../providers/box_provider.dart';
import '../routes/app_router.dart';

@RoutePage()
class DetailScreen extends ConsumerStatefulWidget {
  
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(boxProvider.notifier).updateBoxAccessTime(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final boxList = ref.watch(boxProvider);
    final box = boxList.firstWhere((b) => b.id == widget.id);
    const maxBoxes = BoxProvider.maxBoxes;
    final hasPrev = widget.id > 1;
    final hasNext = widget.id < maxBoxes && 
                   boxList[widget.id].filled == true;

    return Scaffold(
      appBar: AppBar(
        title: Text('页面 ${widget.id}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // 直接返回主页
          onPressed: () => context.router.navigate(const HomeRoute()),
        ),
      ),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '页面 ${widget.id}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                '访问时间: ${box.lastUpdated?.toString() ?? '未知'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: widget.id == 1 
                  ? _buildFirstPageContent()
                  : _buildPageContent(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (hasPrev)
                    ElevatedButton(
                      onPressed: () => context.pushRoute(DetailRoute(id: widget.id - 1)),
                      child: const Text('上一页'),
                    ),
                  ElevatedButton(
                    // 返回主页
                    onPressed: () => context.router.navigate(const HomeRoute()),
                    child: const Text('返回'),
                  ),
                  if (hasNext)
                    ElevatedButton(
                      onPressed: () => context.pushRoute(DetailRoute(id: widget.id + 1)),
                      child: const Text('下一页'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPageContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 50),
          SizedBox(height: 20),
          Text(
            '欢迎来到第一个页面',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '这是第一个页面的特殊内容',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.description,
                    color: Colors.blue[700],
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '内容 ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '这是页面 ${widget.id} 的第 ${index + 1} 条内容',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}