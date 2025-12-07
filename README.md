
Prueba Técnica Flutter — Gestión de Ítems desde API + Persistencia Local

Este proyecto es una aplicación móvil desarrollada en Flutter que permite consultar ítems desde una API pública, asignarles un nombre personalizado y almacenarlos en una base de datos local para su posterior gestión.

Incluye funcionalidades de listado, creación, edición, visualización de detalles y eliminación de elementos, además del uso de Cubit como gestor de estado.

Características Principales
✔ 1. Consumo de API pública

La app consulta imágenes desde el endpoint público de Picsum Photos, mapeando la respuesta JSON a modelos internos y gestionando estados de carga, éxito y error mediante ApiCubit.

✔ 2. Guardado local con nombre personalizado

El usuario puede seleccionar un ítem de la API y asignar un nombre personalizado, que se almacena en SQLite mediante un LocalImagesCubit.

✔ 3. CRUD completo en base local

Se permite:

Crear (guardar elemento personalizado)

Leer (listar favoritos)

Actualizar (editar nombre personalizado)

Eliminar (con confirmación)

✔ 4. Pantallas incluidas

/api-list – Lista de elementos desde la API

/prefs – Lista de elementos almacenados

/prefs/:id – Vista de detalle, edición y eliminación

Pantalla de carga global

Pantalla de error global

✔ 5. Gestión de estado con Cubit

Se utilizan dos cubits principales:

ApiCubit → Manejo de API

LocalImagesCubit → Manejo de elementos locales

Todos los cubits implementan estados:
loading, success, error.

✔ 6. Interfaz responsive

Toda la UI está diseñada con padding, márgenes y tamaños relativos para adaptarse a diferentes dispositivos.

Tecnologías & Paquetes Utilizados
Flutter versión:
3.24.x
Utilizada intencionalmente por compatibilidad con otros proyectos activos.

Dependencias principales:
flutter_bloc: ^9.1.1        # Gestión de estado con Cubit
dio: ^5.9.0                 # Cliente HTTP
equatable: ^2.0.7           # Comparación eficiente para estados y modelos

sqflite: ^2.3.1             # Base de datos local SQLite
path_provider: ^2.1.5       # Acceso a directorios de la app
path: ^1.8.3                # Manipulación de rutas

animate_do: ^3.3.4          # Animaciones de entrada
animated_splash_screen: ^1.3.0  # Splash inicial


Dependencias de desarrollo:
flutter_lints: ^4.0.0       # Reglas de clean code
flutter_test:               # Testing integrado



Estructura del Proyecto

La arquitectura está separada en capas claras y mantenibles:
lib/
│
├── app/
│   ├── di.dart                # Inyección de dependencias
│   ├── routes.dart            # Rutas nombradas
│   └── app.dart               # Inicio de la aplicación
│
├── data/
│   ├── datasources/
│   │   ├── api_client         # Llamadas a API
│   │   └── local/             # SQLite (LocalDB)
│   ├── repositories/          # Contratos abstractos
│
├── domain/
│   ├── entities/              # Entidades limpias
│   └── repositories/          # Contratos abstractos
│
├── presentation/
│   ├── cubits/
│   │   ├── api/               # ApiCubit + ApiState
│   │   └── local_images/      # LocalImagesCubit + estados
│       └── preferences/       # PreferencesCubit + estados
│   ├── screens/               # Todas las pantallas principales
│   ├── widgets/               # Widgets personalizados reutilizables
│
└── main.dart



Instalación y Ejecución

Clonar el repositorio

git clone https://github.com/vidal1101/Prueba-Tecnica-Flutter
cd Prueba-Tecnica-Flutter


Instalar dependencias

flutter pub get


Ejecutar el proyecto

flutter run

Arquitectura & Decisiones Técnicas
✔ Uso de Cubit (Bloc)

Se eligió Cubit por ser:

Más liviano que Bloc

Suficiente para flujos controlados

Fácil de probar

Fácil de mantener en 72h

✔ Persistencia con SQLite (sqflite)

Justificación:

Es la solución más estable y nativa para persistencia estructurada

Soporta CRUD completo

Ideal para almacenar colecciones tipo "favoritos"

✔ API con Dio

Ventajas:

Manejo integrado de timeout, interceptors, cancel tokens

Más robusto que HttpClient nativo

✔ Arquitectura por capas (Domain / Data / Presentation)

Beneficios:

Permite escalar el proyecto

Evita acoplamiento fuerte con infraestructura

Facilita pruebas unitarias y mantenimiento


Estados implementados
ApiCubit
ApiLoading
ApiLoaded
ApiError

LocalImagesCubit
LocalImagesLoading
LocalImagesLoaded
LocalImageSaved
LocalImagesError

 UI — Puntos destacables

Animaciones suaves con animate_do

Dialog de nombre personalizado con validaciones

Responsive layout

Manejo correcto de errores visuales

Vista detalle con zoom interactivo

Notas Finales

Este proyecto cumple con:

Clean Code

Gestión de estado con Cubit

Persistencia local confiable

Manejo de API

CRUD completo

Navegación con rutas nombradas

Documentación mínima requerida

Diseñado y desarrollado por Rodrigo Vidal
