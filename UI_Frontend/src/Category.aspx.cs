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
    public partial class Category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindCategoryData();
        }



        private void BindCategoryData()
        {
            string Category = Request.QueryString["Category"];
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
                {
                    connection.Open();

                    string query = "SELECT ProductID, ImageUrl, ProductName, Price, Category FROM ProductsAll WHERE Category = @Category";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameter to prevent SQL injection
                        command.Parameters.AddWithValue("@Category", Category);

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