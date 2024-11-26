# Proyecto Final "Base empresa"
# Elaborado por: Juan Angel Palizada Pedraza
# Fecha: 08 de Noviembre de 2024

# Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS EmpresaRetroWaveInc_db;

USE EmpresaRetroWaveInc_db;

# Tabla: Categorías
CREATE TABLE IF NOT EXISTS Categorias (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Categoria VARCHAR(50) NOT NULL,
    Descripcion_Categoria TEXT
);

# Tabla: Productos
CREATE TABLE IF NOT EXISTS Productos (
    ID_Producto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Producto VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock_Disponible INT DEFAULT 0,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
);

# Tabla: Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(15),
    Direccion TEXT,
    ID_Suscripcion VARCHAR(20),
    Fecha_Registro DATE,
    Preferencias TEXT
);

# Tabla: Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Pedido DATE NOT NULL,
    ID_Cliente INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    Canal_Venta VARCHAR(30),
    Fecha_Entrega DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

# Tabla: Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    ID_Proveedor INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Proveedor VARCHAR(100) NOT NULL,
    Telefono_Proveedor VARCHAR(15),
    Email_Proveedor VARCHAR(100),
    Direccion_Proveedor TEXT
);

# Tabla: Almacenes
CREATE TABLE IF NOT EXISTS Almacenes (
    ID_Almacen INT PRIMARY KEY AUTO_INCREMENT,
    Ubicacion TEXT NOT NULL,
    Capacidad_Maxima INT NOT NULL
);

# Tabla: Inventario
CREATE TABLE IF NOT EXISTS Inventario (
    ID_Inventario INT PRIMARY KEY AUTO_INCREMENT,
    ID_Producto INT,
    Cantidad_Ingreso INT NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    ID_Proveedor INT,
    ID_Almacen INT,
    Stock_Minimo INT DEFAULT 0,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen)
);

# Tabla: Envíos
CREATE TABLE IF NOT EXISTS Envios (
    ID_Envio INT PRIMARY KEY AUTO_INCREMENT,
    ID_Pedido INT,
    Fecha_Envio DATE,
    Estado_Envio VARCHAR(20),
    Metodo_Envio VARCHAR(20),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido)
);

# Tabla: Marketing y Promociones
CREATE TABLE IF NOT EXISTS Promociones (
    ID_Promocion INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Promocion VARCHAR(50) NOT NULL,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Descuento DECIMAL(5, 2),
    ID_Producto INT,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

# Tabla: Finanzas
CREATE TABLE IF NOT EXISTS Finanzas (
    ID_Transaccion INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_Transaccion ENUM('Ingreso', 'Egreso') NOT NULL,
    Fecha_Transaccion DATE NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    ID_Proveedor INT,
    ID_Pedido INT,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido)
);

# Tabla: Análisis de Ventas
CREATE TABLE IF NOT EXISTS AnalisisVentas (
    ID_Analisis INT PRIMARY KEY AUTO_INCREMENT,
    ID_Producto INT,
    Periodo_Analisis VARCHAR(50),
    Cantidad_Vendida INT NOT NULL,
    Ingresos_Totales DECIMAL(10, 2),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

# ---------------------- Inserción de datos a cada tabla ----------------------

# Inserción en Tabla: Categorías
INSERT INTO Categorias (Nombre_Categoria, Descripcion_Categoria) 
VALUES
('Unidad Principal', 'El dispositivo Walkman con todas sus funcionalidades integradas'),
('Componentes Internos', 'Partes técnicas que permiten el funcionamiento del Walkman'),
('Accesorios', 'Complementos para mejorar la experiencia del usuario'),
('Software', 'Aplicaciones y sistemas operativos que controlan el dispositivo'),
('Conectividad', 'Módulos y adaptadores para streaming y otras conexiones'),
('Repuestos', 'Partes para mantenimiento y reparaciones del Walkman'),
('Cables y Adaptadores', 'Elementos necesarios para carga y conexión'),
('Baterías', 'Sistemas de alimentación para el dispositivo'),
('Carcasas', 'Cubiertas externas del Walkman para personalización'),
('Ediciones Especiales', 'Versiones exclusivas del Walkman Moderno');

# Inserción en Tabla: Productos
INSERT INTO Productos (Nombre_Producto, Descripcion, Precio, Stock_Disponible, ID_Categoria) 
VALUES
('Walkman Moderno RW2024', 'Reproductor principal con soporte para casetes y streaming', 2499.99, 120, 1),
('Módulo Bluetooth 5.0', 'Permite la conectividad inalámbrica con audífonos y otros dispositivos', 499.99, 50, 5),
('Pantalla Táctil OLED', 'Pantalla de alta definición para navegación y configuración', 999.99, 30, 2),
('Audífonos Bluetooth RetroWave', 'Audífonos inalámbricos diseñados específicamente para el Walkman', 799.99, 200, 3),
('Sistema Operativo RW-OS', 'Software que gestiona todas las funciones del dispositivo', 0.00, 500, 4),
('Batería de Litio 5000mAh', 'Batería de larga duración para el Walkman Moderno', 299.99, 100, 8),
('Carcasa Retro Dorada', 'Cubierta personalizable con diseño vintage', 199.99, 150, 9),
('Adaptador USB-C a Jack 3.5mm', 'Conector para audífonos tradicionales', 99.99, 70, 7),
('Reproductor de Casetes Interno', 'Módulo interno para reproducción de casetes', 1499.99, 20, 2),
('Cargador Rápido USB-C', 'Accesorio para carga rápida del dispositivo', 199.99, 80, 7);

# Inserción en Tabla: Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Telefono, Direccion, ID_Suscripcion, Fecha_Registro, Preferencias) 
VALUES
('Carlos', 'López', 'carlos.lopez@gmail.com', '5551234567', 'Av. Siempre Viva 123, CDMX', 'Premium', '2024-11-01', 'Accesorios, Streaming'),
('María', 'González', 'maria.gonzalez@hotmail.com', '5559876543', 'Calle Los Pinos 456, GDL', 'Básica', '2024-11-05', 'Repuestos, Software'),
('Ana', 'Ramírez', 'ana.ramirez@yahoo.com', '5551112233', 'Calle Morelos 789, MTY', 'Premium', '2024-11-08', 'Personalización, Conectividad'),
('Luis', 'Torres', 'luis.torres@gmail.com', '5553332211', 'Paseo Reforma 321, CDMX', 'Básica', '2024-11-10', 'Baterías, Accesorios'),
('Sofía', 'Hernández', 'sofia.hernandez@gmail.com', '5554445566', 'Calle Juárez 567, GDL', 'Premium', '2024-11-12', 'Ediciones Especiales'),
('Pedro', 'Martínez', 'pedro.martinez@gmail.com', '5556667788', 'Calle Hidalgo 890, MTY', 'Básica', '2024-11-14', 'Cables y Adaptadores'),
('Laura', 'Jiménez', 'laura.jimenez@gmail.com', '5558889900', 'Calle Independencia 123, QRO', 'Premium', '2024-11-15', 'Conectividad, Ediciones Especiales'),
('Miguel', 'Castro', 'miguel.castro@gmail.com', '5552223344', 'Av. Hidalgo 567, GDL', 'Básica', '2024-11-16', 'Carcasas, Repuestos'),
('Andrea', 'Pérez', 'andrea.perez@gmail.com', '5557778889', 'Calle Mina 456, CDMX', 'Premium', '2024-11-17', 'Personalización, Streaming'),
('Jorge', 'Mendoza', 'jorge.mendoza@gmail.com', '5559991122', 'Calle Victoria 234, MTY', 'Básica', '2024-11-18', 'Baterías, Accesorios');

# Inserción en Tabla: Pedidos
INSERT INTO Pedidos (Fecha_Pedido, ID_Cliente, ID_Producto, Cantidad, Total, Canal_Venta, Fecha_Entrega) 
VALUES
('2024-11-10', 1, 1, 1, 2499.99, 'Online', '2024-11-15'),
('2024-11-12', 2, 1, 1, 2499.99, 'Tienda Física', '2024-11-17'),
('2024-11-13', 3, 8, 2, 199.98, 'Online', '2024-11-18'),
('2024-11-14', 4, 2, 1, 499.99, 'Tienda Física', '2024-11-19'),
('2024-11-15', 5, 9, 1, 1499.99, 'Online', '2024-11-20'),
('2024-11-16', 6, 6, 2, 399.98, 'Tienda Física', '2024-11-21'),
('2024-11-17', 7, 7, 1, 99.99, 'Online', '2024-11-22'),
('2024-11-18', 8, 10, 1, 199.99, 'Tienda Física', '2024-11-23'),
('2024-11-19', 9, 4, 1, 799.99, 'Online', '2024-11-24'),
('2024-11-20', 10, 3, 3, 297.00, 'Tienda Física', '2024-11-25');

# Inserción en Tabla: Proveedores
INSERT INTO Proveedores (Nombre_Proveedor, Telefono_Proveedor, Email_Proveedor, Direccion_Proveedor) 
VALUES
('TechParts Ltd.', '5551234567', 'contacto@techparts.com', 'Calle Técnica 123, CDMX'),
('RetroComponents Inc.', '5559876543', 'ventas@retrocomponents.mx', 'Av. Industrial 456, GDL'),
('ModernAudio Supplies', '5551122334', 'soporte@modernaudio.mx', 'Parque Comercial 789, MTY'),
('NeoConnect SA', '5552233445', 'info@neoconnect.com', 'Calle Morelos 567, QRO'),
('EliteAudio Co.', '5553344556', 'contacto@eliteaudio.com', 'Calle Reforma 890, CDMX'),
('VintageTech MX', '5554455667', 'ventas@vintagetech.mx', 'Calle Juárez 234, MTY'),
('StreamPlus Ltd.', '5555566778', 'contacto@streamplus.com', 'Av. Insurgentes 678, GDL'),
('WaveTech Solutions', '5556677889', 'soporte@wavetech.mx', 'Parque Industrial 456, León'),
('ClassicParts Corp.', '5557788990', 'info@classicparts.com', 'Calle Hidalgo 123, MTY'),
('AudioPremium', '5558899001', 'ventas@audiopremium.mx', 'Calle Independencia 789, CDMX');

# Inserción en Tabla: Almacenes
INSERT INTO Almacenes (Ubicacion, Capacidad_Maxima) 
VALUES
('CDMX - Central', 500),
('GDL - Regional', 300),
('MTY - Regional', 400),
('QRO - Regional', 200),
('LEON - Regional', 250),
('PUE - Regional', 350),
('MER - Regional', 150),
('TJU - Regional', 200),
('CUN - Regional', 300),
('VER - Regional', 220);

# Inserción en Tabla: Inventario
INSERT INTO Inventario (ID_Producto, Cantidad_Ingreso, Fecha_Ingreso, ID_Proveedor, ID_Almacen, Stock_Minimo) 
VALUES
(1, 120, '2024-11-01', 1, 1, 20),
(2, 50, '2024-11-02', 2, 2, 10),
(3, 500, '2024-11-03', 3, 3, 50),
(4, 200, '2024-11-04', 4, 4, 30),
(5, 30, '2024-11-05', 5, 5, 5),
(6, 100, '2024-11-06', 6, 6, 20),
(7, 150, '2024-11-07', 7, 7, 15),
(8, 70, '2024-11-08', 8, 8, 10),
(9, 20, '2024-11-09', 9, 9, 5),
(10, 80, '2024-11-10', 10, 10, 10);

INSERT INTO Envios (ID_Pedido, Fecha_Envio, Estado_Envio, Metodo_Envio) 
VALUES
(1, '2024-11-11', 'En camino', 'Estandar'),
(2, '2024-11-13', 'Entregado', 'Recolección'),
(3, '2024-11-14', 'Pendiente', 'Rápida'),
(4, '2024-11-15', 'En camino', 'Estandar'),
(5, '2024-11-16', 'En camino', 'Recolección'),
(6, '2024-11-17', 'Pendiente', 'Rápida'),
(7, '2024-11-18', 'Pendiente', 'Estandar'),
(8, '2024-11-19', 'En camino', 'Recolección'),
(9, '2024-11-20', 'Entregado', 'Rápida'),
(10, '2024-11-21', 'Pendiente', 'Estandar');

# Inserción en Tabla: Promociones
INSERT INTO Promociones (Nombre_Promocion, Fecha_Inicio, Fecha_Fin, Descuento, ID_Producto) 
VALUES
('Black Friday - Walkman Moderno', '2024-11-25', '2024-11-30', 20.00, 1),
('Cyber Monday - Módulo Bluetooth', '2024-12-01', '2024-12-05', 15.00, 2),
('Navidad RetroWave', '2024-12-15', '2024-12-25', 25.00, 3),
('Semana del Cliente', '2024-11-20', '2024-11-26', 10.00, 4),
('Año Nuevo RetroWave', '2024-12-30', '2025-01-05', 18.00, 5),
('Combo Walkman + Audífonos', '2024-11-15', '2024-11-20', 12.50, 1),
('Promoción de Otoño', '2024-10-01', '2024-10-15', 5.00, 7),
('Oferta Especial Ediciones Limitadas', '2024-11-18', '2024-11-24', 20.00, 9),
('Descuento por Recompra', '2024-11-01', '2024-11-07', 7.50, 10),
('Aniversario RetroWave Inc.', '2024-11-05', '2024-11-12', 30.00, 6);

# Inserción en Tabla: Finanzas
INSERT INTO Finanzas (Tipo_Transaccion, Fecha_Transaccion, Monto, ID_Proveedor, ID_Pedido) 
VALUES
('Ingreso', '2024-11-10', 2499.99, NULL, 1),
('Ingreso', '2024-11-12', 2499.99, NULL, 2),
('Egreso', '2024-11-01', 60000.00, 1, NULL),
('Egreso', '2024-11-02', 25000.00, 2, NULL),
('Egreso', '2024-11-03', 15000.00, 3, NULL),
('Ingreso', '2024-11-13', 199.98, NULL, 3),
('Ingreso', '2024-11-14', 499.99, NULL, 4),
('Egreso', '2024-11-04', 20000.00, 4, NULL),
('Ingreso', '2024-11-15', 1499.99, NULL, 5),
('Ingreso', '2024-11-16', 399.98, NULL, 6);

# Inserción en Tabla: Analisis de Venta
INSERT INTO AnalisisVentas (ID_Producto, Periodo_Analisis, Cantidad_Vendida, Ingresos_Totales) 
VALUES
(1, 'Noviembre 2024', 2, 4999.98),
(2, 'Noviembre 2024', 1, 499.99),
(3, 'Noviembre 2024', 3, 297.00),
(4, 'Noviembre 2024', 1, 799.99),
(5, 'Noviembre 2024', 1, 1499.99),
(6, 'Noviembre 2024', 2, 399.98),
(7, 'Noviembre 2024', 1, 99.99),
(8, 'Noviembre 2024', 1, 199.99),
(9, 'Noviembre 2024', 1, 1499.99),
(10, 'Noviembre 2024', 1, 199.99);

# ---------------------- Consultas a la base de datos ----------------------

# Productos con Bajo Stock
# Identifica productos cuyo inventario está por debajo del mínimo establecido:
SELECT Nombre_Producto, Stock_Disponible, Stock_Minimo 
FROM Inventario i 
JOIN Productos p ON i.ID_Producto = p.ID_Producto 
WHERE Stock_Disponible < Stock_Minimo;

# Ventas por Cliente
# Genera un reporte de las compras realizadas por un cliente en un periodo específico:
SELECT c.Nombre, c.Apellido, p.Nombre_Producto, pe.Cantidad, pe.Total 
FROM Clientes c 
JOIN Pedidos pe ON c.ID_Cliente = pe.ID_Cliente 
JOIN Productos p ON pe.ID_Producto = p.ID_Producto 
WHERE c.ID_Cliente = 1 AND pe.Fecha_Pedido BETWEEN '2024-11-01' AND '2024-11-30';


