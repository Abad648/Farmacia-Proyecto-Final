namespace Botica.Entities
{
    public class Producto
    {
        public int ProductosID { get; set; }
        public string CodigoProducto { get; set; }
        public String NombreProduto { get; set; }
        public int CategoriaID { get; set; }
        public int ProveedorID { get; set; }
        public decimal PrecioCompra {  get; set; }
        public decimal Precioventa {  get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        public string UnidadMedida { get; set; }
        public DateTime? FechaVencimiento { get; set; }
        public string Estado {  get; set; }
    }
}
