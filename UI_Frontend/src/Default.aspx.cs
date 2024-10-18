using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductData();
            }
        }

        private void BindProductData()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
                {
                    connection.Open();

                    // Select 40 random products from the ProductsAll table
                    string query = "SELECT TOP 8 ProductId, ProductName, Price, ImageUrl FROM ProductsAll ORDER BY NEWID()";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable dataTable = new DataTable();
                            adapter.Fill(dataTable);

                            rptProducts.DataSource = dataTable;
                            rptProducts.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exception
            }
        }

    }
}
