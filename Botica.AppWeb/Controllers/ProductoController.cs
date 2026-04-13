using Botica.AppWeb.Models;
using Botica.BusinessLogic;
using Microsoft.AspNetCore.Mvc;

namespace Botica.AppWeb.Controllers
{
    public class ProductoController : Controller
    {
        private readonly ProductoServices services;

        public ProductoController(ProductoServices services)
        {
            this.services = services;
        }
        public IActionResult Index()
        {
            var listado = services.GetProductos()
                                  .Select(p => new ProductoVM
                                  {
                                      ProductosID = p.ProductosID,
                                      NombreProduto = p.NombreProduto,
                                      Precioventa = p.Precioventa,
                                      StockActual = p.StockActual,
                                   }).ToList();
            return View(listado);
        }
        public IActionResult Create()
        {
            return View(new ProductoVM());
        }
        [HttpPost]
        public IActionResult Create(ProductoVM model) 
        {
            if (!ModelState.IsValid)
            
                return View(model);
            
            return RedirectToAction("Index");
        }
        
        public IActionResult Edit(int id)
        {
            var producto = services.GetById(id);
            if (producto == null)
                return NotFound();

            var productoVM = new ProductoVM
            {
                ProductosID = producto.ProductosID,
                NombreProduto = producto.NombreProduto,
                Precioventa = producto.Precioventa,
                StockActual = producto.StockActual,
                Estado = producto.Estado
            };
            return View(productoVM);
        }
        [HttpPost]
        public IActionResult Edit(ProductoVM model)
        {
            if (!ModelState.IsValid)
                return View(model);
            return RedirectToAction("Index");
        }
        public IActionResult Delete(int id)
        {
            var producto = services.GetById(id);
            if (producto == null)
                return NotFound();
            var productoVM = new ProductoVM
            {
                ProductosID = producto.ProductosID,
                NombreProduto = producto.NombreProduto,
                Precioventa = producto.Precioventa,
            };

            return View(productoVM);
        }
        [HttpPost]
        public IActionResult Delete(ProductoVM model)
        {
            services.Eliminar(model.ProductosID);
            return RedirectToAction("Index");
        }
    }
}
