
CREATE DATABASE FarmaciaDB;
GO

USE FarmaciaDB;
GO

CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Fabricantes (
    FabricanteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Pais VARCHAR(100),
    Direccion TEXT,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    FechaRegistro DATETIME DEFAULT GETDATE()
);

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    CodigoBarras VARCHAR(50) UNIQUE NOT NULL,
    Nombre VARCHAR(200) NOT NULL,
    Descripcion TEXT,
    CategoriaID INT FOREIGN KEY REFERENCES Categorias(CategoriaID),
    FabricanteID INT FOREIGN KEY REFERENCES Fabricantes(FabricanteID),
    PrecioCompra DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    StockActual INT DEFAULT 0,
    StockMinimo INT DEFAULT 10,
    StockMaximo INT DEFAULT 100,
    UnidadMedida VARCHAR(20) DEFAULT 'UNIDAD', 
    FechaVencimiento DATE,
    Estado VARCHAR(20) DEFAULT 'ACTIVO', 
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Presentaciones (
    PresentacionID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Concentracion VARCHAR(50), 
    FormaFarmaceutica VARCHAR(100), 
    CantidadPorPresentacion INT, 
    PrecioPorPresentacion DECIMAL(10,2)
);

CREATE TABLE Lotes (
    LoteID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    NumeroLote VARCHAR(50) NOT NULL,
    FechaFabricacion DATE,
    FechaVencimiento DATE NOT NULL,
    CantidadInicial INT NOT NULL,
    CantidadActual INT NOT NULL,
    UbicacionAlmacen VARCHAR(100),
    FechaEntrada DATETIME DEFAULT GETDATE()
);

CREATE TABLE Proveedores (
    ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    RUC VARCHAR(20) UNIQUE,
    Direccion TEXT,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Contacto VARCHAR(100),
    Estado VARCHAR(20) DEFAULT 'ACTIVO'
);

CREATE TABLE Compras (
    CompraID INT IDENTITY(1,1) PRIMARY KEY,
    ProveedorID INT FOREIGN KEY REFERENCES Proveedores(ProveedorID),
    FechaCompra DATETIME DEFAULT GETDATE(),
    TipoComprobante VARCHAR(20), 
    Serie VARCHAR(10),
    Numero VARCHAR(20),
    Subtotal DECIMAL(12,2) DEFAULT 0,
    IGV DECIMAL(12,2) DEFAULT 0,
    Total DECIMAL(12,2) DEFAULT 0,
    Estado VARCHAR(20) DEFAULT 'PENDIENTE' 
);

CREATE TABLE DetalleCompras (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    CompraID INT FOREIGN KEY REFERENCES Compras(CompraID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    NumeroLote VARCHAR(50)
);

CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    FechaVenta DATETIME DEFAULT GETDATE(),
    TipoComprobante VARCHAR(20), 
    Serie VARCHAR(10),
    Numero VARCHAR(20),
    Subtotal DECIMAL(12,2) DEFAULT 0,
    IGV DECIMAL(12,2) DEFAULT 0,
    Total DECIMAL(12,2) DEFAULT 0,
    Estado VARCHAR(20) DEFAULT 'COMPLETADA'
);

CREATE TABLE DetalleVentas (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT FOREIGN KEY REFERENCES Ventas(VentaID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(10,2) DEFAULT 0
);

CREATE INDEX IX_Productos_Categoria ON Productos(CategoriaID);
CREATE INDEX IX_Productos_Fabricante ON Productos(FabricanteID);
CREATE INDEX IX_Productos_Codigo ON Productos(CodigoBarras);
CREATE INDEX IX_Lotes_Producto ON Lotes(ProductoID);
CREATE INDEX IX_Lotes_Vencimiento ON Lotes(FechaVencimiento);
CREATE INDEX IX_Ventas_Fecha ON Ventas(FechaVenta);


INSERT INTO Categorias (Nombre, Descripcion) VALUES
('ANALGÉSICOS', 'Medicamentos para el dolor'),
('ANTIBIÓTICOS', 'Antibióticos de amplio espectro'),
('GASTROINTESTINALES', 'Para problemas digestivos'),
('CARDIOVASCULARES', 'Medicamentos para el corazón'),
('DIABÉTICOS', 'Control de glucosa'),
('VITAMINAS', 'Suplementos vitamínicos'),
('DERMATOLÓGICOS', 'Cremas y tratamientos para piel'),
('RESPIRATORIOS', 'Para vías respiratorias'),
('ANTIINFLAMATORIOS', 'Reducción de inflamación');

INSERT INTO Fabricantes (Nombre, Pais) VALUES
('LABORATORIOS ROEMERS', 'PERÚ'),
('INKAFARMA', 'PERÚ'),
('MEGA PHARMA', 'PERÚ'),
('BAGO', 'ARGENTINA'),
('PFIZER', 'ESTADOS UNIDOS'),
('NOVARTIS', 'SUIZA');

INSERT INTO Productos (CodigoBarras, Nombre, CategoriaID, FabricanteID, PrecioCompra, PrecioVenta, StockActual, StockMinimo, UnidadMedida) VALUES
('7753841000012', 'PARACETAMOL 500MG 20 TABLETAS', 1, 1, 2.50, 4.00, 150, 20, 'CAJA'),
('7753841000029', 'IBUPROFENO 400MG 20 TABLETAS', 1, 1, 3.20, 5.50, 80, 15, 'CAJA'),
('7753841000050', 'AMOXICILINA 500MG 21 CÁPSULAS', 2, 2, 8.50, 14.00, 45, 10, 'CAJA'),
('7753841000074', 'OMEPRAZOL 20MG 14 CÁPSULAS', 3, 3, 6.80, 11.50, 30, 10, 'CAJA'),
('7753841000098', 'ATENOLOL 50MG 30 TABLETAS', 4, 4, 4.20, 7.00, 60, 15, 'CAJA'),
('7753841000111', 'METFORMINA 850MG 60 TABLETAS', 5, 1, 5.90, 9.80, 90, 20, 'CAJA');




