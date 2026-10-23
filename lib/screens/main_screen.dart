import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/screens/home_screen.dart';
import 'package:tasks/screens/tasks_screen.dart';
import 'package:tasks/screens/complete_tasks.dart';
import 'package:tasks/screens/profile_screen.dart';
import 'package:beauty_is_now/beauty_is_now.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TasksScreen(),
    const CompleteTasks(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, left: 10, right: 10),
        child: BeautyNavBar(
          width: MediaQuery.of(context).size.width - 100,
          backgroundColor: Colors.transparent,
          containerRadius: 35,
          pillColor: Theme.of(context).colorScheme.primaryContainer,
          pillRadius: 35,
          activeColor: Theme.of(context).iconTheme.color,
          inactiveColor: Theme.of(context).iconTheme.color!.withAlpha(90),
          currentIndex: _selectedIndex,
          onChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BeautyNavItem(label: 'Home', icon: Icons.home_rounded),
            BeautyNavItem(label: 'Search', icon: Icons.add_task_outlined),
            BeautyNavItem(label: 'Tasks',icon: Icons.check_circle_outline_rounded,),
          ],
        ),
      ),
    );
  }
}
