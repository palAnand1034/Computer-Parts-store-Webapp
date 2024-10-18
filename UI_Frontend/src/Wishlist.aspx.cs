using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


namespace Comp_peri_ecomm
{
    public partial class Wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["user_id"] != null)
                {
                    string userId = Session["user_id"].ToString();
                    BindWishlistItems(userId);
                }
                else
                {
                    // Redirect to login page or display a message indicating that the user is not logged in
                }

            }

        }

        private void BindWishlistItems(string userId)
        {
            try
            {
                DataTable WishlistItems = GetWishlistItemsFromDatabase(userId);
                lvWishlist.DataSource = WishlistItems;
                lvWishlist.DataBind();
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }

        private DataTable GetWishlistItemsFromDatabase(string userId)
        {
            DataTable WishlistItems = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"SELECT W.Wishlist_ItemID, P.ProductName, P.ImageUrl
                            FROM Wishlist W
                            INNER JOIN ProductsAll P ON W.ProductID = P.ProductID
                            WHERE W.user_id = @userId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(WishlistItems);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception or log it
                Console.WriteLine("An error occurred: " + ex.Message);
                // You can rethrow the exception if needed
                // throw;
            }

            return WishlistItems;
        }

        protected void lvWishlist_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            int Wishlist_ItemID = Convert.ToInt32(lvWishlist.DataKeys[e.ItemIndex].Value);
            DeleteWishlistItem(Wishlist_ItemID);
            // Rebind cart items and update total price details
            BindWishlistItems(Session["user_id"].ToString());
        }

        private void DeleteWishlistItem(int Wishlist_ItemID)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;


                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Wishlist WHERE Wishlist_ItemID = @Wishlist_ItemID";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Wishlist_ItemID", Wishlist_ItemID);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }
    }
}