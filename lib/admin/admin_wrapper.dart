import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class AdminWrapper extends StatelessWidget {
  final String uid;
  const AdminWrapper({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final doc = FirebaseFirestore.instance.collection('admins').doc(uid);

    return FutureBuilder<DocumentSnapshot>(
      future: doc.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final isAdmin = snapshot.data?.get('isAdmin') == true;

        if (isAdmin) {
          return const DashboardScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
