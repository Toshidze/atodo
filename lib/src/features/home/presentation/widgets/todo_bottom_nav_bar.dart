import 'package:atodo/src/features/home/data/repository/todo_repository_impl.dart';
import 'package:atodo/src/features/home/presentation/UI/home_page.dart';
import 'package:atodo/src/features/home/presentation/UI/in_progress_page.dart';
import 'package:atodo/src/features/home/presentation/UI/is_done_page.dart';
import 'package:flutter/material.dart';

class TodoBottomNavBar extends StatefulWidget {
  const TodoBottomNavBar({Key? key}) : super(key: key);

  @override
  State<TodoBottomNavBar> createState() => _TodoBottomNavBarState();
}

class _TodoBottomNavBarState extends State<TodoBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    InProgressPage(),
    IsDonePage(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'Новое',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline_sharp),
            label: 'В работе',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Выполнено',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
