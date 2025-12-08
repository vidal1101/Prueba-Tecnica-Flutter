
import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';

/// ApiItemCard
/// Card responsive con mediaquery, evitando overflow e imágenes rotas.
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
        final size = MediaQuery.of(ctx).size;
        final isSmall = size.width < 360;

        return AlertDialog(
          title: Text(
            "Guardar imagen",
            style: TextStyle(fontSize: isSmall ? 18 : 20),
          ),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.9,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Autor: ${item['author']}",
                      style: TextStyle(fontSize: isSmall ? 13 : 15),
                    ),

                    SizedBox(height: isSmall ? 10 : 14),

                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: "Nombre personalizado",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 2) {
                          return "Debe tener al menos 2 caracteres";
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
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    final customName = controller.text.trim();

    final entity = LocalImageEntity(
      id: item['id'].toString(),
      author: item['author'],
      downloadUrl: item['download_url'],
      customName: customName,
    );

    await di.localImagesCubit.saveImage(entity);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double imgWidth = size.width * 0.28;
    final double imgHeight = size.width * 0.23;

    final bool isSmall = size.width < 360;
    final double fontSizeTitle = isSmall ? 14 : 16;
    final double buttonFontSize = isSmall ? 12 : 14;
    final double cardPadding = isSmall ? 10 : 14;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmall ? 10 : 16,
        vertical: isSmall ? 6 : 8,
      ),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          /// =======================
          ///    Imagen segura
          /// =======================
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: imgWidth,
              height: imgHeight,
              child: Image.network(
                item['download_url'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.broken_image,
                      size: imgHeight * 0.5,
                      color: Colors.grey.shade700,
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: isSmall ? 10 : 14),

          /// =======================
          ///      Información
          /// =======================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['author'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: isSmall ? 10 : 14),

                /// Botón responsive
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        vertical: isSmall ? 8 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _showSaveDialog(context),
                    child: Text(
                      "Guardar",
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        color: Colors.white,
                      ),
                    ),
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
