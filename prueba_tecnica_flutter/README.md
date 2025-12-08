
# 📱 Prueba Técnica Flutter — Gestión de Ítems desde API + Persistencia Local

Esta aplicación móvil desarrollada en **Flutter** permite:

- Consultar ítems desde una **API pública**
- Asignarles un **nombre personalizado**
- Guardarlos en una **base de datos local SQLite**
- Gestionarlos mediante CRUD completo
- Visualizar detalles y editar elementos
- Usar **Cubit (BloC)** como gestor de estado

Incluye manejo de conectividad, diseño responsive y documentación completa.

---

# 🚀 Instalación y Ejecución

## 1. Clonar el repositorio
```bash
git clone https://github.com/vidal1101/Prueba-Tecnica-Flutter
cd Prueba-Tecnica-Flutter

2. Instalar dependencias
flutter pub get

3. Ejecutar el proyecto
flutter run

4. (Opcional) Regenerar ícono del launcher
flutter pub run flutter_launcher_icons


Nota: El proyecto se probó únicamente en Android, debido a que no poseo una Mac para generar o depurar builds de iOS.

🏗️ Arquitectura del Proyecto

Arquitectura basada en Clean Architecture simplificada:

lib/
│
├── app/
│   ├── app.dart
│   ├── di.dart
│   └── routes.dart
│
├── data/
│   ├── datasources/
│   │   ├── api_client.dart
│   │   └── local/
│   │       └── local_db.dart
│   ├── repositories/
│       ├── items_repository_impl.dart
│       └── local_images_repository_impl.dart
│
├── domain/
│   ├── entities/
│   └── repositories/
│
├── presentation/
│   ├── cubits/
│   │   ├── api/
│   │   └── local_images/
│   ├── screens/
│   └── widgets/
│
└── main.dart

📌 Funcionalidades Principales
✔ 1. Consumo de API pública

Se consultan imágenes desde Picsum Photos, con manejo de:

Loading

Error

Sin conexión

Reintento

✔ 2. Guardado local con nombre personalizado

El usuario selecciona un ítem y puede asignarle un nombre propio.

✔ 3. CRUD completo

Crear: guardar item personalizado

Leer: ver lista local

Actualizar: editar nombre

Eliminar: confirmación y borrado

✔ 4. Búsqueda avanzada

Implementado con SearchDelegate, buscando por:

custom_name

author

download_url

✔ 5. Pantallas requeridas

/api-list

/prefs

/prefs/detail

Pantalla de splash

Pantallas de error y carga

Vista de detalle con zoom interactivo

✔ 6. Manejo de conectividad

Antes de consumir API se valida conexión a internet.
Si no hay red se muestra un mensaje con opción de reintento.

✔ 7. UI Responsive

Toda la UI usa medidas dinámicas mediante:

MediaQuery

Layout adaptable

Widgets escalables

Placeholders cuando no hay internet para evitar imágenes rotas

📦 Dependencias Principales
Producción

flutter_bloc — Cubit para manejo de estado

dio — Cliente HTTP

sqflite — Base de datos local

path_provider — Directorios nativos

path — Manipulación de rutas

equatable — Mejor comparación de estados

animate_do — Animaciones

animated_splash_screen — Pantalla de inicio

Desarrollo

flutter_lints

flutter_test

🧠 Cubits Implementados
ApiCubit

ApiInitial

ApiLoading

ApiLoaded

ApiError

ApiNoConnection

LocalImagesCubit

LocalImagesInitial

LocalImagesLoading

LocalImagesLoaded

LocalImageSaved

LocalImagesError

LocalImageUpdated

LocalImageDeleted

🗄️ Persistencia Local (SQLite)

Estructura de tabla:

saved_images

id TEXT PRIMARY KEY
author TEXT
download_url TEXT
custom_name TEXT


Incluye migraciones automáticas para agregar columnas faltantes cuando se abre la base de datos.

🎨 UI — Detalles Importantes

Imágenes con fallback si no hay internet

Diálogos con validación

Animaciones de entrada

Diseño responsive con MediaQuery

Vista de detalle con zoom interactivo

Botones consistentes y accesibles

🔎 Búsqueda Inteligente

Consultas SQL en tiempo real:

SELECT * FROM saved_images
WHERE author LIKE ? 
OR custom_name LIKE ?
OR download_url LIKE ?


Incluye:

Vista previa del resultado

Navegación al detalle

Manejo de errores

Resultados interactivos

⚙️ Decisiones Técnicas
✔ Cubit en lugar de Bloc

Más simple, más rápido de implementar y suficiente para los flujos requeridos.

✔ SQLite (sqflite) para persistencia

Permite CRUD estructurado, ideal para persistir datos locales sin conexión.

✔ Dio como cliente HTTP

Robusto, configurable, rápido, con soporte para interceptores y cancelación.

✔ Arquitectura por capas

Separa responsabilidades, facilita pruebas y mejora mantenibilidad.

🙋‍♂️ Sobre el Autor

Rodrigo Vidal
Desarrollador de Software — Costa Rica

Estoy en constante aprendizaje y con entusiasmo por aportar al equipo.
Agradezco la oportunidad de demostrar mis habilidades y con gusto seguiré aprendiendo y contribuyendo en lo que sea necesario.

📝 Licencia

Proyecto desarrollado únicamente con fines evaluativos para prueba técnica.


