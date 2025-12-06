import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/local_image_entity.dart';
import '../../../data/repositories/local_images_repository_impl.dart';
import 'local_images_state.dart';

class LocalImagesCubit extends Cubit<LocalImagesState> {
  final LocalImagesRepositoryImpl repository;

  LocalImagesCubit(this.repository) : super(LocalImagesInitial());

  Future<void> loadImages() async {
    emit(LocalImagesLoading());

    try {
      final data = await repository.getAll();
      emit(LocalImagesLoaded(data));
    } catch (e) {
      emit(LocalImagesError("Error loading local images"));
    }
  }

  Future<void> saveImage(LocalImageEntity entity) async {
    final result = await repository.insertImage(entity);

    if (result) {
      emit(LocalImageSaved());
      await loadImages();
    } else {
      emit(LocalImagesError("Image already exists"));
    }
  }

  Future<void> deleteImage(String id) async {
    await repository.delete(id);
    emit(LocalImageDeleted());
    await loadImages();
  }

  // Actualizar imagen
  Future<void> updateImage(String id, String newAuthor) async {
    emit(LocalImagesLoading());

    // Obtener la imagen actual
    final image = await repository.getById(id);

    if (image == null) {
      emit(LocalImagesError("No se encontró la imagen"));
      return;
    }

    // Crear copia actualizada
    final updatedImage = image.copyWith(author: newAuthor);

    // Guardar en BD
    await repository.update(updatedImage);

    emit(LocalImageUpdated());

    // Refrescar lista
    await loadImages();
  }
}
