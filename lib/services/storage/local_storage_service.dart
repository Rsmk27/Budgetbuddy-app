import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  static Box? _transactionsBox;
  static Box? _categoriesBox;
  static Box? _userBox;
  
  static Future<void> init() async {
    await Hive.initFlutter();
    _transactionsBox = await Hive.openBox(AppConstants.transactionsBox);
    _categoriesBox = await Hive.openBox(AppConstants.categoriesBox);
    _userBox = await Hive.openBox(AppConstants.userBox);
  }
  
  // Transactions Box
  static Box get transactionsBox {
    if (_transactionsBox == null || !_transactionsBox!.isOpen) {
      throw Exception('Transactions box not initialized');
    }
    return _transactionsBox!;
  }
  
  // Categories Box
  static Box get categoriesBox {
    if (_categoriesBox == null || !_categoriesBox!.isOpen) {
      throw Exception('Categories box not initialized');
    }
    return _categoriesBox!;
  }
  
  // User Box
  static Box get userBox {
    if (_userBox == null || !_userBox!.isOpen) {
      throw Exception('User box not initialized');
    }
    return _userBox!;
  }
  
  // Clear all data
  static Future<void> clearAll() async {
    await transactionsBox.clear();
    await categoriesBox.clear();
    await userBox.clear();
  }
  
  // Close all boxes
  static Future<void> closeAll() async {
    await _transactionsBox?.close();
    await _categoriesBox?.close();
    await _userBox?.close();
  }
}
