import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/session_history.dart';

class SessionHistoryService {
  static const _boxName = 'session_history';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  List<SessionHistory> getAllSessions() {
    return _box.keys
        .map(
          (k) => SessionHistory.fromJson(
            jsonDecode(_box.get(k) as String) as Map<String, dynamic>,
          ),
        )
        .toList()
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
  }

  List<SessionHistory> getRecentSessions({int limit = 5}) {
    final all = getAllSessions();
    return all.take(limit).toList();
  }

  Future<void> saveSession(SessionHistory session) async {
    await _box.put(session.id, jsonEncode(session.toJson()));
  }

  Future<void> deleteSession(String id) async {
    await _box.delete(id);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  int get totalSessions => _box.length;

  int get completedSessions =>
      getAllSessions().where((s) => s.status == SessionStatus.completed).length;

  double get totalGrindWeight => getAllSessions()
      .where((s) => s.status == SessionStatus.completed)
      .fold(0.0, (sum, s) => sum + s.batchSizeKg);

  Duration get totalGrindTime => getAllSessions()
      .where((s) => s.status == SessionStatus.completed)
      .fold(Duration.zero, (sum, s) => sum + s.duration);
}
