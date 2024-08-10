import 'package:flutter/material.dart';
import 'package:social_login_notification_fase_8/widgets/my_drawer/my_drawer.widget.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: const Center(
        child: Text("Página de Mensagens"),
      ),
    );
  }
}
