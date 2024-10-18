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
    public partial class YourOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["user_id"] == null)
            {
                Response.Redirect("UserLogin.aspx");
            }
            else
            {
                string userId = Session["user_id"].ToString();
                BindOrders(userId);
            }
        }



        private void BindOrders(string userId)
        {
            DataTable OrderData = GetOrderData(userId);

            if (OrderData.Rows.Count > 0)
            {
                ordersListView.DataSource = OrderData;
                ordersListView.DataBind();
            }
            else
            {
                ordersListView.Visible = false;
                // Optionally, display a message indicating that the wishlist is empty.
                // Example: lblMessage.Text = "Your wishlist is empty.";
            }
        }

        private DataTable GetOrderData(string userId)
        {
            DataTable dt = new DataTable();

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"SELECT dbo.[order].Order_id, dbo.[order].user_id, dbo.Order_detail.Product_Name, dbo.Order_detail.Quantity, dbo.Order_detail.Price, dbo.[Order].Order_date, dbo.[Order].Order_status 
                    FROM dbo.[Order] left outer JOIN dbo.Order_detail ON dbo.[Order].Order_id = dbo.Order_detail.Order_id where user_id ='" + userId + "'";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@UserID", userId);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during data retrieval
                // Log the exception details if needed
                // LogException(ex);
            }

            return dt;
        }

    }



















    //        if (!IsPostBack)
    //        {
    //            BindOrders();
    //        }
    //    }
    //    private void BindOrders()
    //    {
    //        string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString; // Update with your actual connection string
    //                                                                                                  //string query = "SELECT OrderDetails.Product_Name, OrderDetails.Quantity, OrderDetails.Price " +
    //                                                                                                  // "FROM OrderDetails " +
    //                                                                                                  // "INNER JOIN Orders Orders.Order_date,Orders.Order_status,ON OrderDetails.OrderID = Orders.OrderID";

    //        string query = "SELECT dbo.Order_detail.Product_Name, dbo.Order_detail.Quantity, dbo.Order_detail.Price, dbo.[Order].Order_date, dbo.[Order].Order_status " +
    //            "FROM dbo.[Order] INNER JOIN "+"dbo.Order_detail ON dbo.[Order].Order_id = dbo.Order_detail.Order_id";


    //        using (SqlConnection connection = new SqlConnection(connectionString))
    //        {
    //            using (SqlCommand command = new SqlCommand(query, connection))
    //            {
    //                connection.Open();
    //                SqlDataAdapter adapter = new SqlDataAdapter(command);
    //                DataTable dataTable = new DataTable();
    //                adapter.Fill(dataTable);
    //                lvOrders.DataSource = dataTable;
    //                lvOrders.DataBind();
    //            }
    //        }
    //    }
    //}
}