-- Script de creación de Base de Datos para Sistema LALA
-- Nombre sugerido: bdlala.sql

CREATE DATABASE IF NOT EXISTS bdlala;
USE bdlala;

-- 1. DEPARTAMENTO (Maestra)
CREATE TABLE DEPARTAMENTO (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    descripcion TEXT,
    responsable_id INT -- Se relacionará después con EMPLEADO
);

-- 2. EMPLEADO (Maestra)
CREATE TABLE EMPLEADO (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    id_departamento INT,
    nombre VARCHAR(120) NOT NULL,
    numero_empleado VARCHAR(20) UNIQUE NOT NULL,
    puesto VARCHAR(80) NOT NULL,
    turno ENUM('Mañana', 'Tarde', 'Noche'),
    fecha_ingreso DATE,
    contacto VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_empleado_depto FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento)
);

-- Relación circular: El responsable de departamento es un empleado
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT fk_depto_responsable FOREIGN KEY (responsable_id) REFERENCES EMPLEADO(id_empleado);

-- 3. PROVEEDOR (Maestra)
CREATE TABLE PROVEEDOR (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(120) NOT NULL,
    rfc CHAR(13) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    estado VARCHAR(60),
    activo BOOLEAN DEFAULT TRUE
);

-- 4. GANADO
CREATE TABLE GANADO (
    id_ganado INT PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT,
    codigo_arete VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(60),
    raza VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE,
    sexo CHAR(1) NOT NULL,
    estado_salud ENUM('Sana', 'Enferma', 'Cuarentena'),
    activa BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_ganado_proveedor FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

-- 5. PRODUCCION_LECHE
CREATE TABLE PRODUCCION_LECHE (
    id_produccion INT PRIMARY KEY AUTO_INCREMENT,
    id_ganado INT,
    id_empleado INT,
    fecha_hora DATETIME NOT NULL,
    turno ENUM('Mañana', 'Tarde', 'Noche') NOT NULL,
    litros DECIMAL(8,2) NOT NULL,
    temperatura_c DECIMAL(4,1),
    calidad ENUM('A', 'B', 'C'),
    observaciones TEXT,
    CONSTRAINT fk_prod_ganado FOREIGN KEY (id_ganado) REFERENCES GANADO(id_ganado),
    CONSTRAINT fk_prod_empleado FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

-- 6. PROCESO_INDUSTRIAL
CREATE TABLE PROCESO_INDUSTRIAL (
    id_proceso INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    tipo_proceso VARCHAR(60) NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME,
    litros_entrada DECIMAL(10,2) NOT NULL,
    temperatura_proceso DECIMAL(5,1),
    estado ENUM('En curso', 'Completado', 'Error') NOT NULL,
    CONSTRAINT fk_proceso_empleado FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

-- 7. CONTROL_CALIDAD
CREATE TABLE CONTROL_CALIDAD (
    id_control INT PRIMARY KEY AUTO_INCREMENT,
    id_proceso INT UNIQUE,
    id_empleado INT,
    fecha_analisis DATE NOT NULL,
    ph DECIMAL(4,2),
    grasa_pct DECIMAL(4,2),
    proteina_pct DECIMAL(4,2),
    bacterias_ufc INT,
    resultado ENUM('Aprobado', 'Rechazado', 'Condicional') NOT NULL,
    CONSTRAINT fk_calidad_proceso FOREIGN KEY (id_proceso) REFERENCES PROCESO_INDUSTRIAL(id_proceso),
    CONSTRAINT fk_calidad_empleado FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

-- 8. PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    id_proceso INT,
    nombre VARCHAR(120) NOT NULL,
    categoria VARCHAR(60),
    presentacion VARCHAR(60),
    cantidad_producida DECIMAL(10,2),
    precio_lista DECIMAL(10,2),
    fecha_caducidad DATE NOT NULL,
    CONSTRAINT fk_producto_proceso FOREIGN KEY (id_proceso) REFERENCES PROCESO_INDUSTRIAL(id_proceso)
);

-- 9. LOTE
CREATE TABLE LOTE (
    id_lote INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    codigo_lote VARCHAR(30) UNIQUE NOT NULL,
    cantidad INT NOT NULL,
    almacen VARCHAR(60),
    temperatura_almacen DECIMAL(4,1),
    estado ENUM('Disponible', 'Reservado', 'Agotado') NOT NULL,
    CONSTRAINT fk_lote_producto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- 10. CLIENTE (Maestra)
CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    rfc CHAR(13),
    tipo ENUM('Mayorista', 'Detallista', 'Directo') NOT NULL,
    direccion VARCHAR(255),
    contacto VARCHAR(100),
    credito_limite DECIMAL(12,2),
    activo BOOLEAN DEFAULT TRUE
);

-- 11. PEDIDO
CREATE TABLE PEDIDO (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_pedido DATE NOT NULL,
    fecha_entrega DATE,
    estado ENUM('Pendiente', 'Surtido', 'Entregado', 'Cancelado') NOT NULL,
    total DECIMAL(12,2),
    notas TEXT,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- 12. DETALLE_PEDIDO
CREATE TABLE DETALLE_PEDIDO (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_lote INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    CONSTRAINT fk_detalle_lote FOREIGN KEY (id_lote) REFERENCES LOTE(id_lote)
);