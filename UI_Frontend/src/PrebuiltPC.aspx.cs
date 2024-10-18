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
    public partial class PrebuitPC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Connect to your database and fetch product data from the product table
                // Replace with your actual connection string
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
                {
                    connection.Open();

                    string query = "SELECT ProductID, ProductName, Price, ImageUrl FROM ProductsAll WHERE Category= 'Prebuilt'";

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
        }
    }
}