using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class Cart : System.Web.UI.Page
    {
        // Cart page pe
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        if (Session["user_id"] != null)
        {
            string userId = Session["user_id"].ToString();
            decimal[] totalDetails = GetCartTotalPriceDetailsFromDatabase(userId);
            litTotalPrice.Text = totalDetails[0].ToString("C", CultureInfo.CreateSpecificCulture("hi-IN")); // Format as rupees
            litCGST.Text = totalDetails[1].ToString("C", CultureInfo.CreateSpecificCulture("hi-IN")); // Format as rupees
            litSGST.Text = totalDetails[2].ToString("C", CultureInfo.CreateSpecificCulture("hi-IN")); // Format as rupees
            decimal totalPriceWithTaxes = totalDetails[0] + totalDetails[1] + totalDetails[2];
            litTotalWithTaxes.Text = totalPriceWithTaxes.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN")); // Format as rupees

            // Store totalPriceWithTaxes in session

            UpdateTotalPriceDetails(userId);
            BindCartItems(userId);
        }
        else
        {
            // Redirect to login page or display a message indicating that the user is not logged in
        }

        if (Session["selectedQuantity"] != null)
        {
            int selectedQuantity = (int)Session["selectedQuantity"];
            SetSelectedQuantity(selectedQuantity);
        }
    }
}




        private void SetSelectedQuantity(int selectedQuantity)
        {
            foreach (ListViewItem item in lvcart.Items)
            {
                DropDownList ddlQuantity = (DropDownList)item.FindControl("ddlQuantity");
                HiddenField hdnQuantity = (HiddenField)item.FindControl("hdnQuantity");
                int maxQuantity = GetMaxQuantityFromProductsAll(); // Retrieve MaxQuantity from ProductsAll table
                ddlQuantity.Items.Clear();
                for (int i = 1; i <= maxQuantity; i++)
                {
                    ddlQuantity.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                // Set the selected value of the dropdown list based on the quantity of the corresponding item in the cart
                ddlQuantity.SelectedValue = hdnQuantity.Value;
            }
        }


        private int GetMaxQuantityFromProductsAll()
        {
            int maxQuantity = 0;
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT MAX(Quantity) FROM ProductsAll";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        object result = command.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            maxQuantity = Convert.ToInt32(result);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
            return maxQuantity;
        }



        private void BindCartItems(string userId)
        {
            try
            {
                DataTable cartItems = GetCartItemsFromDatabase(userId);
                lvcart.DataSource = cartItems;
                lvcart.DataBind();
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }

        private DataTable GetCartItemsFromDatabase(string userId)
        {
            DataTable cartItems = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT C.Cart_ItemId, P.ProductName, C.Quantity, P.Price, P.ImageUrl, PA.Quantity AS MaxQuantity
                FROM Cart1 C
                INNER JOIN ProductsAll P ON C.ProductId = P.ProductID
                INNER JOIN ProductsAll PA ON C.ProductId = PA.ProductID
                WHERE C.user_id = @userId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userId", userId);
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(cartItems);
                }
            }

            return cartItems;
        }

        //protected void lvcart_ItemDataBound(object sender, ListViewItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListViewItemType.DataItem)
        //    {
        //        DataRowView drv = (DataRowView)e.Item.DataItem;
        //        DropDownList ddlQuantity = (DropDownList)e.Item.FindControl("ddlQuantity");

        //        if (ddlQuantity != null && drv != null)
        //        {
        //            int maxQuantity = Convert.ToInt32(drv["Quantity"]);
        //            for (int i = 1; i <= maxQuantity; i++)
        //            {
        //                ddlQuantity.Items.Add(new ListItem(i.ToString(), i.ToString()));
        //            }

        //            ddlQuantity.SelectedValue = drv["Quantity"].ToString();
        //        }
        //    }
        //}

        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlQuantity = (DropDownList)sender;
            ListViewItem item = (ListViewItem)ddlQuantity.NamingContainer;
            HiddenField hdnCartItemId = (HiddenField)item.FindControl("hdnCartItemId");
            int cartItemId = Convert.ToInt32(hdnCartItemId.Value);
            int newQuantity = Convert.ToInt32(ddlQuantity.SelectedValue);
            UpdateCartItemQuantity(cartItemId, newQuantity);

            // Update the session variable with the new selected quantity
            Session["selectedQuantity"] = newQuantity;

            // Recalculate and update the total price
            UpdateTotalPriceDetails(Session["user_id"].ToString());
        }



        private void UpdateCartItemQuantity(int cartItemId, int newQuantity)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Cart1 SET Quantity = @newQuantity WHERE Cart_ItemId = @cartItemId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@newQuantity", newQuantity);
                        command.Parameters.AddWithValue("@cartItemId", cartItemId);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                // Update the total price details after updating the quantity and recalculate the total price
                UpdateTotalPriceDetails(Session["user_id"].ToString());
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }






        protected void lvcart_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            int cartItemId = Convert.ToInt32(lvcart.DataKeys[e.ItemIndex].Value);
            DeleteCartItem(cartItemId);

            // Rebind cart items
            BindCartItems(Session["user_id"].ToString());

            // Update selected quantity and total price details
            UpdateSelectedQuantityAndTotalPrice();
        }

        private void UpdateSelectedQuantityAndTotalPrice()
        {
            if (Session["selectedQuantity"] != null)
            {
                int selectedQuantity = (int)Session["selectedQuantity"];
                SetSelectedQuantity(selectedQuantity);
            }

            UpdateTotalPriceDetails(Session["user_id"].ToString());
        }



        private void DeleteCartItem(int cartItemId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Cart1 WHERE Cart_ItemId = @cartItemId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@cartItemId", cartItemId);
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
        private decimal[] GetCartTotalPriceDetailsFromDatabase(string userId)
        {
            decimal totalPrice = 0;
            decimal cgst = 0;
            decimal sgst = 0;

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT SUM(TotalC_price) FROM Cart1 WHERE user_id = @userId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        var result = command.ExecuteScalar();
                        if (result != DBNull.Value)
                        {
                            totalPrice = Convert.ToDecimal(result);
                            // Calculate CGST and SGST (8% each)
                            cgst = totalPrice * 0.08m;
                            sgst = totalPrice * 0.08m;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }

            return new decimal[] { totalPrice, cgst, sgst };
        }

        private void UpdateTotalPriceDetails(string userId)
        {
            decimal totalPrice = 0;
            decimal cgst = 0;
            decimal sgst = 0;

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT SUM(C.Quantity * P.Price) AS TotalPrice FROM Cart1 C INNER JOIN ProductsAll P ON C.ProductId = P.ProductID WHERE C.user_id = @userId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        var result = command.ExecuteScalar();
                        if (result != DBNull.Value)
                        {
                            totalPrice = Convert.ToDecimal(result);
                            cgst = totalPrice * 0.09m;
                            sgst = totalPrice * 0.09m;
                            // Calculate CGST and SGST (8% each)
                            totalPrice = totalPrice - (totalPrice * 0.18m);
                            
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }

            // Update the total price and taxes sections on the page
            litTotalPrice.Text = totalPrice.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
            litCGST.Text = cgst.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
            litSGST.Text = sgst.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
            decimal totalPriceWithTaxes = totalPrice + cgst + sgst;
            Session["TotalPriceWithTaxes"] = totalPriceWithTaxes;

            litTotalWithTaxes.Text = totalPriceWithTaxes.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));

        }



    }
}
