import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> submitLead({
    required List<String> services,
    required String name,
    required String phone,
    required String email,
    required String company,
    required String message,
    required String discoverySource,
    required bool wantsMeeting,
    String? scheduledDate,
    String? scheduledTime,
  }) async {
    try {
      await _db.collection("leads").add({
        "services": services,
        "name": name,
        "phone": phone,
        "email": email,
        "company": company,
        "message": message,
        "discoverySource": discoverySource,
        "wantsMeeting": wantsMeeting,
        "scheduledDate": scheduledDate,
        "scheduledTime": scheduledTime,
        "timestamp": FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print("❌ Error submitting lead: $e");
      return false;
    }
  }
}
