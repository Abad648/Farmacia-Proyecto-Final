using Botica.Data.Infrastructure;
using Botica.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;

namespace Botica.Data.Repositories
{
    public class ProductoRepository : IProducto
    {
        private readonly string cadenaConexion;

            public ProductoRepository(IConfiguration config)
        {
            cadenaConexion = config["ConnectionStrings:DB"] ?? string.Empty;
        }
            
            public bool Eliminar(int id)
        {
            throw new NotImplementedException();           
        }
            public List<Producto> Listar()
        {
            List<Producto> listado = new List<Producto>();

            using var conexion = new SqlConnection(cadenaConexion);
            using var comando = new SqlCommand("ListarProductos", conexion);

            comando.CommandType = System.Data.CommandType.StoredProcedure;

            conexion.Open();

            using var reader = comando.ExecuteReader();
            
            while (reader.Read())
                listado.Add(ConvertirReaderEnObjeto(reader));

            return listado;
        }
            public bool Modificar(Producto entity)
        {
            throw new NotImplementedException();
        }
            public Producto ObtenerPorId(int id)
        {
            Producto producto = null;

            using var conexion = new SqlConnection(cadenaConexion);
            using var comando = new SqlCommand("ObtenerProducto", conexion);

            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.Parameters.AddWithValue("@Id", id);

            conexion.Open();

            using var reader = comando.ExecuteReader();
            
            if (reader != null &&  reader.HasRows)
            { 
                reader.Read();
                producto = ConvertirReaderEnObjeto(reader);
            }

            return producto;
        }

        public int Registrar(Producto entity)
        {
            throw new NotImplementedException();
        }

        #region PRIVATE METHODS
        
        private Producto ConvertirReaderEnObjeto(SqlDataReader reader)
        {
            return new Producto
            {
                ProductosID = reader.GetInt32(0),
                CodigoProducto = reader.GetString(1),
                NombreProduto = reader.GetString(2),
                CategoriaID = reader.GetInt32(3),
                ProveedorID = reader.GetInt32(4),
                PrecioCompra = reader.GetDecimal(5),
                Precioventa = reader.GetDecimal(6),
                StockActual = reader.GetInt32(7),
                StockMinimo = reader.GetInt32(8),
                UnidadMedida = reader.GetString(9),
                FechaVencimiento = reader.IsDBNull(10) ? null : reader.GetDateTime(10),
                Estado = reader.GetString(11)
            };
        }

        #endregion
    }
}
