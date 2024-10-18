using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Admin.Views.Admin
{
    public partial class Admin_Management : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in, if not, redirect to login page
            if (Session["email"] == null)
            {
                Response.Redirect("/Views/Login.aspx");
            }

            try
            {
                if (!IsPostBack)
                {
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle the exception here, such as logging it or displaying an error message to the user
                Response.Write("<script>alert('An error occurred while loading data: " + ex.Message + "');</script>");
            }
        }


        // Go button
        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            getAdminByID();
        }

        // Delete Button
        protected void Button2_Click(object sender, EventArgs e)
        {
            DeleteAdminById();
        }

        // Clear Filter Button
        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            LoadAdmins(); // Reload all admins
        }

        // User defined function

        bool checkIfAdminExists()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("SELECT * from Admin where id='" + TextBox1.Text.Trim() + "';", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        void DeleteAdminById()
        {
            if (checkIfAdminExists())
            {
                try
                {
                    SqlConnection con = new SqlConnection(strcon);
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    SqlCommand cmd = new SqlCommand("DELETE from Admin WHERE id='" + TextBox1.Text.Trim() + "'", con);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Response.Write("<script>alert('Admin Deleted Successfully');</script>");
                    clearform();
                    LoadAdmins(); // Reload admins after deletion
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid Member ID');</script>");
            }
        }

        void getAdminByID()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("select * from Admin where id='" + TextBox1.Text.Trim() + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        TextBox1.Text = dr.GetValue(0).ToString();
                        TextBox2.Text = dr.GetValue(1).ToString();
                        TextBox4.Text = dr.GetValue(2).ToString();
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid credentials');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void clearform()
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox4.Text = "";
        }

        void LoadAdmins()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("SELECT * FROM [Admin]", con);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred while loading admins');</script>");
                Console.WriteLine("Error loading admins: " + ex.Message);
            }
        }
    }
}
