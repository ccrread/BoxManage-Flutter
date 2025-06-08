import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoxModel {
  final int id;
  final bool filled;
  final bool isFirst;
  final DateTime? lastUpdated;
  final String path;

  BoxModel({
    required this.id,
    required this.filled,
    required this.isFirst,
    this.lastUpdated,
    required this.path,
  });

  BoxModel copyWith({
    int? id,
    bool? filled,
    bool? isFirst,
    DateTime? lastUpdated,
    String? path,
  }) {
    return BoxModel(
      id: id ?? this.id,
      filled: filled ?? this.filled,
      isFirst: isFirst ?? this.isFirst,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      path: path ?? this.path,
    );
  }
}

class BoxProvider extends StateNotifier<List<BoxModel>> {
  BoxProvider() : super([]) {
    loadBoxes();
  }

  static const int maxBoxes = 20;

  void loadBoxes() {
    state = List.generate(maxBoxes, (index) {
      return BoxModel(
        id: index + 1,
        filled: index == 0,
        isFirst: index == 0,
        path: '/page/${index + 1}',
        lastUpdated: null,
      );
    });
  }

  int get activeBoxCount => state.where((box) => box.filled).length;

  void addBox() {
    if (activeBoxCount >= maxBoxes) return;
    
    final newState = [...state];
    for (var box in newState) {
      if (!box.filled) {
        final updatedBox = box.copyWith(
          filled: true,
          lastUpdated: DateTime.now(),
        );
        newState[box.id - 1] = updatedBox;
        break;
      }
    }
    state = newState;
  }

  void removeBox() {
    if (activeBoxCount <= 1) return;
    
    final newState = [...state];
    for (int i = newState.length - 1; i >= 1; i--) {
      if (newState[i].filled) {
        newState[i] = newState[i].copyWith(
          filled: false,
          lastUpdated: null,
        );
        break;
      }
    }
    state = newState;
  }

  void updateBoxAccessTime(int id) {
    final newState = [...state];
    final index = newState.indexWhere((box) => box.id == id);
    if (index != -1) {
      newState[index] = newState[index].copyWith(lastUpdated: DateTime.now());
      state = newState;
    }
  }
}

final boxProvider = StateNotifierProvider<BoxProvider, List<BoxModel>>(
  (ref) => BoxProvider(),
);