import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/managebookings_controller.dart';

class ManagebookingsView extends GetView<ManagebookingsController> {
  const ManagebookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManagebookingsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManagebookingsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
