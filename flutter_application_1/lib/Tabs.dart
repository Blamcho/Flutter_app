import 'package:flutter/material.dart';

import 'StorScreen.dart';
import 'BlogScreen.dart';
import 'ProfileScreen.dart'; // Import the new screens

class Paginatabs extends StatefulWidget {
  const Paginatabs({super.key});

  @override
  State<Paginatabs> createState() => _PaginatabsState();
}

class _PaginatabsState extends State<Paginatabs> with SingleTickerProviderStateMixin {

  int selectedTab = 0;
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, initialIndex: selectedTab, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          //HomeScreen( email: '', username: '',),
          BlogScreen(),
          ProfileScreen(),
          StoreScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.red,
          tabs: const [
           
            Tab(child: Text('Blog')),
            Tab(child: Text('Profile')),
            Tab(child: Text('Store')),
          ],
        ),
      ),
    );
  }
}
