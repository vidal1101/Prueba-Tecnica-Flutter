

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/app/routes.dart';


/// PrefsSearchDelegate
/// 
/// Esta clase representa un delegate de búsqueda personalizado para la lista de imágenes guardadas.
class PrefsSearchDelegate extends SearchDelegate<LocalImageEntity?> {
  PrefsSearchDelegate() : super(searchFieldLabel: 'Buscar por nombre o autor');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchFuture(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(
        child: Text('Escribe para buscar por nombre personalizado o autor' , 
        style: TextStyle(fontSize: 16 ,), 
        textAlign: TextAlign.center,
        ),
      );
    }
    return _buildSearchFuture(context);
  }

  Widget _buildSearchFuture(BuildContext context) {
    return FutureBuilder<List<LocalImageEntity>>(
      future: di.localImagesCubit.searchImages(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return const Center(child: Text('No se encontraron coincidencias'));
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: results.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final item = results[i];

            // Construimos la tile aquí y pasamos callbacks que usan `close` (del delegate)
            return _SearchResultTile(
              image: item,
              onSelected: () {
                // Cerramos el SearchDelegate devolviendo la entidad (opcional)
                close(context, item);
                // Y navegamos al detalle usando AppRoutes (usa tu router)
                Navigator.pushNamed(context, AppRoutes.prefsDetail, arguments: item);
              },
              onOpenDetail: () {
                // Otra acción directa: no cerrar el delegado, solo abrir detalle
                close(context, null); // cerramos search antes de navegar para evitar overlay
                Navigator.pushNamed(context, AppRoutes.prefsDetail, arguments: item);
              },
            );
          },
        );
      },
    );
  }
}

/// _SearchResultTile
///
/// Esta clase representa una fila de resultados de búsqueda.
class _SearchResultTile extends StatelessWidget {
  final LocalImageEntity image;
  final VoidCallback onSelected;   // cuando toca la fila
  final VoidCallback onOpenDetail; // si presiona el icono de flecha

  const _SearchResultTile({
    required this.image,
    required this.onSelected,
    required this.onOpenDetail,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image.downloadUrl,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(image.customName ?? '(Sin nombre)'),
        subtitle: Text(image.author),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: onOpenDetail,
        ),
        onTap: onSelected,
      ),
    );
  }
}

