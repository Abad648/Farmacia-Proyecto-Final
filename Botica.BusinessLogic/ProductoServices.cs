using Botica.Data.Infrastructure;
using Botica.Entities;

namespace Botica.BusinessLogic
{
    public class ProductoServices
    {
        private readonly IProducto _productoDB;

        public ProductoServices(IProducto productoDB)
        {
            _productoDB = productoDB;
        }
        public List<Producto> GetProductos()
        {
            return _productoDB.Listar();
        }
        public Producto GetById(int id)
        {
            return _productoDB.ObtenerPorId(id);
        }
    }
}
