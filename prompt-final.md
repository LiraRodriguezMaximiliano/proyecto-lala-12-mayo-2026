### Prompt final

¡Ah, entiendo perfectamente! Si el objetivo es que otra IA procese este prompt para generar el sistema, necesitamos "densidad de instrucciones". Las IA funcionan mejor cuando tienen un contexto técnico híper-específico, restricciones claras y una estructura que no deje nada a la interpretación.

Aquí tienes el prompt optimizado para ser procesado por una IA de codificación (como otra instancia de Gemini, GPT-4 o Claude), diseñado para que te entregue la arquitectura lista para producción:

Prompt de Ingeniería: Arquitectura Core ERP Antigravity (LALA)
Actúa como un Arquitecto de Software Senior y Lead Developer Flutter.

1. Contexto del Proyecto
Genera la base de código para el proyecto "Antigravity", un ERP de misión crítica para el grupo lácteo LALA. El sistema debe garantizar la trazabilidad total: desde la salud del ganado hasta la entrega final de pedidos.

2. Requerimientos Arquitectónicos (Estándares Estrictos)
Aplica Clean Architecture con desacoplamiento total. La estructura de carpetas debe ser:

domain/: Entities puras y Use Cases (Interactors).

data/: Repositories, Models (con serialización JSON) y DataSources.

presentation/: State Management (BLoC/Riverpod) y UI Adaptativa.

Inyección de Dependencias: Configura un Service Locator utilizando el paquete get_it.

3. Esquema de Datos y Relaciones
Implementa los modelos de datos respetando las siguientes dependencias:

Origen: PROVEEDOR y GANADO (Campos: id, raza, codigo_arete, estado_salud).

Producción: PRODUCCION_LECHE vinculada a GANADO y PROCESO_INDUSTRIAL.

Calidad: CONTROL_CALIDAD (Gatekeeper). Campos obligatorios: ph (double), resultado (Enum: Aprobado/Rechazado).

Logística: PRODUCTO, LOTE (con estado_disponibilidad), CLIENTE, PEDIDO y DETALLE_PEDIDO.

RRHH: DEPARTAMENTO y EMPLEADO (Operadores de procesos).

4. Lógica de Negocio Crítica (A Programar)
Genera el código específico para los siguientes componentes:

Mapeo de Modelos: Crea GanadoModel y ProduccionLecheModel que extiendan de sus entidades en Domain, incluyendo métodos fromJson y toJson.

La "Regla de Oro de Calidad": Implementa un Use Case llamado ValidarYCrearLote.

Lógica: Si ph está entre 6.4 y 6.8 Y el resultado es 'Aprobado', debe instanciar un Lote con estado 'Disponible'. De lo contrario, lanzar un error de dominio o marcar como 'Rechazado'.

UI Adaptativa: Diseña un Scaffold principal que detecte la plataforma:

Si es Desktop/Web: Usar NavigationRail lateral.

Si es Mobile: Usar BottomNavigationBar.

Vistas base: Producción, Inventario, Ventas.

5. Formato de Salida
Proporciona la estructura de archivos en formato de árbol.

Código Dart limpio, con comentarios técnicos que expliquen el flujo de datos entre capas.

Usa tipos de datos rigurosos (evita dynamic).

Asegura que el código esté listo para ser insertado en un proyecto de Flutter.

¿Entendido? Procede a generar la estructura y el código core me lo envias despues.

## RESULTADO

Entendido. Vamos a elevar el **Prompt Final** a un nivel de arquitectura estratégica pura. He diseñado este documento para que, al ser entregado a una IA, esta comprenda no solo qué programar, sino la **filosofía de ingeniería** y las **reglas de negocio inamovibles** que rigen a Grupo LALA.

Copia y pega el siguiente bloque:

---

# Prompt Maestro: Definición de Arquitectura y Roadmap - Proyecto Antigravity

**Rol:** Actúa como un Arquitecto de Software Senior y Lead Developer Multiplataforma.
**Misión:** Diseñar la base estructural del ERP "Antigravity" para Grupo LALA, asegurando trazabilidad total y deuda técnica cero.

## 1. Visión Arquitectónica (Clean Architecture)

El sistema debe estar estrictamente dividido en capas para garantizar independencia tecnológica:

* **Capa de Dominio (Núcleo):** Define entidades puras (Ganado, Lote, Producto, Calidad) y Casos de Uso (Interactors). Esta capa no debe conocer nada de Flutter ni de bases de datos externas.
* **Capa de Datos:** Implementa el Patrón Repository. Debe gestionar la lógica de persistencia, mapeo de modelos (DTOs) y la serialización de tipos complejos (Decimales para volumen de leche, Enums para estados de salud y DateTime para trazabilidad).
* **Capa de Presentación:** Utiliza un gestor de estado robusto (BLoC o Riverpod). La lógica de la interfaz debe estar separada de la lógica de negocio.

## 2. Definición de Entidades y Relaciones Críticas

El modelo debe respetar la jerarquía del esquema relacional consolidado:

* **Trazabilidad de Origen:** Control de `PROVEEDOR` vinculado a un inventario de `GANADO` (identificado por código de arete y monitoreo de salud).
* **Ciclo Industrial:** La `PRODUCCION_LECHE` por turno debe ligarse a un `PROCESO_INDUSTRIAL` específico (Pasteurización, UHT).
* **El Gatekeeper de Calidad:** La entidad `CONTROL_CALIDAD` es el punto de control mandatorio. Un producto no puede existir en inventario sin una validación aprobada.
* **Flujo Comercial:** Gestión de `PRODUCTO` terminado, organización por `LOTE` y proceso de ventas (`CLIENTE`, `PEDIDO`, `DETALLE_PEDIDO`).
* **Estructura Organizacional:** Jerarquía por `DEPARTAMENTO` y `EMPLEADO` para auditoría de acciones.

## 3. Lógica de Negocio Crítica (Regla de Oro)

Implementa conceptualmente el caso de uso `ValidarYCrearLote`:

* **Criterio de Aceptación:** El sistema debe evaluar el pH del análisis. Rango óptimo: **6.4 a 6.8**.
* **Condición de Éxito:** Solo si el pH está en rango Y el resultado es "Aprobado", el sistema permite instanciar un registro en la tabla `LOTE` con estado "Disponible".
* **Condición de Fallo:** Cualquier valor fuera de rango debe marcar el lote como "Rechazado" y bloquear su disponibilidad para ventas.

## 4. Estrategia de Interfaz Adaptativa (UX/UI)

Diseña un sistema de navegación que detecte el tipo de hardware (Multiplataforma):

* **Desktop/Web:** Navegación mediante `NavigationRail` lateral para maximizar el espacio de trabajo administrativo.
* **Mobile (Android/iOS):** Navegación mediante `BottomNavigationBar` adaptada para uso con el pulgar en campo (ranchos/almacenes).
* **Módulos Principales:** Producción, Inventario y Ventas.

## 5. Estructura de Proyecto y Dependencias

* Configura un contenedor de **Inyección de Dependencias** (Service Locator) para desacoplar los servicios de los repositorios.
* Define una estructura de carpetas que permita a un equipo de 10 desarrolladores trabajar en módulos independientes (Feature-first o Layer-first).

---

### ¿Por qué este prompt funciona mejor para una IA?

1. **Establece jerarquías:** No le pide "una app", le pide una "estructura de capas", lo que fuerza a la IA a organizar el pensamiento antes de proponer nada.
2. **Define el "Gatekeeper":** Al llamar a la calidad el "punto de control mandatorio", la IA entiende que esa es la validación más importante del sistema.
3. **Especificidad sin código:** Al dar los rangos de pH y las reglas de navegación, le das las "instrucciones lógicas" sin necesidad de escribir una sola línea de Dart, dejando que la IA proponga la mejor implementación técnica.

¿Te gustaría que añadiera un apartado sobre cómo debe la IA manejar la **seguridad y los permisos de usuario** (quién puede ver qué)?
