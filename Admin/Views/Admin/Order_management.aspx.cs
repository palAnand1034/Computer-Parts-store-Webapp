using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Admin.Views.Admin
{
    public partial class Order_management : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders(); // Initial loading of orders
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            FilterOrders();
        }

        private void LoadOrders()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT * FROM Order_detail";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        GridView1.DataSource = dataTable;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred while loading orders');</script>");
                Console.WriteLine("Error loading orders: " + ex.Message);
            }
        }

        private void FilterOrders()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT * FROM Order_detail WHERE Order_status = @OrderStatus";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@OrderStatus", ddlFilterOrderStatus.SelectedValue);
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        GridView1.DataSource = dataTable;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred while filtering orders');</script>");
                Console.WriteLine("Error filtering orders: " + ex.Message);
            }
        }

        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            LoadOrders(); // Reload all orders
            ddlFilterOrderStatus.SelectedIndex = 0; // Reset filter dropdown to default (select first option)
        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            UpdateOrderStatus();
        }

        private void UpdateOrderStatus()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "UPDATE [Order_detail] SET Order_status = @OrderStatus WHERE Order_id = @OrderId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@OrderStatus", ddlFilterOrderStatus.SelectedValue);
                        command.Parameters.AddWithValue("@OrderId", TextBox1.Text.Trim());
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Order status updated successfully!');</script>");
                            LoadOrders(); // Reload orders after update
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to update order status!');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred while updating order status');</script>");
                Console.WriteLine("Error updating order status: " + ex.Message);
            }
        }
    }
}
