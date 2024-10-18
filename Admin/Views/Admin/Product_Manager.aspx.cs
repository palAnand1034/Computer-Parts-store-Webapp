using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin.Views.Admin
{
    public partial class Product_Manager : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                if (CheckIfProductExists())
                {
                    Response.Write("<script>alert('Product with this Id already Exist! You cannot add another Product with the same Product id ');</script>");
                }
                else
                {
                    AddNewProduct();
                }
            }
            catch (Exception ex)
            {
                // Handle the exception here, you can log it or show an error message.
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            if (CheckIfProductExists())
            {
                UpdateProduct();
            }
            else
            {
                Response.Write("<script>alert('Product does not exist ');</script>");

            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            if (CheckIfProductExists())
            {
                DeleteProduct();
            }
            else
            {
                Response.Write("<script>alert('Movie does not exist ');</script>");

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            GetProductByID();
        }
        void GetProductByID()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("SELECT * from ProductsAll where ProductID='" + TextBox1.Text.Trim() + "';", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    TextBox2.Text = dt.Rows[0][1].ToString();
                    TextBox3.Text = dt.Rows[0][3].ToString();
                    TextBox6.Text = dt.Rows[0][4].ToString();
                }
                else
                {
                    Response.Write("<script>alert('Invalid Product ID');</script>");
                }


            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");

            }
        }


        void DeleteProduct()
        {
            try
            {

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("DELETE FROM ProductsAll WHERE ProductID = '" + TextBox1.Text.Trim() + "'", con);

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Product Deleted Successfully!');</script>");
                clearform();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }


        void UpdateProduct()
        {
            try
            {
                string selectedCategory = ddlCategory.SelectedItem.Text;
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("UPDATE ProductsAll SET ProductName = @ProductName, Price = @Price, Quantity = @Quantity, ImageUrl = @ImageUrl, Category = @Category WHERE ProductID = @ProductID", con);

                cmd.Parameters.AddWithValue("@ProductID", TextBox1.Text.Trim());
                cmd.Parameters.AddWithValue("@ProductName", TextBox2.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", TextBox3.Text.Trim());
                cmd.Parameters.AddWithValue("@Quantity", TextBox6.Text.Trim());
                cmd.Parameters.AddWithValue("@ImageUrl", TextBox4.Text.Trim());
                cmd.Parameters.AddWithValue("@Category", selectedCategory); // Include the selected category in the parameters

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Product Updated Successfully!');</script>");
                clearform();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        void AddNewProduct()
        {
            try
            {
                string selectedCategory = ddlCategory.SelectedItem.Text; // Get the selected category from the dropdown list

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO ProductsAll(ProductName, Price, Quantity, ImageUrl, Category) VALUES (@ProductName, @Price, @Quantity, @ImageUrl, @Category)", con);
                    cmd.Parameters.AddWithValue("@ProductName", TextBox2.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", TextBox3.Text.Trim());
                    cmd.Parameters.AddWithValue("@Quantity", TextBox6.Text.Trim());
                    cmd.Parameters.AddWithValue("@ImageUrl", TextBox4.Text.Trim());
                    cmd.Parameters.AddWithValue("@Category", selectedCategory); // Include the selected category in the parameters
                    cmd.ExecuteNonQuery();
                }
                Response.Write("<script>alert('Product Added Successfully!');</script>");
                clearform();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred while adding the product.');</script>");
                // Log the error for debugging
                Console.WriteLine("Error adding product: " + ex.Message);
            }
        }

        bool CheckIfProductExists()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("select * from ProductsAll where ProductID='" + TextBox1.Text.Trim() + "';", con);
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
        void clearform()
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
            TextBox4.Text = "";
            TextBox6.Text = "";


        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}