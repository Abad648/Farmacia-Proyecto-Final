using System;
using System.Collections.Generic;
using System.Text;

namespace Botica.Data.Infrastructure
{
    public interface IGeneric<Entity> where Entity : class
    {
        List<Entity> Listar();
        Entity ObtenerPorId(int id);
        int Registrar(Entity entity);
        bool Modificar (Entity entity);
        bool Eliminar(int id);
    }
}
