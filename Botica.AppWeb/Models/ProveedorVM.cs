namespace Botica.AppWeb.Models
{
    public class ProveedorVM
    {
        public int ProveedorID { get; set; }
        public string nombre { get; set; }
        public string contacto { get; set; }
        public string telefono { get; set; }
        public string email { get; set; }
        public string direccion { get; set; }
         public DateTime? Fecharegistro { get; set; }
    }
}
