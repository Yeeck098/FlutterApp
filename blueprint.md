# Blueprint de la Aplicación

## Descripción General

Esta es una aplicación Flutter que implementa un sistema de autenticación de usuarios y funcionalidades basadas en roles (administrador y lector) utilizando GetX para la gestión de estado y Supabase como backend.

## Estilo y Diseño

*   **Tema y Paleta de Colores:** La aplicación ha sido rediseñada con una paleta de colores moderna y profesional:
    *   **Color Primario:** Azul oscuro (`#0D47A1`) para barras de aplicación, iconos principales y botones.
    *   **Color de Acento:** Teal (`#4DB6AC`) utilizado para resaltar elementos, como el avatar del desarrollador.
    *   **Cabeceras de Tarjeta:** Un azul más brillante (`#1565C0`) para los encabezados, proporcionando profundidad.
    *   **Acciones de Salida:** Un rojo sutil (`#c0392b`) para el botón de cerrar sesión, asegurando claridad en la acción.
    *   **Fondo:** Un gris claro (`#F5F5F5`) para la pantalla de inicio de sesión, ofreciendo un aspecto limpio.
*   **Diseño General:** La interfaz es limpia y centrada en el usuario. Se utilizan tarjetas con sombras y bordes redondeados para crear una sensación de elevación y modernidad.
*   **Tarjeta de Identidad:** Mantiene un diseño profesional y realista, ahora alineado con la nueva paleta de colores.
*   **Tarjeta de Desarrollador:** La tarjeta de contacto del desarrollador también ha sido actualizada con los nuevos colores.

## Características

*   **Autenticación de Usuarios:**
    *   Pantalla de inicio de sesión rediseñada con una paleta de colores profesional.
    *   Cifrado de contraseña (MD5) antes de la transmisión.
    *   Validación de credenciales contra una tabla `persona` en Supabase.
    *   Manejo de estados de carga y visualización de errores.
    *   Función de cierre de sesión.
*   **Funcionalidades Basadas en Roles:**
    *   **Usuario General:**
        *   Acceso a una tarjeta de identidad digital detallada.
        *   Visualización de la tarjeta de contacto del desarrollador.
    *   **Usuario Lector:**
        *   Capacidad de escanear códigos de barras a través de la opción "Escanear".
    *   **Usuario Administrador:**
        *   Acceso a una sección de "Usuarios" (funcionalidad pendiente).
*   **Navegación:**
    *   La navegación entre pantallas se gestiona de forma eficiente con `GetX`.

## Arquitectura

*   **Gestión de Estado:** Se utiliza `GetX` para un manejo de estado reactivo y centralizado.
*   **Backend:** La autenticación y obtención de datos de usuario se realiza a través de una API REST conectada a una base de datos de Supabase.
*   **Estructura del Proyecto:**
    *   `lib/main.dart`: Punto de entrada de la aplicación.
    *   `lib/login_page.dart`: UI de la pantalla de inicio de sesión.
    *   `lib/login_controller.dart`: Lógica de negocio para la autenticación y gestión de la sesión.
    *   `lib/home_page.dart`: UI de la pantalla principal.
*   **Dependencias Clave:** `get`, `http`, `crypto`, `qr_flutter`, `simple_barcode_scanner`.

## Vulnerabilidades de Seguridad

*   **Claves de API Hardcodeadas:** El `apikey` y el token de `Authorization` de Supabase están directamente en el código de `lib/login_controller.dart`. **Esto es un riesgo de seguridad crítico.**

## Plan de Acción

1.  **Resolver Vulnerabilidad de Seguridad (Prioridad Alta):** Extraer las claves de API del código fuente y cargarlas de forma segura utilizando variables de entorno.
2.  **Implementar Funcionalidad de Administrador:** Desarrollar la interfaz y la lógica para la gestión de usuarios.
3.  **Añadir Imagen de Desarrollador:** Reemplazar el ícono de marcador de posición en la tarjeta de desarrollador con una imagen real.
