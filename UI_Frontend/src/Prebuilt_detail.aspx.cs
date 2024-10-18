using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class Prebuilt_detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve product details from the database and populate controls
                PopulateProductDetails();
            }
        }

        private void PopulateProductDetails()
        {
            // Retrieve product ID from query string
            int productId = Convert.ToInt32(Request.QueryString["productId"]);

            // Query the database to get product details based on productId
            string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT PCName, PcDesc, Price, ImageUrl FROM Prebuilt WHERE PcID = @ProductId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Populate controls with product details
                            lblProductName.Text = reader["PCName"].ToString();
                            lblDescription.Text = reader["PcDesc"].ToString();
                            lblPrice.Text = reader["Price"].ToString();
                            imgProduct.ImageUrl = reader["ImageUrl"].ToString();
                        }
                    }
                    connection.Close();
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Retrieve product details from the page
            string productName = lblProductName.Text;
            string price = lblPrice.Text;
            int productId = Convert.ToInt32(Request.QueryString["productId"]);

            // Create a new cart item
            CartItem item = new CartItem
            {
                ProductName = productName,
                Price = price,
                ProductId = productId
            };
            ShoppingCart cart = Session["Cart"] as ShoppingCart ?? new ShoppingCart();

            // Add the selected product to the cart
            cart.AddItem(item);

            // Store the updated cart in the session
            Session["Cart"] = cart;

            // Redirect the user to the shopping cart page
            Response.Redirect("Webform2.aspx");
        }

        // Define CartItem class here
        public class CartItem
        {
            public string ProductName { get; set; }
            public string Price { get; set; }
            public int ProductId { get; set; }
            // Add more properties as needed
        }

        // Define ShoppingCart class here
        public class ShoppingCart
        {
            public List<CartItem> Items { get; } = new List<CartItem>();

            public void AddItem(CartItem item)
            {
                Items.Add(item);
            }

            // You can add methods to modify or remove items from the cart as needed
        }
    }
}