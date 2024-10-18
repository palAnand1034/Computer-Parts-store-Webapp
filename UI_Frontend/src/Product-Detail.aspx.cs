using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class Product_Detail : System.Web.UI.Page
    {
        int maxQuantity;
        string img;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateProductDetails();
            }
        }

        private void PopulateProductDetails()
        {
            try
            {
                int productId = Convert.ToInt32(Request.QueryString["productId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT ProductName, ProductDesc, Price, ImageUrl FROM ProductsAll WHERE ProductID = @ProductId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblProductName.Text = reader["ProductName"].ToString();
                                lblDescription.Text = reader["ProductDesc"].ToString();
                                lblPrice.Text = reader["Price"].ToString();
                                img = reader["ImageUrl"].ToString();
                                imgProduct.ImageUrl = img;

                                // Call the modified method to populate the quantity dropdown
                                PopulateQuantityDropdown(productId);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }

        private void PopulateQuantityDropdown(int productId)
        {
            ddlQuantity.Items.Clear();

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT Quantity FROM ProductsAll WHERE ProductID = @ProductId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        connection.Open();
                        object result = command.ExecuteScalar();
                        if (result != null)
                        {
                            int maxQuantity = Convert.ToInt32(result);

                            for (int i = 1; i <= maxQuantity; i++)
                            {
                                ddlQuantity.Items.Add(new ListItem(i.ToString(), i.ToString()));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }

        private bool IsProductInCart(int productId, string userId)
        {
            bool exists = false;
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Cart1 WHERE ProductID = @ProductId AND user_id = @userId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        int count = (int)command.ExecuteScalar();
                        if (count > 0)
                        {
                            exists = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
            return exists;
        }

        private bool IsProductInWishlist(int productId, string userId)
        {
            bool exists = false;
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Wishlist WHERE ProductID = @ProductId AND user_id = @userId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        int count = (int)command.ExecuteScalar();
                        if (count > 0)
                        {
                            exists = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
            return exists;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                img = imgProduct.ImageUrl;
                string userId = Session["user_id"].ToString();
                int productId = Convert.ToInt32(Request.QueryString["productId"]);
                int selectedQuantity = Convert.ToInt32(ddlQuantity.SelectedValue);
                Session["selectedQuantity"] = selectedQuantity;


                if (!IsProductInCart(productId, userId)) // Check if product is not already in the cart
                {
                    // Ensure img is not null or empty before calling AddToCart
                    if (!string.IsNullOrEmpty(img))
                    {
                        AddToCart(productId, userId, selectedQuantity, lblProductName.Text, lblPrice.Text, img);
                        Response.Redirect("Cart.aspx?productId=" + productId + "&quantity=" + selectedQuantity);
                    }
                    else
                    {
                        // Handle the case where img is null or empty
                        // For example, you can display an error message or log it
                    }
                }
                else
                {
                    // Display alert if the product is already in the cart
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This product is already in your cart.');", true);
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }


        
        private void AddToCart(int productId, string userId, int qty, string prodName, string price, string img)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                // Calculate the total price
                decimal totalPrice = Convert.ToDecimal(price) * qty;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Cart1 (ProductID, user_id, Quantity, ProductName, Price, ImageUrl, totalC_price) VALUES (@productId, @userId, @Quantity, @ProductName, @Price, @ImageUrl, @totalPrice)";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@Quantity", qty);
                        command.Parameters.AddWithValue("@ProductName", prodName);
                        command.Parameters.AddWithValue("@Price", price);
                        command.Parameters.AddWithValue("@ImageUrl", img);
                        command.Parameters.AddWithValue("@TotalPrice", totalPrice); // Add total price parameter
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
        }


        private void UpdateTotalPrice(int productId, decimal totalPrice)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE ProductsAll SET totalC_price = @TotalPrice WHERE ProductID = @ProductId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TotalPrice", totalPrice);
                        command.Parameters.AddWithValue("@ProductId", productId);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                string userId = Session["user_id"].ToString();
                int productId = Convert.ToInt32(Request.QueryString["productId"]);
                img = imgProduct.ImageUrl;

                if (!IsProductInWishlist(productId, userId)) // Check if product is not already in the wishlist
                {
                    AddToWishlist(productId, userId, lblProductName.Text, img);
                    Response.Redirect("Wishlist.aspx");
                }
                else
                {
                    // Display alert if the product is already in the wishlist
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This product is already in your wishlist.');", true);
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }
        private void AddToWishlist(int productId, string userId, string prodName, string img)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Wishlist (ProductID, user_id, ProductName, ImageUrl) VALUES (@productId, @userId, @ProductName, @ImageUrl)";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@ProductName", prodName);
                        command.Parameters.AddWithValue("@ImageUrl", img);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
        }
    }
}
