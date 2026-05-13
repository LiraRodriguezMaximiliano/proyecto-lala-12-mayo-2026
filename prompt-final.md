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

## RESULTADO

Entendido, colega. Dejamos el código de lado para enfocarnos exclusivamente en la **estrategia de alto nivel** y el **diseño de la solución**. Para que el equipo de 10 desarrolladores trabaje de forma síncrona, necesitamos que el plano arquitectónico esté cristalino.

Aquí tienes la definición conceptual del **Proyecto Antigravity**:

---

## 1. Mapa de la Estructura de Proyecto (Clean Architecture)

Para evitar la deuda técnica, dividiremos el trabajo en tres capas de aislamiento total:

* **Capa de Dominio (El "Cerebro"):** Aquí reside la verdad absoluta del negocio de LALA. Contiene las reglas que no cambian aunque decidamos cambiar la base de datos o el framework de UI. Es donde vive la definición de qué es un "Ganado", qué es un "Lote" y el proceso lógico de validación de calidad.
* **Capa de Datos (La "Infraestructura"):** Se encarga de la comunicación externa. Aquí es donde implementamos los adaptadores para las bases de datos SQL y las APIs. Su única misión es convertir datos crudos en entidades que el "Cerebro" pueda entender.
* **Capa de Presentación (La "Cara"):** Aquí manejamos Flutter. El objetivo es que la UI sea "tonta"; solo debe pintar lo que el gestor de estado (BLoC/Riverpod) le ordene, basándose en lo que dicten los casos de uso del dominio.

---

## 2. Flujo de Trazabilidad y "Regla de Oro"

El sistema debe funcionar como una tubería de datos donde la entidad **CONTROL_CALIDAD** actúa como una válvula inteligente:

1. **Captura en Origen:** El operario en el rancho registra los signos vitales y el estado de salud del ganado. Si un animal está "En Tratamiento", el sistema debe bloquear automáticamente cualquier registro de producción vinculado a ese ID para evitar contaminación.
2. **Transformación Industrial:** La leche recolectada se vincula a un proceso (UHT/Pasteurización). En este punto, los datos son volátiles.
3. **El Punto de Control (Gatekeeper):** Antes de que el inventario se incremente, el sistema exige los parámetros de laboratorio.
* **Validación:** El sistema cruza el pH (6.4–6.8) y los niveles de grasa/proteína.
* **Consecuencia:** Solo si estos valores son óptimos, el sistema "autoriza" la creación de un objeto **LOTE** con estado "Disponible". Si no, el lote nace con estado "Rechazado" o "Subproducto".



---

## 3. Estrategia de Interfaz Adaptativa (Multiplataforma)

Dado que es un ERP para diversos perfiles de usuario, la navegación debe mutar según el contexto físico:

* **Operador de Campo (Mobile):** Diseño optimizado para una sola mano. Botones grandes, escaneo de códigos QR para los aretes del ganado y navegación inferior (Bottom Bar).
* **Analista de Calidad (Tablet/Desktop):** Pantallas con tablas de datos densas, gráficas de tendencia de pH y un panel de navegación lateral (Navigation Rail) para aprovechar el ancho de pantalla.
* **Ventas y Logística (Web/Desktop):** Enfocado en la gestión de pedidos masivos, con flujos de trabajo multiventana y atajos de teclado.

---

## 4. Gestión de Dependencias y Estado

Para que el equipo de 10 personas no cree un "espagueti" de conexiones:

* **Inyección de Dependencias:** Usaremos un contenedor centralizado. Si un desarrollador necesita acceder a la base de datos de inventario, no la instancia directamente; se la pide al contenedor. Esto permite que, para las pruebas unitarias, podamos intercambiar la base de datos real por una falsa (Mock) sin tocar una sola línea de lógica.
* **Gestión de Estado Reactivo:** Cada pantalla tendrá su propio controlador lógico. Esto separa la animación de la interfaz de la lógica de procesamiento, permitiendo que un desarrollador trabaje en el diseño mientras otro trabaja en el algoritmo de cálculo de subtotales.

---

Este enfoque garantiza que el **Proyecto Antigravity** sea robusto, testeable y, sobre todo, que cumpla con los estándares de una empresa de clase mundial como LALA.

¿En qué pilar del roadmap te gustaría que profundizáramos ahora: en el flujo de **Logística y Ventas** o en la estructura de **Capital Humano y Permisos**?
