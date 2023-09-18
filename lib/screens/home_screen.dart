import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedIndex = 0;
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1.0);

  final List<Widget> _tabs = const [
    TodoListScreen(),
    Text("Search"),
    Text("Profile"),
    Text("Logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: _showAppBar(),
        drawer: const AppDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentSelectedIndex,
          onTap: (int tappedIndex) {
            print(tappedIndex);
            setState(() {
              currentSelectedIndex = tappedIndex;
              controller.animateToPage(tappedIndex,
                  duration: Duration(milliseconds: 500), curve: Curves.linear);
            });
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
                tooltip: "You can search anything"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
          ],
        ),
        body: PageView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: _tabs,
          onPageChanged: (value) {
            setState(() {
              currentSelectedIndex = value;
            });
          },
        ));
  }

  AppBar _showAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/sort.png"),
      ),
      title: const Text(
        'Todo',
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            "assets/user.png",
            height: 42,
            width: 42,
          ),
        )
      ],
    );
  }
}
