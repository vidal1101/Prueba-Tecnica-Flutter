
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/image_zoom_viewer.dart';

class PrefsDetailScreen extends StatefulWidget {
  final LocalImageEntity image;

  const PrefsDetailScreen({super.key, required this.image});

  @override
  State<PrefsDetailScreen> createState() => _PrefsDetailScreenState();
}

class _PrefsDetailScreenState extends State<PrefsDetailScreen> {
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();
    authorController = TextEditingController(text: widget.image.author);
  }

  Future<void> _saveChanges() async {
    final newAuthor = authorController.text.trim();

    if (newAuthor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El autor no puede estar vacío"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await di.localImagesCubit.updateImage(
      widget.image.id,
      newAuthor,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cambios guardados"),
        backgroundColor: Colors.black87,
      ),
    );

    Navigator.pop(context);
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Confirmar eliminación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("¿Desea eliminar esta imagen?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await di.localImagesCubit.deleteImage(widget.image.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Imagen eliminada"),
          backgroundColor: Colors.black87,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final img = widget.image;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Detalle", style: TextStyle(color: Colors.white)),
      ),

      body: BlocListener<LocalImagesCubit, dynamic>(
        listener: (context, state) {},
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 🔥 Imagen con zoom
            ImageZoomViewer(imageUrl: img.downloadUrl),

            const SizedBox(height: 22),

            // 🔥 Campo de autor
            const Text(
              "Autor",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: authorController,
              decoration: InputDecoration(
                hintText: "Nombre del autor",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔥 Botón guardar cambios
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Guardar cambios",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ❌ Botón eliminar
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _confirmDelete,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Eliminar imagen",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
