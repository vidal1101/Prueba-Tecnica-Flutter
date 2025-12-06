

import 'package:equatable/equatable.dart';
import '../../../domain/entities/local_image_entity.dart';

abstract class LocalImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalImagesInitial extends LocalImagesState {}

class LocalImagesLoading extends LocalImagesState {}

class LocalImagesLoaded extends LocalImagesState {
  final List<LocalImageEntity> images;

  LocalImagesLoaded(this.images);

  @override
  List<Object?> get props => [images];
}

class LocalImagesError extends LocalImagesState {
  final String message;

  LocalImagesError(this.message);

  @override
  List<Object?> get props => [message];
}

class LocalImageSaved extends LocalImagesState {}

class LocalImageDeleted extends LocalImagesState {}

class LocalImageUpdated extends LocalImagesState {}



