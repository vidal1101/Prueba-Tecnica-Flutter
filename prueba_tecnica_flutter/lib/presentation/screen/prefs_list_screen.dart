import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_state.dart';
import 'package:prueba_tecnica_flutter/app/routes.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/widgets.dart';

class PrefsListScreen extends StatelessWidget {
  const PrefsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350;

    final imageSize = isSmall ? 70.0 : 90.0;
    final cardPadding = isSmall ? 10.0 : 14.0;
    final cardMargin = isSmall ? 10.0 : 16.0;

    return BlocProvider.value(
      value: di.localImagesCubit..loadImages(),
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Imágenes Guardadas",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  delegate: PrefsSearchDelegate(),
                );
                if (result != null) {
                  di.localImagesCubit.loadImages();
                }
              },
            ),
          ],
        ),

        body: BlocBuilder<LocalImagesCubit, LocalImagesState>(
          builder: (_, state) {
            if (state is LocalImagesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            if (state is LocalImagesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is LocalImagesLoaded) {
              final items = state.images;

              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    "No hay imágenes guardadas",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: cardPadding),
                itemCount: items.length,
                itemBuilder: (_, i) => _SavedImageCard(
                  image: items[i],
                  imageSize: imageSize,
                  cardMargin: cardMargin,
                  cardPadding: cardPadding,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _SavedImageCard extends StatelessWidget {
  final LocalImageEntity image;
  final double imageSize;
  final double cardMargin;
  final double cardPadding;

  const _SavedImageCard({
    required this.image,
    required this.imageSize,
    required this.cardMargin,
    required this.cardPadding,
  });

  Future<void> _confirmDelete(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Confirmar eliminación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content:
            Text("¿Desea eliminar la imagen '${image.customName ?? image.author}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text("Eliminar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      di.localImagesCubit.deleteImage(image.id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Imagen eliminada"),
          backgroundColor: Colors.black87,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: cardMargin, vertical: 8),
        padding: EdgeInsets.all(cardPadding),
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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /// 🔹 Miniatura con fallback y tamaño adaptativo
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image.downloadUrl,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: imageSize,
                      height: imageSize,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// 🔹 Texto + botón delete adaptables
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        image.customName ?? "Sin nombre personalizado",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Autor: ${image.author}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 🔹 Botón ver detalles
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.prefsDetail,
                    arguments: image,
                  );
                },
                child: const Text(
                  "Ver detalles",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
