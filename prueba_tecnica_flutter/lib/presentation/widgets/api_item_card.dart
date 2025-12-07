
import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';

class ApiItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ApiItemCard({
    super.key,
    required this.item,
  });

  Future<void> _showSaveDialog(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Guardar imagen"),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Autor: ${item['author']}"),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: "Nombre personalizado",
                        hintText: "Ej: Foto especial",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 2) {
                          return "Debe contener al menos 2 caracteres";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pop(ctx, true);
                }
              },
              child: const Text("Guardar",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    // Usuario canceló
    if (result != true || !context.mounted) return;

    final customName = controller.text.trim();

    final entity = LocalImageEntity(
      id: item['id'].toString(),
      author: item['author'],
      downloadUrl: item['download_url'],
      customName: customName,
    );

    /// 🟩 Guardamos con el Cubit
    /// El resultado será escuchado por BlocListener en ApiListScreen
    await di.localImagesCubit.saveImage(entity);
  }

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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () => _showSaveDialog(context),
                  child: const Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white),
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
