import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
  }

  Future<Map<String, dynamic>> _loadUser() async {
  return await ProfileService.getProfile();
  }
  
  Future<void> _refresh() async {
    setState(() {
      _userFuture = _loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error cargando perfil",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final user = snapshot.data ?? {};

            return RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // HEADER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'assets/images/avatar1.png',
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            user["name"] ?? "Sin nombre",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            user["email"] ?? "",
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            user["bio"] ?? "Vivo por y para los videojuegos.",
                            style: const TextStyle(color: Colors.white54),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 15),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.cyanAccent,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "México",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "PlayStation",
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 20),
                              Text("PC", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Divider(color: Colors.white24),

                    // ESTADÍSTICAS (luego las conectamos al backend)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${user["posts_count"] ?? 0}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Publicaciones",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${user["followers_count"] ?? 0}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Seguidores",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${user["following_count"] ?? 0}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Siguiendo",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    _sectionTitle("Juegos favoritos"),

                    SizedBox(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(12),
                        children: [
                          _gameCard("Pragmata", "assets/images/game1.jpg"),
                          _gameCard(
                            "Resident Evil 9",
                            "assets/images/game2.png",
                          ),
                          _gameCard("Fortnite", "assets/images/game3.jpg"),
                          _gameCard(
                            "The last of us Part II",
                            "assets/images/game4.jpg",
                          ),
                        ],
                      ),
                    ),

                    _sectionTitle("Logros destacados"),

                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(12),
                        children: [
                          _achievementCard("Elden Lord"),
                          _achievementCard("Platino"),
                          _achievementCard("Diamante"),
                          _achievementCard("Leyenda"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Ver todos", style: TextStyle(color: Colors.cyanAccent)),
        ],
      ),
    );
  }

  Widget _gameCard(String title, String image) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _achievementCard(String title) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
