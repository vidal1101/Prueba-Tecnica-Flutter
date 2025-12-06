

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/widgets.dart';

import '../../../app/di.dart';
import '../../../presentation/cubits/api/api_cubit.dart';
import '../../../presentation/cubits/api/api_state.dart';

class ApiListScreen extends StatelessWidget {
  const ApiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.apiCubit..fetchApiItems(),
      child: Scaffold(
        backgroundColor: Colors.white,
        
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Lista de imágenes", style: TextStyle(color: Colors.white)),
        ),

        body: BlocBuilder<ApiCubit, ApiState>(
          builder: (_, state) {
            if (state is ApiLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            if (state is ApiError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error: ${state.message}",
                        style: const TextStyle(color: Colors.black)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {
                        context.read<ApiCubit>().fetchApiItems();
                      },
                      child: const Text("Reintentar", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            if (state is ApiLoaded) {
              final items = state.items;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final item = items[i];
                  return ApiItemCard(
                    item: item,
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
