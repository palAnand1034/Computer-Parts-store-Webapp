using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class SearchResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the search query from the session
                string searchQuery = Session["SearchQuery"] as string;

                if (!string.IsNullOrEmpty(searchQuery))
                {
                    // Perform the database search and populate a DataTable dt with the filtered search results
                    DataTable dt = PerformFilteredSearch(searchQuery);

                    // Bind the filtered search results to the Repeater control
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                }
            }
        }

        private DataTable PerformFilteredSearch(string searchQuery)
        {
            // Perform the database search and return the results as a DataTable.

            string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string sql = @"
                    SELECT ProductID, ProductName, Price, ImageUrl
                    FROM ProductsAll
                    WHERE (
                        LOWER(ProductName) LIKE '%' + REPLACE(@searchQuery, '%', '____') + '%' ESCAPE '_'
                        OR LOWER(Category) LIKE '%' + REPLACE(@searchQuery, '%', '____') + '%' ESCAPE '_'
                    )";

                using (SqlCommand cmd = new SqlCommand(sql, connection))
                {
                    cmd.Parameters.AddWithValue("@searchQuery", searchQuery.ToLower());

                    // Execute query and handle results
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

   
    }
}
