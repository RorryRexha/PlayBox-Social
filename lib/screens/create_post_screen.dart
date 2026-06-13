import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController tagsController =
      TextEditingController();

  String selectedGame = "Ghost of Tsushima";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
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
              "1. Selecciona tu contenido",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: Colors.cyanAccent,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Imagen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          color: Colors.purpleAccent,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Video",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              height: 220,
              width: double.infinity,

              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(15),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/post1.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "2. Escribe una descripción",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "¿Qué estás jugando?",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),

                filled: true,
                fillColor: const Color(0xFF0F172A),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "3. ¿Qué juego es?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(12),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xFF0F172A),
                  value: selectedGame,
                  isExpanded: true,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: "Ghost of Tsushima",
                      child: Text("Ghost of Tsushima"),
                    ),
                    DropdownMenuItem(
                      value: "Elden Ring",
                      child: Text("Elden Ring"),
                    ),
                    DropdownMenuItem(
                      value: "Warzone",
                      child: Text("Warzone"),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      selectedGame = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "4. Etiquetas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [

                Chip(
                  label: const Text("#GhostOfTsushima"),
                  backgroundColor: Colors.grey.shade900,
                ),

                Chip(
                  label: const Text("#PlayStation"),
                  backgroundColor: Colors.grey.shade900,
                ),
              ],
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

                onPressed: () {},

                child: const Text(
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