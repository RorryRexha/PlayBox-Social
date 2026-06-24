import 'package:flutter/material.dart';
import '../services/post_service.dart';
import 'create_post_screen.dart';
import 'profile_screen.dart';
import '../utils/time_ago.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;
  late Future<List<dynamic>> _postsFuture;

  final String baseImageUrl = "http://192.168.1.143:8000/storage/";

  final Map<int, bool> _likedPosts = {};
  final Map<int, int> _likesCount = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      _postsFuture = PostService.getPosts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreatePostScreen()),
      ).then((value) {
        if (value == true) _loadPosts();
      });
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  String? _getPostImage(dynamic post) {
    try {
      final media = post['media'];

      if (media != null && media is List && media.isNotEmpty) {
        final url = media[0]['url'];

        if (url == null) return null;

        return url.toString().startsWith("http")
            ? url
            : "$baseImageUrl$url";
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  Widget _buildFeed() {
    return FutureBuilder<List<dynamic>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.cyanAccent),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final posts = snapshot.data ?? [];

        if (posts.isEmpty) {
          return const Center(
            child: Text(
              "No hay posts aún",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => _loadPosts(),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final int postId = post['id'];

              final imageUrl = _getPostImage(post);

              final bool isLiked = _likedPosts[postId] ?? false;
              final int likesCount =
                  _likesCount[postId] ?? (post['likes_count'] ?? 0);

              return Card(
                color: const Color(0xFF0F172A),
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/avatar1.png'),
                      ),
                      title: Text(
                        post['user']?['name'] ?? "Usuario",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        TimeAgo.format(
                          DateTime.parse(post['created_at']).toLocal(),
                        ),
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),

                    if (imageUrl != null)
                      ClipRRect(
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        post['description'] ?? "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _likedPosts[postId] = !isLiked;
                                _likesCount[postId] =
                                    isLiked ? likesCount - 1 : likesCount + 1;
                              });

                              if (!isLiked) {
                                await PostService.likePost(postId);
                              } else {
                                await PostService.unlikePost(postId);
                              }
                            },
                            child: Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            "$likesCount",
                            style: const TextStyle(color: Colors.white),
                          ),

                          const SizedBox(width: 20),

                          const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            "${post['comments_count'] ?? 0}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "PlayBox Social",
          style: TextStyle(color: Colors.cyanAccent),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [_buildFeed(), _buildFeed(), _buildFeed()],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: const Color.fromARGB(137, 15, 14, 14),
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
}