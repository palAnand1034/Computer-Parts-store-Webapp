using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin.Views
{
    public partial class Login : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            // Check if both email and password fields are empty
            if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(Txt_pass.Text))
            {
                Response.Write("<script>alert('Please fill in both email and password.');</script>");
                return; // Exit the method
            }

            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("select * from Admin where email='" + TextBox1.Text.Trim() + "' AND password='" + Txt_pass.Text.Trim() + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        Response.Write("<script>alert('" + dr.GetValue(1).ToString() + "');</script>");
                        Session["email"] = dr.GetValue(2).ToString();
                        Session["full_name"] = dr.GetValue(1).ToString();
                    }
                    Response.Redirect("Admin/dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalid credentials');</script>");
                    clearform();
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear session variables
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void clearform()
        {
            TextBox1.Text = ""; // Clear the email textbox
            Txt_pass.Text = ""; // Clear the password textbox
        }

    }
}