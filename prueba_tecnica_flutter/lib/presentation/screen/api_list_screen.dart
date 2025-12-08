
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/widgets.dart';

import '../../../app/di.dart';
import '../../../presentation/cubits/api/api_cubit.dart';
import '../../../presentation/cubits/api/api_state.dart';
import '../../../presentation/cubits/local_images/local_images_cubit.dart';
import '../../../presentation/cubits/local_images/local_images_state.dart';

/// ApiListScreen
/// 
/// Lista los ítems provenientes de la API (responsive + mediaquery).
class ApiListScreen extends StatelessWidget {
  const ApiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Responsive base
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    final double horizontalPadding = isSmall ? 10 : 16;
    final double verticalPadding = isSmall ? 4 : 8;
    final double titleFontSize = isSmall ? 18 : 20;
    final double buttonFontSize = isSmall ? 13 : 15;

    return BlocProvider.value(
      value: di.apiCubit..fetchApiItems(),

      child: BlocListener<LocalImagesCubit, LocalImagesState>(
        bloc: di.localImagesCubit,
        listener: (context, state) {
          if (state is LocalImageSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Imagen guardada exitosamente"),
              ),
            );
          }

          if (state is LocalImagesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },

        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Lista de imágenes",
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
              ),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),

            child: BlocBuilder<ApiCubit, ApiState>(
              builder: (_, state) {
                
                /// ---------------------
                /// Estado de carga
                /// ---------------------
                if (state is ApiLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }

                /// ---------------------
                /// Sin conexión
                /// ---------------------
                if (state is ApiNoConnection) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: isSmall ? 60 : 80, color: Colors.black),
                        const SizedBox(height: 20),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isSmall ? 14 : 16,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 25),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmall ? 10 : 14,
                              horizontal: isSmall ? 16 : 24,
                            ),
                          ),
                          onPressed: () {
                            context.read<ApiCubit>().fetchApiItems();
                          },
                          child: Text(
                            "Reintentar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                /// ---------------------
                /// Datos cargados
                /// ---------------------
                if (state is ApiLoaded) {
                  final items = state.items;

                  return ListView.builder(
                    padding: EdgeInsets.only(top: verticalPadding),
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return ApiItemCard(item: item);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
