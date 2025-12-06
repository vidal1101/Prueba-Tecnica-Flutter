import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/data/datasources/local/local_db.dart';

class ApiItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ApiItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    const fallbackImage = "https://picsum.photos/200";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: Image.network(
              item['download_url'],
              width: 100,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                fallbackImage,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['author'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      final success = await LocalDB.instance.insertImage({
                        "id": item["id"],
                        "author": item["author"],
                        "download_url": item["download_url"],
                      });
                  
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: success
                              ? Colors.green
                              : Colors.red,
                          content: Text(
                            success
                                ? "Imagen guardada"
                                : "Ya existe en la base local",
                          ),
                        ),
                      );
                    },
                    child: const Text("Guardar",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
