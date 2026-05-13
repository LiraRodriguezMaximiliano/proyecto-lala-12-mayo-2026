### Prompt final

Asunto: Definición de Arquitectura Core y Roadmap de Implementación para Proyecto Antigravity (ERP LALA).

Contexto de Alto Nivel:
"Hola. Estoy liderando el proyecto 'Antigravity', un ERP de misión crítica para el grupo lácteo LALA. El objetivo es centralizar la trazabilidad total: desde la salud del ganado en los ranchos proveedores hasta la entrega final de pedidos a clientes mayoristas. Necesito que diseñes la estructura base utilizando Flutter para una implementación verdaderamente multiplataforma (Android, iOS, Web y Windows Desktop), aplicando estándares de ingeniería de software de alto nivel."

Análisis de Datos y Relaciones:
"Basándote en el esquema relacional que hemos consolidado, el sistema debe respetar estrictamente las dependencias de negocio de las siguientes entidades:

Gestión de Origen: Control de PROVEEDOR y un inventario detallado de GANADO (incluyendo raza, código de arete y estado de salud).

Ciclo de Producción: Registro de PRODUCCION_LECHE por animal/turno, vinculado a un PROCESO_INDUSTRIAL (Pasteurización, UHT, etc.).

Calidad y Seguridad Alimentaria: La entidad CONTROL_CALIDAD es el 'gatekeeper' del sistema; debe validar parámetros específicos como pH (rango 6.4–6.8), grasa y proteína antes de que el producto sea liberado.

Logística de Salida: Gestión de PRODUCTO terminado, organización por LOTE en almacén, y un flujo completo de ventas mediante CLIENTE, PEDIDO y DETALLE_PEDIDO.

Capital Humano: Estructura jerárquica mediante DEPARTAMENTO y EMPLEADO, donde estos últimos son los operadores de cada proceso y análisis."

Requerimientos de Arquitectura (Strict Standard):
"No aceptaré una estructura 'monolítica' o simplificada. Exijo una implementación de Clean Architecture dividida de la siguiente manera:

Capa de Dominio (Domain): Define las Entities puras y los Use Cases (Interactors). Por ejemplo: ValidarCalidadLote, RegistrarOrdeñaDiaria, CalcularSubtotalPedido.

Capa de Datos (Data): Implementa el patrón Repository. Crea los Models de Dart que extiendan de las entidades de dominio, incluyendo decoradores para serialización/deserialización (JSON) y mapeo de tipos SQL como ENUM, DECIMAL y DATETIME.

Capa de Presentación (Presentation):

Estado: Usa un gestor robusto (BLoC o Riverpod).

UI Adaptativa: El diseño debe detectar el tipo de dispositivo. En Desktop/Web, usa un NavigationRail lateral; en Mobile, una BottomNavigationBar adaptada a la ergonomía del pulgar.

Inyección de Dependencias: Configura un contenedor (como GetIt) para desacoplar los servicios de los repositorios."

Lógica de Negocio Crítica a Programar:
"Necesito que escribas el código específico para:

Mapeo de Datos: Los modelos de GANADO y PRODUCCION_LECHE con sus validaciones de tipos.

Regla de Oro de Calidad: Una función que evalúe el CONTROL_CALIDAD y que, solo si el resultado es 'Aprobado' y el ph es óptimo, permita instanciar un registro en la tabla LOTE con estado 'Disponible'.

Interfaz Base: El Scaffold principal de Flutter que gestione la navegación entre 'Producción', 'Inventario' y 'Ventas'."

Instrucción Final:
"Actúa como un desarrollador Senior. Comenta el código explicando las decisiones arquitectónicas. El objetivo es que este código sea la base sobre la cual un equipo de 10 desarrolladores pueda construir sin generar deuda técnica. ¿Entendido? Comencemos con la estructura de carpetas y los modelos de la capa de datos."
