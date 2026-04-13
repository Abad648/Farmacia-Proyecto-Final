using Microsoft.AspNetCore.Mvc;

namespace Botica.AppWeb.Controllers
{
    public class ProductoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
