
import 'package:flutter/material.dart';
import 'package:friend_findr/screens/user_list.dart';
import 'package:friend_findr/screens/users_favorites.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedTab=0;

  final List<Widget> _children=[
    Center(
      child: Image.network("https://psicologiamonzo.com/wp-content/uploads/2019/03/multiracial-grupo-joven-gente-toma-selfie_1139-1032.jpg"),
    ),
    const UserList(),
    const UserFavorites(),
  ];

  _changeTab(int index){
    setState(() {
      _selectedTab=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FriendFindr"),
      ),
      body: _children[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index)=> _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Branding"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Personas"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),

        ],
      ),
    );
  }
}

