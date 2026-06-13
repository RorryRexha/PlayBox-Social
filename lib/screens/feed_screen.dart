import 'package:flutter/material.dart';
import 'create_post_screen.dart';
import 'profile_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreatePostScreen()),
      );
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "PlayBox Social",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],

        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.cyanAccent,
          labelColor: Colors.cyanAccent,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: "Para ti"),
            Tab(text: "Siguiendo"),
            Tab(text: "Popular"),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [_buildFeed(), _buildFeed(), _buildFeed()],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white54,

        onTap: _onItemTapped,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Inicio",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 35),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "Alertas",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: const Color(0xFF0F172A),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar1.png'),
                ),

                title: Text(
                  "RodrigoGamer",
                  style: TextStyle(color: Colors.white),
                ),

                subtitle: Text(
                  "Hace 2 horas",
                  style: TextStyle(color: Colors.white54),
                ),

                trailing: Icon(Icons.more_vert, color: Colors.white),
              ),

              Image.asset('assets/images/post1.png', fit: BoxFit.cover),

              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Después de 120 horas... por fin lo logré.\nElden Ring 100% completado 🔥",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.white),

                    SizedBox(width: 5),

                    Text("128", style: TextStyle(color: Colors.white)),

                    SizedBox(width: 20),

                    Icon(Icons.chat_bubble_outline, color: Colors.white),

                    SizedBox(width: 5),

                    Text("24", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
