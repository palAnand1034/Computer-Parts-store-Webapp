using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Comp_peri_ecomm
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    int OrderId = Convert.ToInt32(Request.QueryString["Invoice_id"]);
                    string userId = Session["user_id"].ToString();

                    string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
                    string orderQuery = "SELECT * FROM [Order] WHERE Order_id = @OrderId";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand orderCommand = new SqlCommand(orderQuery, connection))
                        {
                            orderCommand.Parameters.AddWithValue("@OrderId", OrderId);

                            connection.Open();
                            SqlDataReader reader = orderCommand.ExecuteReader();

                            if (reader.Read())
                            {
                                lblAddress1.Text = reader["Address_1"].ToString();
                                lblAddress2.Text = reader["Address_2"].ToString();
                                lblfirst_name.Text = reader["First_name"].ToString() + " " + reader["Last_name"].ToString();
                                lblCity.Text = reader["City"].ToString();
                                lblPhone.Text = reader["Phone_no"].ToString();
                                hypShippingEmail.Text = reader["Email"].ToString();
                                hypShippingEmail.NavigateUrl = "mailto:" + reader["Email"].ToString();
                                litCurrentDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                                // Generate and display the invoice ID
                                string invoiceID = GenerateInvoiceID();
                                lblInvoiceNumber.Text = invoiceID;

                                // Close the first data reader before accessing the next result set
                                reader.Close();

                                // Fetch order details
                                string orderDetailsQuery = "SELECT * FROM Order_detail WHERE Order_id = @OrderId";

                                using (SqlCommand orderDetailsCommand = new SqlCommand(orderDetailsQuery, connection))
                                {
                                    orderDetailsCommand.Parameters.AddWithValue("@OrderId", OrderId);

                                    SqlDataReader orderDetailsReader = orderDetailsCommand.ExecuteReader();

                                    if (orderDetailsReader.HasRows)
                                    {
                                        DataTable dt = new DataTable();
                                        dt.Load(orderDetailsReader);

                                        rptProducts.DataSource = dt;
                                        rptProducts.DataBind();

                                        // Calculate and set total
                                        decimal total = 0;
                                        foreach (DataRow row in dt.Rows)
                                        {
                                            int price = Convert.ToInt32(row["Price"]);
                                            int quantity = Convert.ToInt32(row["Quantity"]);
                                            total += CalculateTotal(price, quantity); // Use the updated CalculateTotal method
                                            //total += price * quantity;
                                        }
                                        lblTotal.Text = total.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN")); ;
                                    }
                                }
                            }
                            else
                            {
                                // Handle the case where no order is found for the given OrderId
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle the exception appropriately, e.g., logging or displaying an error message
                }
            }
        }

        // Method to generate a unique invoice ID
        private string GenerateInvoiceID()
        {
            // Get the current timestamp
            string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");

            // Generate a random 4-digit number
            Random rnd = new Random();
            int randomNumber = rnd.Next(1000, 9999);

            // Concatenate timestamp and random number to create the invoice ID
            string invoiceID = timestamp + randomNumber.ToString();

            return invoiceID;
        }
        //protected void PrintButton_Click(object sender, EventArgs e)
        //{
        //    // Generate the invoice HTML content dynamically (you need to implement this)
        //    string invoiceHtml = GenerateInvoiceHtml();

        //    // Convert HTML to PDF
        //    byte[] pdfBytes = ConvertHtmlToPdf(invoiceHtml);

        //    // Serve the PDF as a downloadable file
        //    ServePdfAsDownload(pdfBytes);
        //}

        // Method to generate the invoice HTML content dynamically
        // Method to generate the invoice HTML content dynamically
        private string GenerateInvoiceHtml()
        {
            // Construct the HTML for the invoice dynamically
            // This is just a placeholder example
            string invoiceHtml = "<html><body><h1>Invoice</h1><p>This is a sample invoice.</p></body></html>";
            return invoiceHtml;
        }





        //GST IN INVOICE
        protected decimal CalculateCGST(decimal price)
        {
            // Calculate CGST (let's assume 9%)
            decimal cgst = price * 0.09m;
            return cgst;
        }

        protected decimal CalculateSGST(decimal price)
        {
            // Calculate SGST (let's assume 9%)
            decimal sgst = price * 0.09m;
            return sgst;
        }

        protected decimal CalculateTotal(decimal price, int quantity)
        {
            // Calculate total amount without taxes
            decimal total = price * quantity;

            // Calculate total amount with taxes (assuming 9% CGST and 9% SGST)
            decimal totalPriceWithTaxes = total + (total * 0.18m);

            return totalPriceWithTaxes;
        }

        //private decimal[] GetCartTotalPriceDetailsFromDatabase(string userId)
        //{
        //    decimal totalPrice = 0;
        //    decimal cgst = 0;
        //    decimal sgst = 0;

        //    try
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        //        using (SqlConnection connection = new SqlConnection(connectionString))
        //        {
        //            string query = "SELECT SUM(TotalC_price) FROM Cart1 WHERE user_id = @userId";
        //            using (SqlCommand command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@userId", userId);
        //                connection.Open();
        //                var result = command.ExecuteScalar();
        //                if (result != DBNull.Value)
        //                {
        //                    totalPrice = Convert.ToDecimal(result);
        //                    // Calculate CGST and SGST (8% each)
        //                    cgst = totalPrice * 0.08m;
        //                    sgst = totalPrice * 0.08m;
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Handle any exceptions
        //    }

        //    return new decimal[] { totalPrice, cgst, sgst };
        //}

        //private void UpdateTotalPriceDetails(string userId)
        //{
        //    decimal totalPrice = 0;
        //    decimal cgst = 0;
        //    decimal sgst = 0;

        //    try
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        //        using (SqlConnection connection = new SqlConnection(connectionString))
        //        {
        //            string query = "SELECT SUM(C.Quantity * P.Price) AS TotalPrice FROM Cart1 C INNER JOIN ProductsAll P ON C.ProductId = P.ProductID WHERE C.user_id = @userId";
        //            using (SqlCommand command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@userId", userId);
        //                connection.Open();
        //                var result = command.ExecuteScalar();
        //                if (result != DBNull.Value)
        //                {
        //                    totalPrice = Convert.ToDecimal(result);
        //                    cgst = totalPrice * 0.09m;
        //                    sgst = totalPrice * 0.09m;
        //                    // Calculate CGST and SGST (8% each)
        //                    totalPrice = totalPrice - (totalPrice * 0.18m);

        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Handle any exceptions
        //    }

        //    // Update the total price and taxes sections on the page
        //    litTotalPrice.Text = totalPrice.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
        //    litCGST.Text = cgst.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
        //    litSGST.Text = sgst.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));
        //    decimal totalPriceWithTaxes = totalPrice + cgst + sgst;
        //    Session["TotalPriceWithTaxes"] = totalPriceWithTaxes;

        //    litTotalWithTaxes.Text = totalPriceWithTaxes.ToString("C", CultureInfo.CreateSpecificCulture("hi-IN"));

        //}



    }

    // Method to convert HTML content to PDF
    //private byte[] ConvertHtmlToPdf(string htmlContent)
    //{
    //    // Convert HTML content to PDF using iText7 library
    //    using (MemoryStream outputStream = new MemoryStream())
    //    {
    //        ConverterProperties properties = new ConverterProperties();
    //        HtmlConverter.ConvertToPdf(htmlContent, outputStream, properties);
    //        return outputStream.ToArray();
    //    }
    //}


    //// Method to serve the PDF as a downloadable file
    //private void ServePdfAsDownload(byte[] pdfBytes)
    //{
    //    Response.Clear();
    //    Response.ContentType = "application/pdf";
    //    Response.AddHeader("content-disposition", "attachment;filename=Invoice.pdf");
    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    Response.BinaryWrite(pdfBytes);
    //    Response.End();
    //}
}







//protected void PrintButton_Click(object sender, EventArgs e)
//{
//    // Get the recipient email address
//    //string recipientEmail = GetRecipientEmail(); // Ensure this function retrieves the correct email address

//    if (!string.IsNullOrEmpty(recipientEmail))
//    {
//        // Generate the invoice content
//        string invoiceContent = GenerateInvoiceContent(); // You need to implement this method to generate the invoice content

//        // Send the email
//        SendEmail(recipientEmail, "Your Invoice", invoiceContent);
//    }
//    else
//    {
//        // Handle the case where recipient email is not available
//        // You can display an error message or handle it according to your application's logic
//        Response.Write("Recipient email not found.");
//    }

//}


//private string GenerateInvoiceContent()
//{
//    // Implement the logic to generate the invoice content here
//    // You can construct the content by retrieving data from your database or other sources
//    // and formatting it into an HTML string representing the invoice
//    // For example:
//    string invoiceContent = "<html><body><h1>Invoice Content</h1>";

//    // Add dynamic content here based on your application's data
//    // Example: invoiceContent += "<p>" + GetInvoiceDetails() + "</p>";

//    invoiceContent += "<p>This is the content of your invoice.</p></body></html>";

//    return invoiceContent;
//}



//private string GetRecipientEmail()
//{
//    // Implement the logic to retrieve the recipient's email address
//    // For example, if hypShippingEmail is a TextBox control:
//    return hypShippingEmail.Text;
//}

//private void SendEmail(string recipientEmail, string subject, string body)
//{
//    try
//    {
//        // Create a new MailMessage instance
//        MailMessage message = new MailMessage();

//        // Set the sender email address
//        message.From = new MailAddress("temkarprasad90@gmail.com");

//        // Set the recipient email address
//        message.To.Add(new MailAddress(recipientEmail));

//        // Set the subject of the email
//        message.Subject = subject;

//        // Set the body of the email
//        message.Body = body;

//        // Set the email body format to HTML
//        message.IsBodyHtml = true;

//        // Configure the SMTP client
//        SmtpClient smtp = new SmtpClient("smtp.gmail.com"); // Replace "your_smtp_host" with your SMTP host address
//        smtp.Port = 587; // Specify the SMTP port number (e.g., 587 for TLS/STARTTLS)
//        smtp.EnableSsl = true; // Enable SSL/TLS encryption if required
//        smtp.UseDefaultCredentials = false;
//        // Specify credentials if authentication is required
//        smtp.Credentials = new NetworkCredential("temkarprasad90@gmail.com", "Prasad@2004"); // Replace "your_username" and "your_password" with your SMTP credentials

//        // Send the email
//        smtp.Send(message);

//        // Optionally, you can display a success message to the user

//        // Response.Write("Invoice sent successfully!");
//    }
//    catch (Exception ex)
//    {
//        // Handle any exceptions that occur during email sending
//        // You can log the error or display an error message to the user
//        Response.Write("An error occurred while sending the invoice: " + ex.Message);
//    }
//}