using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Comp_peri_ecomm
{
    public partial class OrderSummary : System.Web.UI.Page
    {
        int orderId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCartItems();
            }

            if (Session["TotalPriceWithTaxes"] != null)
            {
                decimal totalPriceWithTaxes = (decimal)Session["TotalPriceWithTaxes"];
                litTotalWithTaxes.Text = totalPriceWithTaxes.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
            }

        }

        private void BindCartItems()
        {
            try
            {
                if (Session["user_id"] != null)
                {
                    string userId = Session["user_id"].ToString();
                    string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "SELECT * FROM Cart1 WHERE user_id = @user_id";
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@user_id", userId);
                            connection.Open();
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            rptCartItems.DataSource = dt;
                            rptCartItems.DataBind();
                        }
                    }
                }
                else
                {
                    // Handle the case when user_id session variable is null
                    // For example, you might redirect the user to the login page or display an error message
                    Response.Redirect("UserLogin.aspx"); // Example of redirecting to the login page
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }



        protected void btnContinue_Click(object sender, EventArgs e)
        {
            string userId = Session["user_id"].ToString();
            try
            {
                // Retrieve user details from the form
                string firstName = this.firstName.Text;
                string lastName = this.lastName.Text;
                string phone = this.phone.Text;
                string email = this.email.Text;
                string address1 = this.address1.Text;
                string address2 = this.address2.Text;
                string state = State.SelectedItem.Text;
                string city = City.SelectedItem.Text;
                string zip = this.zip.Text;

                // Generate current date and time for order date
                DateTime orderDate = DateTime.Now;

                // Default order status
                string orderStatus = "Pending";
                // Insert order details into the Order table
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string insertOrderQuery = @"INSERT INTO [Order] (user_id, First_name, Last_name, Phone_no, Email, Address_1, Address_2, State, City, Zip, Order_date, Order_status)
                                 VALUES (@user_id, @First_name, @Last_name, @Phone_no, @Email, @Address_1, @Address_2, @State, @City, @Zip, @Order_date, @Order_status);
                                 SELECT SCOPE_IDENTITY();"; // Retrieve the newly inserted order ID

                    using (SqlCommand command = new SqlCommand(insertOrderQuery, connection))
                    {
                        command.Parameters.AddWithValue("@user_id", userId);
                        command.Parameters.AddWithValue("@First_name", firstName);
                        command.Parameters.AddWithValue("@Last_name", lastName);
                        command.Parameters.AddWithValue("@Phone_no", phone);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Address_1", address1);
                        command.Parameters.AddWithValue("@Address_2", address2);
                        command.Parameters.AddWithValue("@State", state);
                        command.Parameters.AddWithValue("@City", city);
                        command.Parameters.AddWithValue("@Zip", zip);
                        command.Parameters.AddWithValue("@Order_date", orderDate);
                        command.Parameters.AddWithValue("@Order_status", orderStatus);


                        // Retrieve the newly inserted order ID
                        orderId = Convert.ToInt32(command.ExecuteScalar());

                        // Insert cart items into the Order_detail table
                        string insertOrderDetailQuery = @"
INSERT INTO Order_detail (Order_id, Product_Name, Quantity, Price, Total_price)
SELECT @Order_id, ProductName, Quantity, Price, Quantity * Price
FROM Cart1
WHERE user_id = @user_id;
";
                        using (SqlCommand insertOrderDetailCommand = new SqlCommand(insertOrderDetailQuery, connection))
                        {
                            insertOrderDetailCommand.Parameters.AddWithValue("@Order_id", orderId);
                            insertOrderDetailCommand.Parameters.AddWithValue("@user_id", userId);

                            insertOrderDetailCommand.ExecuteNonQuery();
                        }

                        // Delete cart items after placing the order
                        DeleteCartItems(userId);
                    }
                }

                // Redirect to order confirmation page or perform any other action
                Response.Redirect("Invoice.aspx?Invoice_id=" + orderId);
            }
            catch (Exception ex)
            {
                // Handle any exceptions
            }
        }

        private void DeleteCartItems(string userId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Cart1 WHERE user_id = @userId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@userId", userId);
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
}