import 'dart:convert';

List<Map<String, dynamic>> parseJsonToObject(String json) {
  return jsonDecode(json).cast<Map<String, dynamic>>();
}
