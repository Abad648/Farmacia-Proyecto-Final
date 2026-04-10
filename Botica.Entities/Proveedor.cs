using System;
using System.Collections.Generic;
using System.Text;

namespace Botica.Entities
{
    public class Proveedor
    {
        public int ProveedorId { get; set; }
        public string nombre { get; set; }
        public string contacto { get; set; }
        public string telefono { get; set; }
        public string email {  get; set; }
        public string direccion {  get; set; }
        public DateTime fecharegistro { get; set; }

    }
}
