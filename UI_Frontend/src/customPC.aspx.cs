using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Comp_peri_ecomm
{
    public partial class custompc : System.Web.UI.Page
    {
        // Define a Table to hold selected products.
        protected Table selectedProductsTable = new Table();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if it's a postback to prevent overwriting the table.
            if (!IsPostBack)
            {
                // You can add your initial Page_Load logic here.
            }
        }


        protected void ddlComponent_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            string componentType = ddl.ID; // Get the ID of the dropdown to determine the component type.

            // Fetch data from the database based on the component type.
            DataTable componentData = FetchDataFromDatabase(componentType);

            if (componentData != null && componentData.Rows.Count > 0)
            {
                ddl.DataSource = componentData;
                ddl.DataTextField = "ProductName";
                ddl.DataValueField = "Price";
                ddl.DataBind();
            }

            // Call the method to update the total amount.
            UpdateTotalAmount();
        }

        private DataTable FetchDataFromDatabase(string componentType)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MOHITE"].ConnectionString;
            string query = "SELECT ProductName, Price FROM Product WHERE Category = @Category";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Category", componentType);
                    DataTable dataTable = new DataTable();

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        dataTable.Load(reader);
                    }

                    return dataTable;
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            DropDownList selectedDropDown = (DropDownList)sender;
            string category = selectedDropDown.ID; // Assumes the ID of the DropDownList matches the category.

            string productName = selectedDropDown.SelectedItem.Text;
            int price = int.Parse(selectedDropDown.SelectedValue);

            // Add the selected product to the table.
            AddToSelectedProductsTable(category, productName, price);

            // Calculate and update the total amount.
            UpdateTotalAmount();
        }


        private void AddToSelectedProductsTable(string category, string productName, decimal price)
        {
            TableRow row = new TableRow();

            TableCell cellCategory = new TableCell();
            cellCategory.Text = category;

            TableCell cellProductName = new TableCell();
            cellProductName.Text = productName;

            TableCell cellPrice = new TableCell();
            cellPrice.Text = price.ToString("C"); // Display as currency.

            TableCell cellAction = new TableCell();
            Button btnRemove = new Button();
            btnRemove.Text = "Remove";
            btnRemove.CommandArgument = category + "|" + productName;
            btnRemove.Click += RemoveProduct;
            btnRemove.CssClass = "btn btn-danger";
            cellAction.Controls.Add(btnRemove);

            row.Cells.Add(cellCategory);
            row.Cells.Add(cellProductName);
            row.Cells.Add(cellPrice);
            row.Cells.Add(cellAction);

            selectedProductsTable.Rows.Add(row);
        }

        private void UpdateTotalAmount()
        {
            int totalAmount = 0; // Use an integer for the total amount.

            foreach (TableRow row in selectedProductsTable.Rows)
            {
                int price;
                if (int.TryParse(row.Cells[2].Text, out price))
                {
                    totalAmount += price;
                }
            }

            // Display the total amount with the currency symbol.
            totalAmountCell.Text = string.Format("Total Cost: ₹ {0:N}", totalAmount);
        }



        protected void RemoveProduct(object sender, EventArgs e)
        {
            Button btnRemove = (Button)sender;
            string[] args = btnRemove.CommandArgument.Split('|');
            string category = args[0];
            string productName = args[1];

            // Find and remove the row from the table.
            foreach (TableRow row in selectedProductsTable.Rows)
            {
                if (row.Cells[0].Text == category && row.Cells[1].Text == productName)
                {
                    selectedProductsTable.Rows.Remove(row);
                    break;
                }
            }

            // Recalculate and update the total amount.
            UpdateTotalAmount();
        }
    }
}
