using System;
using System.Collections.Generic;
using System.Text;

namespace Botica.Entities
{
    public class Categoria
    {
        public int CategoriaId { get; set; }
        public String Nombre { get; set; }
        public string Descripcion {  get; set; }
        public DateTime FechaCreacion { get; set; }
    }
}
