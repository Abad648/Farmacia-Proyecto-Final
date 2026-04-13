CREATE DATABASE BoticaDB;
GO

USE BoticaDB;
GO

CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200),
    FechaCreacion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Proveedores (
    ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(200),
    FechaRegistro DATETIME DEFAULT GETDATE()
);

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    CodigoProducto VARCHAR(20) UNIQUE NOT NULL,
    NombreProducto VARCHAR(150) NOT NULL,
    CategoriaID INT,
    ProveedorID INT,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    StockActual INT DEFAULT 0,
    StockMinimo INT DEFAULT 10,
    UnidadMedida VARCHAR(20) DEFAULT 'UNIDAD',
    FechaVencimiento DATE,
    Estado VARCHAR(20) DEFAULT 'ACTIVO',
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);


CREATE INDEX IX_Productos_Codigo ON Productos(CodigoProducto);
CREATE INDEX IX_Productos_Stock ON Productos(StockActual);


INSERT INTO Categorias (Nombre, Descripcion) VALUES 
('Analgésicos', 'Medicamentos para dolor'),
('Antibióticos', 'Medicamentos antibacterianos'),
('Vitaminas', 'Suplementos vitamínicos');

INSERT INTO Proveedores (Nombre, Contacto, Telefono, Email) VALUES 
('Laboratorios Pfizer', 'Juan Pérez', '555-0101', 'pfizer@lab.com'),
('Roche Argentina', 'María Gómez', '555-0102', 'roche@lab.com');

INSERT INTO Productos (CodigoProducto, NombreProducto, CategoriaID, ProveedorID, PrecioCompra, PrecioVenta, StockActual, StockMinimo, FechaVencimiento, Estado) VALUES 
('PAR001', 'Paracetamol 500mg', 1, 1, 2.50, 4.00, 150, 20, '2027-06-30', 'ACTIVO'),
('IBA001', 'Ibuprofeno 400mg', 1, 1, 3.00, 5.50, 80, 15, '2027-05-15', 'ACTIVO');

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ListarProductos')
DROP PROC ListarProductos
GO

CREATE PROC ListarProductos
AS
BEGIN
    SELECT 
        ProductoID,
        CodigoProducto,
        NombreProducto,
        CategoriaID,
        ProveedorID,
        PrecioCompra,
        PrecioVenta,
        StockActual,
        StockMinimo,
        UnidadMedida,
        FechaVencimiento,
        Estado
    FROM Productos
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ObtenerProducto')
DROP PROC ObtenerProducto
GO

CREATE PROC ObtenerProducto
    @Id INT
AS
BEGIN
    SELECT 
        ProductoID,
        CodigoProducto,
        NombreProducto,
        CategoriaID,
        ProveedorID,
        PrecioCompra,
        PrecioVenta,
        StockActual,
        StockMinimo,
        UnidadMedida,
        FechaVencimiento,
        Estado
    FROM Productos
    WHERE ProductoID = @Id
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'RegistrarProducto')
DROP PROC RegistrarProducto
GO

CREATE PROC RegistrarProducto
(
    @CodigoProducto VARCHAR(20),
    @NombreProducto VARCHAR(150),
    @CategoriaID INT,
    @ProveedorID INT,
    @PrecioCompra DECIMAL(10,2),
    @PrecioVenta DECIMAL(10,2),
    @StockActual INT,
    @StockMinimo INT,
    @UnidadMedida VARCHAR(20),
    @FechaVencimiento DATE,
    @Estado VARCHAR(20)
)
AS
BEGIN
    INSERT INTO Productos
    (
        CodigoProducto,
        NombreProducto,
        CategoriaID,
        ProveedorID,
        PrecioCompra,
        PrecioVenta,
        StockActual,
        StockMinimo,
        UnidadMedida,
        FechaVencimiento,
        Estado
    )
    VALUES
    (
        @CodigoProducto,
        @NombreProducto,
        @CategoriaID,
        @ProveedorID,
        @PrecioCompra,
        @PrecioVenta,
        @StockActual,
        @StockMinimo,
        @UnidadMedida,
        @FechaVencimiento,
        @Estado
    )

    SELECT SCOPE_IDENTITY()
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ActualizarProducto')
DROP PROC ActualizarProducto
GO

CREATE PROC ActualizarProducto
(
    @ProductoID INT,
    @NombreProducto VARCHAR(150),
    @PrecioVenta DECIMAL(10,2),
    @StockActual INT,
    @Estado VARCHAR(20)
)
AS
BEGIN
    UPDATE Productos
    SET 
        NombreProducto = @NombreProducto,
        PrecioVenta = @PrecioVenta,
        StockActual = @StockActual,
        Estado = @Estado
    WHERE ProductoID = @ProductoID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'EliminarProducto')
DROP PROC EliminarProducto
GO

CREATE PROC EliminarProducto
    @ProductoID INT
AS
BEGIN
    DELETE FROM Productos
    WHERE ProductoID = @ProductoID
END
GO