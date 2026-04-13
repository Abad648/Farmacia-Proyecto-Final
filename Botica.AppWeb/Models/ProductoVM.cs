namespace Botica.AppWeb.Models
{
    public class ProductoVM
    {
        public int ProductosID { get; set; }
        public string NombreProduto { get; set; }
        public int CategoriaID { get; set; }
        public int proveedorID { get; set; }
        public decimal PrecioCompra { get; set; }
        public decimal Precioventa { get; set; }
        public int StockActual { get; set; }
        public int StockProduto { get; set; }
        public string UnidadMedida { get; set; }
        public DateTime? FechaVencimiento { get; set; }
        public string Estado { get; set; }

    }
}
