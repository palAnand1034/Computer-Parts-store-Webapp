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
    public partial class contactus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in
            //if (Session["uname"] == null)
            //{
            //    // Redirect to login page if not logged in
            //    Response.Redirect("UserLogin.aspx");
            //}
        }
        protected void btnSendFeedback_Click(object sender, EventArgs e)
        {
            string Name = txtFeedbackName.Text;
            string Email = txtFeedbackEmail.Text;
            string Messages = txtFeedbackMessage.Text;

            // Insert feedback into database
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))

            {
                string query = "INSERT INTO Feedback (Name, Email, Messages) VALUES (@Name, @Email, @Messages)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", Name);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Messages", Messages);
                try
                {
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        // Feedback submitted successfully
                        msg.InnerText = "Feedback recorded successfully!";
                        txtFeedbackName.Text = "";
                        txtFeedbackEmail.Text = "";
                        txtFeedbackMessage.Text = "";
                    }
                    else
                    {
                        // Feedback submission failed
                        msg.InnerText = "Error: Feedback not submitted.";
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception
                    // Display error message
                    msg.InnerText = "An error occurred while submitting feedback.";
                }
            }
        }
    }
}
