import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_state.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/image_zoom_viewer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// PrefsDetailScreen
/// Pantalla de detalle para una imagen guardada en la base local.
class PrefsDetailScreen extends StatefulWidget {
  final LocalImageEntity image;

  const PrefsDetailScreen({super.key, required this.image});

  @override
  State<PrefsDetailScreen> createState() => _PrefsDetailScreenState();
}

class _PrefsDetailScreenState extends State<PrefsDetailScreen> {
  late TextEditingController nameController;

  bool hasConnection = true; // Nuevo estado para red

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.image.customName?.isNotEmpty == true
          ? widget.image.customName
          : widget.image.author,
    );

    _checkConnection();
  }

  Future<void> _checkConnection() async {
    final res = await Connectivity().checkConnectivity();
    if (!mounted) return;

    setState(() {
      // ignore: unrelated_type_equality_checks
      hasConnection = res != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final newName = nameController.text.trim();

    if (newName.isEmpty || newName.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El nombre personalizado debe tener al menos 2 caracteres"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    di.localImagesCubit.updateImage(widget.image.id, newName);
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Confirmar eliminación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("¿Desea eliminar esta imagen?"),
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
      di.localImagesCubit.deleteImage(widget.image.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final img = widget.image;

    return BlocListener<LocalImagesCubit, LocalImagesState>(
      bloc: di.localImagesCubit,
      listener: (context, state) {
        if (state is LocalImageUpdated) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cambios guardados"),
              backgroundColor: Colors.black87,
            ),
          );
          Navigator.pop(context);
        }

        if (state is LocalImageDeleted) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Imagen eliminada"),
              backgroundColor: Colors.black87,
            ),
          );
          Navigator.pop(context);
        }

        if (state is LocalImagesError) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Detalle", style: TextStyle(color: Colors.white)),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // =============================
            //   Imagen o estado sin red
            // =============================
            hasConnection
                ? ImageZoomViewer(imageUrl: img.downloadUrl)
                : Container(
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, size: 60, color: Colors.red),
                          SizedBox(height: 12),
                          Text(
                            "Sin conexión",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

            const SizedBox(height: 22),

            // Nombre personalizado
            const Text(
              "Nombre personalizado",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Nombre para esta imagen",
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

            const SizedBox(height: 12),

            // Autor original
            Text(
              "Autor original: ${img.author}",
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 25),

            // Botón guardar
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

            // Botón eliminar
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
