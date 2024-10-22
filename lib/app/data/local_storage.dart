import 'package:hive/hive.dart';

class LocalStorage {
  static late Box _contactsBox;
  static late Box _authBox;

  static Future<void> init() async {
    _contactsBox = await Hive.openBox('contacts');
    _authBox = await Hive.openBox('authBox');
  }

  static Future<void> addContact(Map<String, dynamic> contact) async {
    await _contactsBox.add(contact);
  }

  static List<Map<String, dynamic>> getContacts() {
    return _contactsBox.values.cast<Map<String, dynamic>>().toList();
  }

  static Future<void> updateContact(int index, Map<String, dynamic> contact) async {
    await _contactsBox.putAt(index, contact);
  }

  static Future<void> deleteContact(int index) async {
    await _contactsBox.deleteAt(index);
  }

  static Future<void> setToken(String token) async {
    await _authBox.put('token', token);
  }

  static String? getToken() {
    return _authBox.get('token');
  }

  static Future<void> clearToken() async {
    await _authBox.delete('token');
  }
}
