import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/post_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController descriptionController = TextEditingController();

  String selectedGame = "Ghost of Tsushima";
  bool _loading = false;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  final Map<String, int> gameMap = {
    "Ghost of Tsushima": 1,
    "Elden Ring": 2,
    "Warzone": 3,
  };

  // =========================
  // 📸 PICK IMAGE
  // =========================
  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  // =========================
  // 📤 CREATE POST + MEDIA FLOW
  // =========================
  Future<void> _publishPost() async {
    final description = descriptionController.text.trim();

    if (description.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Agrega texto o imagen")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final gameId = gameMap[selectedGame];

      // 1️⃣ Crear post
      final postResult = await PostService.createPost(
        description: description,
        gameId: gameId?.toString(),
      );

      if (postResult["success"] != true) {
        throw Exception(postResult["message"]);
      }

      final postId = postResult["data"]["post"]["id"];

      // 2️⃣ Subir media si existe
      if (_image != null) {
        final mediaResult = await PostService.uploadMedia(
          postId: postId,
          file: _image!,
        );

        if (mediaResult["success"] != true) {
          throw Exception(mediaResult["message"]);
        }
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🔥 Post publicado")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Nueva publicación",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "1. Imagen",
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _image == null
                    ? const Center(
                        child: Text(
                          "Toca para seleccionar imagen",
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "2. Descripción",
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "¿Qué estás jugando?",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "3. Juego",
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedGame,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF0F172A),
                  style: const TextStyle(color: Colors.white),
                  items: gameMap.keys.map((game) {
                    return DropdownMenuItem(
                      value: game,
                      child: Text(game),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGame = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _loading ? null : _publishPost,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        "Publicar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}