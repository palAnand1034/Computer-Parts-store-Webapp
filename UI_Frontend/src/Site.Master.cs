using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Comp_peri_ecomm
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateUI();
            }
            BindCategory();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string userSearchInput = txtSearch.Text.Trim();
            userSearchInput = SanitizeUserInput(userSearchInput);
            Session["SearchQuery"] = userSearchInput;
            Response.Redirect("SearchResults.aspx");
        }

        private string SanitizeUserInput(string input)
        {
            input = input.Replace("'", "''");
            return input;
        }

        private void BindCategory()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
                {
                    connection.Open();

                    string query = "  select distinct Category from ProductsAll";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable dataTable = new DataTable();
                            adapter.Fill(dataTable);

                            rptCategories.DataSource = dataTable;
                            rptCategories.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exception
            }
        }

        private void UpdateUI()
        {
            if (Session["role"] == null)
            {
                ShowGuestLinks();
            }
            else if (Session["role"].Equals("user"))
            {
                ShowUserLinks();
            }
        }

        private void ShowGuestLinks()
        {
            User_login.Visible = true; // User login link button
            User_signup.Visible = true; // Sign up link button
            Logout.Visible = false; // Logout link button
            After_log.Visible = false; // Hello user link button
        }

        private void ShowUserLinks()
        {
            User_login.Visible = false; // User login link button
            User_signup.Visible = false; // Sign up link button
            Logout.Visible = true; // Logout link button
            After_log.Visible = true; // Hello user link button
            After_log.Text = "Hello " + Session["user_id"].ToString();
            After_log_main.Visible = true;
        }

        //private void ShowAdminLinks()
        //{
        //    User_login.Visible = false; // User login link button    
        //    User_signup.Visible = false; // Sign up link button
        //    Logout.Visible = true; // Logout link button
        //    After_log.Visible = true; // Hello user link button
        //    After_log.Text = "Hello Admin ";
        //    Admin_log.Visible = true; // Admin login link button
        //    Product_management.Visible = false; // Movie Management link button
        //}

        //protected void Admin_log_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("adminlogin.aspx");
        //}

        //protected void Product_management_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("adminPage.aspx");
        //}

        protected void User_login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Userlogin.aspx");
        }

        protected void User_signup_Click(object sender, EventArgs e)
        {
            Response.Redirect("Signup.aspx");
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear user-related session variables
            Session["user_id"] = null;
            Session["full_name"] = null;
            Session["role"] = null;

            // Clear cart items from session
            Session["CartItems"] = null;

            // Redirect to the default page
            Response.Redirect("Default.aspx");
        }



        protected void After_log_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}