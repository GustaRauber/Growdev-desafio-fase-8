import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_notification.service.dart';
import '../../widgets/my_drawer/my_drawer.widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    FirebaseNotificationService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (FirebaseAuth.instance.currentUser != null)
              CircleAvatar(
                backgroundImage:
                    NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                radius: 80,
              ),
            const SizedBox(
              height: 20,
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Text(FirebaseAuth.instance.currentUser!.displayName!),
          ],
        ),
      ),
    );
  }
}



            //OutlinedButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //     if (!mounted) return;
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (_) => const LoginPage(),
            //       ),
            //     );
            //   },
            //   child: const Text(
            //     "Sair",
            //     style: TextStyle(
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            